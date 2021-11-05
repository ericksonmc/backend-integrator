class AuthServices
  include ApplicationHelper
  require 'httparty'
  BASE_URL = 'http://api-dev.caribeapuesta.com'.freeze

  def initialize()
    @options = {
      headers: {
        'Content-Type' => 'application/json'
      }
    }
  end

  def do_login_web_page
    return if auth_token.present?

    @options.merge!({ body: { username: 'userwebtest', password: '0000' }.to_json })
    response = HTTParty.post("#{BASE_URL}/users/token/userwebtest", @options)
    data = get_response(response)[:data]

    set_auth_token(data['token'])
    return true
  end

  def renew_token_auth
    redis = Redis.new
    token = redis.get('auth_token')

    return if token.blank?

    redis.del('auth_token')
    do_login_web_page
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
