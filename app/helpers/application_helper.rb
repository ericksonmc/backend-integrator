module ApplicationHelper
  include AuthorizedHelper
  include SorteosHelper
  require 'redis'
  
  def base_url
    if Rails.env == "development"
      "http://localhost:3000"
    elsif Rails.env == "production"
      "http://iframe.caribeapuesta.com/"
    end
  end

  def auth_token(key)
    @redis = Redis.new
    @redis.get(key)
  end

  def set_auth_token(key, token)
    @redis = Redis.new
    @redis.set(key, token)
    @redis.expireat(key, Time.now.end_of_day.to_i)
  end
end
