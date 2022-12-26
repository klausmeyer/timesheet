module Entries
  class General < Base
    with_options presence: true do
      validates :start_time
      validates :end_time
    end

    def time_working
      ((end_time - start_time) / 1.hour)
    end

    def time_break
      hours = 0.00
      hours = 0.50 if time_working > 6.0
      hours = 0.75 if time_working > 9.0
      hours
    end

    def time_is
      (time_working - time_break)
    end

    def time_should
      user.daily_working_hours
    end
  end
end
