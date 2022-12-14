class BackofficeServices
  include ApplicationHelper
  require 'redis'
  require 'httparty'
  BASE_URL = ENV['backoffice_url']

  def initialize(current_player: {}, plays: {}, date_from: Time.now, date_to: Time.now)
    @date_from = date_from
    @date_to = date_to
    @current_player = current_player
    @plays = plays
    set_headers
  end

  def request_sorteos
    url = "#{BASE_URL}/loteries/get-sorteos-by-lotteries"
    response = HTTParty.get(url, @options)

    get_response(response)
  rescue StandardError
    AuthServices.new(key: @current_player.currency, integrator: @current_player.integrator_id).renew_token_auth
  end

  def validate_plays
    @options.merge!({ body: @plays.to_json })
    response = HTTParty.post("#{BASE_URL}/tickets/validar", @options)

    get_response(response)
  rescue StandardError
    AuthServices.new(key: @current_player.currency, integrator: @current_player.integrator_id).renew_token_auth
  end

  def add_plays
    @options.merge!({ body: @plays.to_json })
    response = HTTParty.post("#{BASE_URL}/tickets/add", @options)
    get_response(response)
  rescue StandardError
    AuthServices.new(key: @current_player.currency, integrator: @current_player.integrator_id).renew_token_auth
  end

  def lotery_results
    parsed_date = @date_from.strftime('%Y%m%d')
    url = "#{BASE_URL}/loteries/results/#{parsed_date}"
    response = HTTParty.get(url,@options)
    get_response(response)
  rescue StandardError
    AuthServices.new(key: @current_player.currency, integrator: @current_player.integrator_id).renew_token_auth
  end

  def anull_ticket
    @options.merge!({ body: @plays.to_json })
    response = HTTParty.post("#{BASE_URL}/tickets/anull", @options)

    get_response(response)
  rescue StandardError
    AuthServices.new(key: @current_player.currency, integrator: @current_player.integrator_id).renew_token_auth
  end

  def get_response(request)
    raise 'Authentication required' if request.code == 401
    Rails.logger.info JSON.parse(request.body) if request.code != 200
    {
      data: JSON.parse(request.body),
      headers: request.headers,
      status: request.code
    }
  end

  private

  def set_headers
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Type' => 'web',
        'Authorization' => "Bearer #{auth_token("integrator_#{@current_player.integrator_id}_#{@current_player.currency}")}"
      }
    }
  end
end
