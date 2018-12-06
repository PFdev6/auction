class SessionLot < ApplicationRecord
  belongs_to :user
  has_many :users
  has_one :lot
end
