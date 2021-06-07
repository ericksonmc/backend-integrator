class ApplicationController < ActionController::API
  include ApplicationHelper
  before_action :authorized

end
