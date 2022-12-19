class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  add_flash_types :success, :danger, :warning, :info

  helper_method :current_user

  private

  def new_entry_with_defaults
    Entries::Base.new(new_entry_defaults.merge(type: params[:type] || "Entries::General"))
  rescue ActiveRecord::SubclassNotFound
    Entries::General.new(new_entry_defaults)
  end

  def new_entry_defaults
    {
      user:       current_user,
      date:       Date.today,
      start_time: "08:00",
      end_time:   "16:30"
    }
  end
end
