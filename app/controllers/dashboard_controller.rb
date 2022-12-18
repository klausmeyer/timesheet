class DashboardController < ApplicationController
  def show
    @entry   = new_entry_with_defaults
    @entries = current_user.entries.sorted_for_dashboard
  end
end
