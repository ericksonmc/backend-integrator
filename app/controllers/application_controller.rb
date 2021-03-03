class ApplicationController < ActionController::API
  include ApplicationHelper
  before_action :authorized

  def current_player
    logged_in_user
  end

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    # request.headers['Authorization']
    params[:token]
  end

  def decoded_token
    if auth_header
      token = auth_header
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
