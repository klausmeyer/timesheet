class DashboardController < ApplicationController
  def show
    @entries = current_user.entries.sorted_for_dashboard
  end
end
