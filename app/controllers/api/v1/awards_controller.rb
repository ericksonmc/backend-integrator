class Api::V1::AwardsController < ApplicationController
  skip_before_action :authorized
  before_action :check_awards_params, only: [:create]

  def create
    awards = params['_json'].as_json
    @awards_total = []
    @rewarded_awards = []
    @bets_awards = []
    begin
      ActiveRecord::Base.transaction do
        awards.each do |draw_award|
          exist = exist_award?(draw_award['sorteo']).present?
          if exist
            @award.update(info_re_award: draw_award['apuestas'], number: draw_award['numero'], status: 'updated')
            @award.award_details.update_all(status: 'pending_revert')
            @rewarded_awards << @award.id
          else
            @award = Award.create({ number: draw_award['numero'], draw_id: draw_award['sorteo'] })
          end

          award_details = draw_award['apuestas']&.map do |detail|
            {
              ticket_id: Bet.find_by(remote_bet_id: detail['id_apuesta']).ticket_id,
              bet_id: detail['id_apuesta'],
              amount: detail['premio'],
              award_id: @award.id,
              reaward: exist,
              created_at: Time.now,
              updated_at: Time.now
            }
          end

          AwardDetail.insert_all(award_details)
          @bets_awards.concat award_details

          @awards_total << @award
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

  def check_awards_params
    awards = params['_json'].as_json
    render json: { message: 'Parametros vacios', status: 'empty' }, status: 400 and return if awards.blank?
  end

  # bets_awards ticket_id bet_id amount award_id reaward
  def updated_amount_awards(bets_awards)
    tickets_to_pay = bets_awards.pluck(:ticket_id).uniq.map { |ticket_id|
      {
        ticket_id: ticket_id,
        premio: bets_awards.select { |bet| bet[:ticket_id] == ticket_id }.inject(0) { |sum, hash|
          sum + hash[:amount].to_f
        }
      }
    }

    if @rewarded_awards.present?
      @rewarded_awards.each do |reward|
        awards_to_rever = Award.find(reward).award_details.where(status: 'pending_revert')
        awards_to_rever.each do |award_detail_to_revert|
          RevertAwardsWorker.perform_async(award_detail_to_revert.attributes)
        end
      end
    end

    tickets_to_pay.each{ |tickets_pay|
      PaymentAwardsWorker.perform_async(tickets_pay)
    }
  end
end
