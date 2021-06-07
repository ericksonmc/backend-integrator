class Api::V1::SalesController < ApplicationController

  def create
    if player_has_balance
      if valid_plays?
        if valid_add_plays?
          #Luego de esto registro las jugadas en algun lado
          render json: add_plays
        else
          render json: { message: 'Ocurrio un error al registrar la jugada', error: '-02'}, status: 400 and return
        end
      else #si las jugadas no tienen limite
        render json: { data: plays_validates[:data]['0'], message: 'Algunas jugadas requieren atencion', error: '-03' }, status: 400 and return
      end
    else
      render json: { message: 'Recargue saldo para continuar', error: '-01' }, status: 400 and return
    end        
  end

  
  private

  def sale_ticket(data)
    @ticket ||= SalesServices.new.send_plays(data)
  end

  def player_has_balance
    balance_player[:data]["saldo_actual"].to_f > total_amount
  end

  def balance_player
    @balance_player ||= IntegratorServices.new(current_player).get_balance
  end

  def sales_params
    params[:plays].map { |p| p.permit(:number, :lotery_id, :amount)}
  end

  def total_amount
    sales_params.reduce(0) {|memo, data| memo += data[:amount].to_f}
  end

  def plays_validates
    @plays_validates ||= SalesServices.new(current_player, sales_params).validate_plays
  end

  def add_plays
    data = {
      cant_bets: sales_params.length,
      total_ammount: total_amount,
      security: 2021050220111514,
      bets: JSON.parse(sales_params.to_json)
    }
    @add_plays ||= SalesServices.new(current_player, data).add_plays
  end

  def valid_add_plays?
    add_plays
    # true
  end

  def valid_plays?
    plays_validates[:data]['0']['msj'] == "OK"
    # return true
  end
    
end