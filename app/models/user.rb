class User < ApplicationRecord
  after_initialize :set_defaults, if: :new_record?

  has_many :entries, dependent: :destroy, class_name: 'Entries::Base'

  def set_defaults
    self.daily_working_hours = 8
  end
end
