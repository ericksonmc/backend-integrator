class Api::V1::AwardsController < ApplicationController
  skip_before_action :authorized
  before_action :check_awards_params, only: [:create]

  def create
    awards = params["_json"].as_json
    @awards_total = []
    @rewarded_awards = []
    begin
      ActiveRecord::Base.transaction do
        awards.each do |draw_award|
          unless exist_award?(draw_award["sorteo"]).present?
            award = Award.create({ number: draw_award["numero"], draw_id: draw_award["sorteo"] })
            if draw_award["apuestas"].present?
              draw_award["apuestas"].each do |detail|
                award.award_details.create({ticket_id: detail["id_apuesta"], amount: detail["premio"]})
              end
            end
            @awards_total << award
          else
            @award.update(info_re_award: draw_award["apuestas"], number: draw_award["numero"], status: 'updated')
            @rewarded_awards << @award
          end
        end
      end
    rescue Exception => e
      render json: { message: e.message, status: 'fail' }, status: 400 and return
    end

    render json: { message: 'Premios Recibidos', total_awards: @awards_total.length, rewarded_awards: @rewarded_awards.length, status: 'ok'}, status: 200 and return
  end

  private

  def exist_award?(draw_id)
    @award = Award.where(created_at: Time.now.all_day, draw_id: draw_id).last
  end

  def check_awards_params
    awards = params["_json"].as_json
    render json: { message: 'Parametros vacios', status: 'empty' }, status: 400 and return if awards.blank?
  end
end