class Api::V1::ReportsController < ApplicationController
  
  def lotery_results
    date_from = params[:date_from].to_time

    results = BackofficeServices.new(current_player: current_player, date_from: date_from).lotery_results

    render json: results[:data]
  end

  def consult_tickets
    date_from = params[:date_from].to_time

    tickets = Ticket.where(created_at: date_from.all_day, player_id: current_player.id)

    render json: tickets
  end

  def regulations
    render json: Product.all
  end
end
