class CurrentBargain < ApplicationRecord
  scope :in_process, -> { where(played_out: false) }  
  has_one :delayed_job, dependent: :delete
  has_many :messages, dependent: :delete_all
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot

  searchkick word_start: [:name, :user, :description], word_middle:[:name, :user, :description]
  scope :search_import, -> { includes(:users, :lot) }
  def search_data
    {
      name: lot.name,
      user: user.nickname,
      description: lot.description
    }
  end
end
