class Api::V1::SalesController < ApplicationController
  before_action :authorized
  before_action :balance_player

  def create
    if player_has_balance
      ticket = sale_ticket(sales_params.to_h)
      render json: ticket
    else
      render json: {message: "Saldo insuficiente"}, status: 400 and return
    end
    
  end

  private

  def sale_ticket(data)
    @ticket ||= SalesServices.new.send_plays(data)
  end

  def player_has_balance
    puts @balance[:data]
    @balance[:data]["saldo_actual"].to_f > params[:monto_total].to_f
  end

  def balance_player
    @balance ||= IntegratorServices.new.get_balance(current_player)
  end
  [{"c"=>"110", "j"=>[{"i"=>1, "n"=>"01", "m"=>"50000"}]}]
  def sales_params
    params.permit(
      :monto_total,
      :ced,
      :nom,
      :fec,
      :compress,
      :app,
      :ani,
      :tip,
      :cod,
      :ani_tipo,
      :producto_id,
      :beneficiencia,
      :cda,
      :cajero_id,
      jug: [:c,j:[:i,:n,:m]]
    )
  end
end