class ApplicationController < ActionController::API
  include ApplicationHelper
  before_action :authorized

  def current_player
    logged_in_user
  end

  def current_integrator
    Integrator.find(logged_in_user.integrator_id)
  end

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    token = request.headers['Authorization'].present? ? request.headers['Authorization'] : params[:token]
  end

  def decoded_token
    if auth_header
      if auth_header.include? "Bearer"
        token = auth_header.split(" ")[1]
      else
        token = auth_header
      end
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      player_id = JSON.parse(decoded_token[0])['id']
      @player = Player.find_by(id: player_id)
    end
    @player
  end

  def logged_in?
    logged_in_user.present?
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
