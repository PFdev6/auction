class Lot < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings
  validates :name, :description, :start_price, :lot_end_date, presence: true 
  has_attached_file :main_image, styles: { medium: '300x500', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\z/
  
  has_attached_file :first_additional_image, styles: { medium: '300x500', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :first_additional_image, content_type: /\Aimage\/.*\z/ 
  
  has_attached_file :second_additional_image, styles: { medium: '300x500', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
 	validates_attachment_content_type :second_additional_image, content_type: /\Aimage\/.*\z/

  before_destroy do
    CurrentBargain.where(lot_id: self).delete_all
  end

  after_save do
    current_bargain =  CurrentBargain.where(lot_id: self)
    if current_bargain.size == 0 && self.isplayedout?
       self.update(current_bargain_id: CurrentBargain.create(lot_id: self.id, user_id: self.user.id, current_price: self.start_price))   
    else 
      if current_bargain && !self.isplayedout?
        current_bargain.destroy_all
      end
    end
  end

  def files=(array_files = [])
  end

  def load_imgs(files)
    self.update(main_image: files[0], first_additional_image: files[1], second_additional_image: files[2])
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
