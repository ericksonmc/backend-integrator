module AuthorizedHelper
  def current_player
    logged_in_user
  end

  def current_integrator
    Integrator.find(current_player.integrator_id)
  end

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    token = request.headers['Authorization'].present? ? request.headers['Authorization'] : params[:token]
  end

  def decoded_token
    return unless auth_header

    token = auth_header.include?("Bearer") ? token = auth_header.split(" ")[1] : auth_header

    begin
      JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    return unless decoded_token.present?

    player_id = JSON.parse(decoded_token[0])['id']
    @player = Player.find_by(id: player_id)
    @player
  end

  def logged_in?
    logged_in_user.present?
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
