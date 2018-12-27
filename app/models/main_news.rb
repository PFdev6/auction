class MainNews < ApplicationRecord
  searchkick

  belongs_to :user
  validates :title, :description, presence: true 
end
