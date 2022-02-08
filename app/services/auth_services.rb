class AuthServices
  include ApplicationHelper
  require 'httparty'
  BASE_URL = ENV['backoffice_url']
  USERS = {
    VES_USER: { username: ENV['VES_USER'], password: ENV['VES_PSSW'] },
    USD_USER: { username: ENV['USD_USER'], password: ENV['USD_PSSW'] }
  }.freeze

  def initialize(key: 'VES', integrator: nil)
    @key = key
    @integrator = Integrator.find(integrator)
    @options = {
      headers: {
        'Content-Type' => 'application/json'
      }
    }
  end

  def do_login_web_page
    return if auth_token("integrator_#{@integrator.id}_#{@key}").present?
    # @options.merge!({ body: USERS["#{@key}_USER".to_sym].to_json })
    @options.merge!({ body: @integrator.users[@key].to_json })
    response = HTTParty.post("#{BASE_URL}/users/token/#{@integrator.users[@key]['username']}", @options)
    data = get_response(response)[:data]

    set_auth_token("integrator_#{@integrator.id}_#{@key}", data['token'])
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
