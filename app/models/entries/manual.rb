module Entries
  class Manual < Base
    def time_working
      nil
    end

    def time_break
      nil
    end

    def time_is
      time_manual
    end

    def time_should
      0.0
    end
  end
end