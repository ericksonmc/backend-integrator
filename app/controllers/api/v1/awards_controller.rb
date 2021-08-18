class Api::V1::AwardsController < ApplicationController
  skip_before_action :authorized
  before_action :check_awards_params, only: [:create]
  after_action :excute_award_daemon, only: [:create]

  def create
    awards = params['_json'].as_json
    @awards_total = []
    @rewarded_awards = []
    @bets_awards = []
    byebug
    begin
      ActiveRecord::Base.transaction do
        awards.each do |draw_award|
          if exist_award?(draw_award['sorteo']).present?
            @award.update(info_re_award: draw_award['apuestas'], number: draw_award['numero'], status: 'updated')
            @rewarded_awards << @award
          else
            award = Award.create({ number: draw_award['numero'], draw_id: draw_award['sorteo'] })
            if draw_award['apuestas'].present?
              award_details = draw_award['apuestas'].map do |detail|
                {
                  ticket_id: detail['id_apuesta'],
                  amount: detail['premio'],
                  award_id: award.id,
                  created_at: Time.now,
                  updated_at: Time.now
                }
              end
              AwardDetail.insert_all(award_details)
              @bets_awards.concat award_details
            end
            @awards_total << award
          end
        end
        updated_amount_awards(@bets_awards)
      end
    rescue Exception => e
      render json: { message: e.message, status: 'fail' }, status: 400 and return
    end

    render json: { message: 'Premios Recibidos',
                   total_awards: @awards_total.length,
                   rewarded_awards: @rewarded_awards.length,
                   status: 'ok' }, status: 200 and return
  end

  private

  def exist_award?(draw_id)
    @award = Award.where(created_at: Time.now.all_day, draw_id: draw_id).last
  end

  def excute_award_daemon
    PaymentAwardsWorker.perform_async(awards: @awards_total, rewarded_awards: @rewarded_awards)
  end

  def check_awards_params
    awards = params['_json'].as_json
    render json: { message: 'Parametros vacios', status: 'empty' }, status: 400 and return if awards.blank?
  end

  def updated_amount_awards(bets_awards)
    tickets_to_pay = bets_awards.pluck(:ticket_id).uniq.map{ |ticket_id|
      {
        ticket_id: ticket_id,
        premio: bets_awards.select{ |award|
          award[:ticket_id] == ticket_id
        }.inject(0) { |sum,hash| sum + hash[:amount].to_f }
      }
    }

    tickets_to_pay.each{ |tickets_pay|
      PaymentAwardsWorker.perform_async(tickets_pay)
    }
  end
end