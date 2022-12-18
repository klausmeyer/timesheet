module Entries
  class Manual < Base
    validates :time_manual, presence: true, allow_blank: false

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
