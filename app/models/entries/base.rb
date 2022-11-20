module Entries
  class Base < ApplicationRecord
    self.table_name = 'entries'

    belongs_to :user

    scope :sorted_for_dashboard, -> { order(Arel.sql("DATE_PART('year', date) DESC, DATE_PART('week', date) DESC, date ASC")) }

    def time_working
      raise NotImplementedError
    end

    def time_break
      raise NotImplementedError
    end

    def time_is
      raise NotImplementedError
    end

    def time_should
      raise NotImplementedError
    end

    def time_diff
      time_is - time_should
    end
  end
end
