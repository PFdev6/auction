class CurrentBargain < ApplicationRecord
  belongs_to :user
  has_many :users
  belongs_to :lot
end
