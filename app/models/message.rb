class Message < ApplicationRecord
  belongs_to :user
  belongs_to :current_bargain
  
  after_create_commit do
    #Model.BroadcastMessageJob.perform_now(self)
  end
end
