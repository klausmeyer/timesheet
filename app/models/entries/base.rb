module Entries
  class Base < ApplicationRecord
    self.table_name = "entries"

    belongs_to :user

    scope :available, -> { where(deleted_at: nil) }
    scope :sorted_for_dashboard, -> { available.order(Arel.sql("DATE_PART('year', date) DESC, DATE_PART('week', date) DESC, date ASC")) }
    scope :for, ->(year:, week:) { available.where("DATE_PART('year', date) = :year AND DATE_PART('week', date) = :week", year:, week:) }

    alias_method :really_delete, :delete

    def delete
      self.deleted_at = Time.current
      save(touch: false)
    end

    # Interface methods for calculations

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
