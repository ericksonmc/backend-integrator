module ApplicationHelper
  def base_url
    if Rails.env == "development"
      "http://localhost:4016"
    elsif Rails.env == "production"
      "http://34.227.3.72:4016"
    end
  end
end
