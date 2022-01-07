class AuthServices
  include ApplicationHelper
  require 'httparty'
  BASE_URL = ENV['backoffice_url']
  USERS = {
    VES_USER: { username: ENV['VES_USER'], password: ENV['VES_PSSW'] },
    USD_USER: { username: ENV['USD_USER'], password: ENV['USD_PSSW'] }
  }.freeze

  def initialize(key: 'VES')
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
    response = HTTParty.post("#{BASE_URL}/users/token/#{USERS["#{@key}_USER".to_sym][:username]}", @options)
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
