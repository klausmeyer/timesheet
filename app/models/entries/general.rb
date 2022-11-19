module Entries
  class General < Base
    with_options presence: true, allow_blank: false do
      validates :start_time
      validates :end_time
    end

    def time_working
      ((end_time - start_time) / 1.hour)
    end

    def time_break
      if time_working > 9
        1.0
      elsif time_working > 6
        0.5
      else
        0.0
      end
    end

    def time_is
      time_working - time_break
    end

    def time_should
      user.daily_working_hours
    end
  end
end