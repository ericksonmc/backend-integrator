class Api::V1::AuthController < ApplicationController
  before_action :authorized, only: [:auto_login]
  before_action :check_if_player_exist, only: [:login]

  def login
    token = encode_token(@player.to_json)
    if @player.integrator_id.present?
      render json: {token: token, url: "#{base_url()}/api/v1/auth/auto_login?token=#{token}"}, status: 200 and return
    else
      render json: {message: 'Error al logear al jugador'}, status: 400 and return
    end
  end

  def auto_login
    render json: {
      player: current_player,
      producst: products,
      lottery_setup: lottery_setup,
      saldo_actual: 500000
    }
  end
  
  private
  def products
    [
      {
        "id":5,
        "nombre":"Zulia",
        "sorteos":[
          {"id":26,"nombre":"Zulia12A","nombre_largo":"Triple Zulia A 12:45PM","horac_ls":"12:40","horac_d":""},
          {"id":27,"nombre":"Zulia12B","nombre_largo":"Triple Zulia B 12:12PM","horac_ls":"12:40","horac_d":""},
          {"id":68,"nombre":"Zulia12C","nombre_largo":"Triple Zulia C 12:45PM","horac_ls":"12:40","horac_d":""},
          {"id":28,"nombre":"Triptz-12","nombre_largo":"Zulia Tripletazo 12:45M","horac_ls":"12:40","horac_d":""},
          {"id":29,"nombre":"Zulia 4A","nombre_largo":"Triple Zulia A 4:00PM","horac_ls":"16:40","horac_d":""},
          {"id":30,"nombre":"Zulia 4B","nombre_largo":"Triple Zulia B 4:00PM","horac_ls":"16:40","horac_d":""},
          {"id":69,"nombre":"Zulia 4C","nombre_largo":"Triple Zulia C 4:00PM","horac_ls":"16:40","horac_d":""},
          {"id":31,"nombre":"Triptz-4","nombre_largo":"Zulia Tripletazo 4:00PM","horac_ls":"16:40","horac_d":""},
          {"id":23,"nombre":"Zulia 7A","nombre_largo":"Triple Zulia A 7:00PM","horac_ls":"18:50","horac_d":"18:50"},
          {"id":25,"nombre":"Zulia 7B","nombre_largo":"Triple Zulia A 7:00PM","horac_ls":"18:50","horac_d":"18:50"},
          {"id":70,"nombre":"Zulia 7C","nombre_largo":"Triple Zulia C 7:00PM","horac_ls":"18:50","horac_d":"18:50"},
          {"id":24,"nombre":"Triptz-7","nombre_largo":"Zulia tripletazo 7:00PM","horac_ls":"18:50","horac_d":"18:50"}
        ]
      }
    ]
  end

  def lottery_setup
    LotterySetup.select(:mmt,:mpj,:jpt,:mt).last
  end

  def check_if_player_exist
    @player = Player.find_by(email: params[:email], integrator_id: params[:integrator_id])
    unless @player.present?
      @player = Player.create(player_params)
    end
  end

  def player_params
    params.permit(
      :email,
      :cedula,
      :player_id,
      :company,
      :site,
      :integrator_id
    )
  end
end
