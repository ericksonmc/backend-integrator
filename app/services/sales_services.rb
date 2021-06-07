class SalesServices
  include ApplicationHelper
  require 'redis'
  require 'httparty'

  def initialize(player, plays)
    @player = player
    @plays = plays
    @options = {
      headers: {
        "Content-Type" => 'application/json',
        "Type" => "web",
        "Authorization" => "Bearer #{auth_token}"
      }
    }
  end

  def validate_plays
    @options.merge!({ body: @plays.to_json })
    response = HTTParty.post('http://api-dev.caribeapuesta.com/tickets/validar',
      @options
    )

    return get_response(response)
  end

  def add_plays
    @options.merge!({ body: @plays.to_json })
    response = HTTParty.post('http://api-dev.caribeapuesta.com/tickets/add',
      @options
    )

    return get_response(response)
  end

  def get_response(request)
    {
      data: JSON.parse(request.body),
      headers: request.headers,
      status: request.code
    }
  end

end