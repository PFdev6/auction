class Message < ApplicationRecord
  belongs_to :user
  belongs_to :current_bargain
end
