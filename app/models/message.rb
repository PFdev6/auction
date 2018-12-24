class Message < ApplicationRecord
  after_create_commit { BroadcastMessageJob.perform_now self }
end
