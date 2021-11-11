class AuthServices
  include ApplicationHelper
  require 'httparty'
  BASE_URL = 'http://api-dev.caribeapuesta.com'.freeze
  USERS = {
    VES_USER: { username: 'TESTPRODBS', password: '123456' },
    USD_USER: { username: 'TESTPROD', password: '123456' }
  }.freeze

  def initialize(key: 'VES_token')
    @key = key
    @options = {
      headers: {
        'Content-Type' => 'application/json'
      }
    }
  end

  def do_login_web_page
    return if auth_token(@key).present?

    @options.merge!({ body: USERS["#{@key}_USER".to_sym].to_json })
    # byebug
    response = HTTParty.post("#{BASE_URL}/users/token/userwebtest", @options)
    data = get_response(response)[:data]

    set_auth_token(@key, data['token'])
    return true
  end

  def renew_token_auth
    redis = Redis.new
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
