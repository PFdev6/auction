class Lot < ApplicationRecord
  include Clearable, Checkable

  belongs_to :user
  has_one :current_bargain, dependent: :delete
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings
  validates :name,:autopurchase_price, :description, :start_price, :lot_end_date, presence: true 
  has_attached_file :main_image, styles: { medium: "300x350>", thumb: "100x100>" }, default_url: '/images/missing.png'
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\z/
  
  has_attached_file :first_additional_image, styles: { medium: '300x500>', thumb: '100x100>' }, default_url: '/images/missing.png'
  validates_attachment_content_type :first_additional_image, content_type: /\Aimage\/.*\z/ 
  
  has_attached_file :second_additional_image, styles: { medium: '300x500>', thumb: '100x100>' }, default_url: '/images/missing.png'
 	validates_attachment_content_type :second_additional_image, content_type: /\Aimage\/.*\z/

  searchkick word_start: [:name, :user, :description], word_middle:[:name, :user, :description]
  scope :search_import, -> { includes(:tags, :user, :current_bargain, :taggings) }
  
  def search_data
    {
      name: name,
      user: user.nickname,
      description: description
    }
  end

  after_save do
    current_bargain = CurrentBargain.find_by(lot_id: self)
    if self.inprocess?
      clear_job(current_bargain)
      
      if current_bargain.nil?
        current_bargain = CurrentBargain.create(lot_id: self.id, user_id: self.user.id, current_price: self.start_price)
        bargain_id = current_bargain.id
        self.current_bargain_id = bargain_id
      else
        bargain_id = current_bargain.id
      end

      id_job = DeterminingTheWinnerJob.set(wait_until: current_bargain.lot.lot_end_date).perform_later(current_bargain).provider_job_id
      current_bargain.update_attributes(delayed_job_id: id_job) 
    else 
      clear_job(current_bargain)
    end
  end

  def files=(array_files = [])
  end

  def load_imgs(files)
    if(files)
      self.update(main_image: files[0], first_additional_image: files[1], second_additional_image: files[2])
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
