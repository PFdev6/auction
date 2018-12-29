class Message < ApplicationRecord
  belongs_to :user
  belongs_to :current_bargain
  after_create_commit do
    BroadcastMessageJob.perform_later(self)
  end
end
