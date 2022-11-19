class User < ApplicationRecord
  has_many :entries, dependent: :destroy, class_name: 'Entries::Base'
end
