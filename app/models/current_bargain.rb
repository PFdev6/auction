class CurrentBargain < ApplicationRecord
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot
end
