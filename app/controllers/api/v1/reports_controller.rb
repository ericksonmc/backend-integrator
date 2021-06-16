class Api::V1::ReportsController < ApplicationController
  
  def lotery_results
    date_from = params[:date_from]

    results = BackofficeServices.new(date_from: date_from).lotery_results

    render json: results[:data]
  end

  def conult_tickets
    date_from = params[:date_from].to_time
    date_to = params[:date_to].to_time

    tickets = Ticket.where(created_at: date_from.beginning_of_day..date_to.end_of_day)

    render json: tickets
  end
end
