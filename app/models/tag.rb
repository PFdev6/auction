class Tag < ApplicationRecord
    has_many :taggings
    has_many :lots, through: :taggings 
end
