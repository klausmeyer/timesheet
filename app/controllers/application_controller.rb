class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :warning, :info

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.first
  end
end
