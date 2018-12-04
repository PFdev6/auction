class Lot < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings   
  has_attached_file :main_image, styles: { medium: '400x200>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
 	validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\z/
  validates :name, :description, :start_price,:main_image, presence: true 

  def all_tags
    self.tags.map(&:name).join(', ')
  end


  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

end
