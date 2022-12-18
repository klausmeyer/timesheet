class DashboardController < ApplicationController
  def show
    @entry   = Entries::General.new(new_entry_defaults)
    @entries = current_user.entries.sorted_for_dashboard
  end

  private

  def new_entry_defaults
    {
      user:       current_user,
      date:       Date.today,
      start_time: "08:00",
      end_time:   "16:30"
    }
  end
end
