class AuthServices
  include ApplicationHelper
  require 'httparty'

  def initialize()
    @options = {
      headers: {
        "Content-Type" => "application/json"
      }
    }
  end
  

  def do_login_web_page
    return if auth_token.present?
    
    @options.merge!({ body: { username: 'userwebtest', password: '0000' }.to_json})
    response = HTTParty.post('http://api-dev.caribeapuesta.com/users/token/userwebtest', @options)    
    data = get_response(response)[:data]

    set_auth_token(data["token"])
    return true
  end

  def get_sorteos
    @options[:headers].merge!({"Authorization" => "Bearer #{auth_token}", "Type" => "web"})
    url = "http://api-dev.caribeapuesta.com/loteries/get-sorteos"
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
