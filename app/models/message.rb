class Message < ApplicationRecord
  after_create_commit do
    BroadcastMessageJob.perform_later(self)
  end
end
