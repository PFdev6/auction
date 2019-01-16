class CurrentBargain < ApplicationRecord
  include Clearable

  scope :in_process, -> { where(played_out: false) }  
  has_many :messages, dependent: :delete_all
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :lot

  searchkick word_start: [:name, :user, :description],
    word_middle: [:name, :user, :description],
    text_end: [:name, :user, :description]

  scope :search_import, -> { includes(:users, :lot) }
  def search_data
    {
      name: lot.name,
      user: user.nickname,
      description: lot.description
    }
  end 

  after_update do
    BroadcastUpdateBargain.call(bargain: self)
  end
end
