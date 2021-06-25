class BackofficeServices
  include ApplicationHelper
  require 'redis'
  require 'httparty'

  def initialize(current_player: {}, plays: {}, date_from: Time.now, date_to: Time.now)
    @date_from = date_from
    @date_to = date_to
    @current_player = current_player
    @plays = plays
    @options = {
      headers: {
        "Content-Type" => 'application/json',
        "Type" => "web",
        "Authorization" => "Bearer #{auth_token}"
      }
    }
  end

  def get_sorteos
    url = "http://api-dev.caribeapuesta.com/loteries/get-sorteos"
    response = HTTParty.get(url,@options)
    
    return get_response(response)

  rescue StandardError
   AuthServices.new.renew_token_auth
  end

  def validate_plays
    @options.merge!({ body: @plays.to_json })
    response = HTTParty.post('http://api-dev.caribeapuesta.com/tickets/validar',
      @options
    )

    return get_response(response)
  
  rescue StandardError
    AuthServices.new.renew_token_auth
  end

  def add_plays
    @options.merge!({ body: @plays.to_json })
    response = HTTParty.post('http://api-dev.caribeapuesta.com/tickets/add',
      @options
    )

    return get_response(response)

  rescue StandardError
    AuthServices.new.renew_token_auth
  end

  def lotery_results
    byebug
    parsed_date = @date_from.strftime("%Y%m%d")
    url = "http://api-dev.caribeapuesta.com/loteries/results/#{parsed_date}"
    response = HTTParty.get(url,@options)
    byebug
    return get_response(response)

  rescue StandardError
    AuthServices.new.renew_token_auth
  end

  
  def get_response(request)
    raise 'Authentication required' if request.code == 401
    
      {
        data: JSON.parse(request.body),
        headers: request.headers,
        status: request.code
      }
  end

end