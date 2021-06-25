class Api::V1::AuthController < ApplicationController
  require 'redis'
  before_action :authorized, only: [:auto_login]

  def create
    if integrator.present? and integrator.status
      token = encode_token(player.to_json)
      if player.present? and 
        render json: {token: token, url: "#{base_url}/#{token}"}, status: 200 and return
      else
        render json: {message: 'Error al logear al jugador'}, status: 400 and return
      end
    else
      render json: {message: 'Integrador no encontrado o esta inactivo'}, status: 400 and return
    end
  end

  def auto_login
    balance = IntegratorServices.new(current_player).get_balance

    render json: {
      player: current_player,
      producst: sorteos,
      lottery_setup: lottery_setup,
      saldo_actual: balance[:data]["saldo_actual"]
    }
  end
  
  private

  def lottery_setup
    LotterySetup.select(:mmt,:mpj,:jpt,:mt).last
  end

  def player
    @player = Player.find_by(email: params[:email], integrator_id: params[:integrator_id])
    unless @player.present?
      @player = Player.create(player_params)
    end
    set_token
    @player
  end

  def set_token
    return if auth_token.present?

    auth_service = AuthServices.new.do_login_web_page

    unless auth_service
      render json: { message: "Hubo un problema obtener al generar el token" }, status: 400 and return
    end
  end

  def sorteos
    @sorteos ||= BackofficeServices.new.get_sorteos[:data]['0']
  end

  def player_params
    params.permit(
      :email,
      :player_id,
      :company,
      :site,
      :integrator_id
    )
  end
end
