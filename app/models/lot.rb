class Lot < ApplicationRecord
  belongs_to :user
  #belongs_to :current_bargain
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :main_image, styles: { medium: '300x500', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
 	validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\z/
  validates :name, :description, :start_price, :main_image, :lot_end_date, presence: true 

	after_save do
		if self.isplayedout?
      #self.current_bargain =
       CurrentBargain.create(lot_id: self.id, user_id: self.user.id, current_price: self.start_price)   
    else 
      if CurrentBargain.where(lot_id: self) # need correct 
        CurrentBargain.where(lot_id: self).destroy_all
      end
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

end
