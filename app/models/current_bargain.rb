class CurrentBargain < ApplicationRecord
  include Clearable

  scope :in_process, -> { where(played_out: false) }  
  has_many :messages, dependent: :delete_all
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :lot
  after_update do
    BroadcastUpdateBargain.call(bargain: self)
  end
end
