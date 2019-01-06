class Tag < ApplicationRecord
  
  has_many :taggings
  has_many :lots, through: :taggings
      
  def self.counts
    self.select('name, count(taggings.tag_id) as count').joins(:taggings).group("name")
  end

end
  