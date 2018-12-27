class Message < ApplicationRecord
  #belongs_to :user
  after_create_commit do
     BroraoadcastMessageJob.perform_later self
  end
  #after_create { BroadcastMessageJob.perform_now self }
end
