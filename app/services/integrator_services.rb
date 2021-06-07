class IntegratorServices
  include ApplicationHelper
  require 'httparty'

  def initialize(player)
    @player = player
    @options = {
      headers: {
        "Content-Type" => "application/json",
        # "Authorization" => "Bearer #{auth_token}"
      }
    }
  end
  

  def get_balance
    integrator = Integrator.find(@player.integrator_id)
    url = "#{integrator.setting_apis["balance"]["url"]}#{@player.player_id}"
    response = HTTParty.get(url,@options)
    
    return { data: { "saldo_actual" => 5000000 } }
    return get_response(response)
  end

  private
  
  def get_response(request)
    {
      data: JSON.parse(request.body),
      headers: request.headers,
      status: request.code
    }
  end
end
