module ApplicationHelper
  def base_url
    if Rails.env == "development"
      "http://localhost:4016"
    elsif Rails.env == "production"
      "http://138.197.97.45:4016"
    end
  end
end
