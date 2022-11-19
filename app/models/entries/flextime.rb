module Entries
  class Flextime < Base
    def time_working
      0.0
    end

    def time_break
      0.0
    end

    def time_is
      0.0
    end

    def time_should
      user.daily_working_hours
    end
  end
end