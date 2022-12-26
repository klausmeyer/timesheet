module Entries
  class Manual < Base
    validates :time_manual, presence: true

    def time_working
      nil
    end

    def time_break
      nil
    end

    def time_is
      time_manual.to_d
    end

    def time_should
      0.0
    end
  end
end
