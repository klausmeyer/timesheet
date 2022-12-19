class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable

  after_initialize :set_defaults, if: :new_record?

  has_many :entries, dependent: :destroy, class_name: "Entries::Base"

  def set_defaults
    self.daily_working_hours = 8
  end
end
