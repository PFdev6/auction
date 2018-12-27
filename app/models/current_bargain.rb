class CurrentBargain < ApplicationRecord
  searchkick
  scope :search_import, -> { includes(:users, :lot) }
  
  belongs_to :user
  has_many :users
  has_one :delayed_job, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot
end
