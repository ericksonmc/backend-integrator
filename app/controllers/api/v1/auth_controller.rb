class Api::V1::AuthController < ApplicationController
  require 'redis'
  before_action :authorized, only: [:auto_login]

  def create
    render json: { message: 'Integrador no encontrado o esta inactivo' }, status: 400 and return unless valid_integrator
    byebug
    render json: { token: token, url: "#{base_url}/login/#{token}" }, status: 200 and return if player.present?

    render json: { message: 'Error al obtener la informacion del jugador' }, status: 400 and return
  end

  def auto_login
    balance = IntegratorServices.new(current_player).request_balance

    render json: {
      player: current_player,
      producst: sorteos,
      lottery_setup: lottery_setup,
      saldo_actual: balance[:data]['monto']
    }
  end

  private

  def valid_integrator
    integrator.present? && integrator.status
  end

  def lottery_setup
    LotterySetup.select(:mmt,:mpj,:jpt,:mt).last
  end

  def token
    @token ||= encode_token(player.to_json)
  end

  def player
    @player = Player.find_by(email: params[:email], integrator_id: params[:integrator_id])
    @player = Player.create(player_params) unless @player.present?
    set_token
    @player
  end

  def set_token
    byebug
    return if auth_token("#{@player.currency}").present?

    auth_service = AuthServices.new(key: "#{@player.currency}").do_login_web_page
    render json: { message: 'Hubo un problema obtener al generar el token' }, status: 400 and return unless auth_service
  end

  def sorteos
    redis = Redis.new
    byebug
    if redis.get('sorteos').present?
      sorteos = redis.get('sorteos')
      @sorteos ||= JSON.parse(sorteos)
    else
      @sorteos ||= BackofficeServices.new(current_player: @player).request_sorteos[:data]['0']
      redis.set('sorteos', @sorteos.to_json)
      redis.expireat('sorteos', Time.now.end_of_day.to_i)
    end
  end

  def integrator
    @integrator = Integrator.find_by(id: player.integrator_id)
  end

  def player_params
    params.permit(
      :email,
      :player_id,
      :company,
      :site,
      :integrator_id,
      :currency
    )
  end
end
