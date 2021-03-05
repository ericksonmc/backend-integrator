class IntegratorServices
  include ApplicationHelper
  require 'httparty'

  def initialize
    @options = {
      headers: {
        "apikey" => "a3f49d96b737a2271af304fd3162b062",
        "Content-Type" => "application/json"
      }
    }
  end
  

  def get_balance(player)
    
    integrator = Integrator.find(player.integrator_id)
    url = "#{integrator.setting_apis["balance"]["url"]}#{player.player_id}"
    response = HTTParty.get(url,@options)

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
