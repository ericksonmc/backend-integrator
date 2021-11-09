module ApplicationHelper
  def base_url
    if Rails.env == "development"
      "http://localhost:4016"
    elsif Rails.env == "production"
      "http://138.197.97.45:4016"
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
