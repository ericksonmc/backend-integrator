module ApplicationHelper
  include AuthorizedHelper
  include SorteosHelper
  require 'redis'
  
  def base_url
    if Rails.env == "development"
      "http://localhost:3000"
    elsif Rails.env == "production"
      "http://138.197.97.45:3001"
    end
  end

  def auth_token
    @redis = Redis.new
    @redis.get('auth_token')
  end

  def set_auth_token(token)
    @redis = Redis.new
    @redis.set('auth_token', token)
    @redis.expireat('auth_token', Time.now.end_of_day.to_i)
  end
end
