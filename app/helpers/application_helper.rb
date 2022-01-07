module ApplicationHelper
  include AuthorizedHelper
  include SorteosHelper
  require 'redis'

  def base_url
    ENV['iframe_url']
  end

  def auth_token(key)
    @redis = Redis.new
    @redis.get(token_key(key))
  end

  def set_auth_token(key, token)
    @redis = Redis.new
    @redis.set(token_key(key), token)
    @redis.expireat(token_key(key), Time.now.end_of_day.to_i)
  end

  def token_key(key)
    return 'VES_token' if key.nil?

    "#{key}_token"
  end
end
