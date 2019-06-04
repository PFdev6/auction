# string "name"
# text "description"
# decimal "start_price"
# string "main_image_file_name"
# string "main_image_content_type"
# integer "main_image_file_size"
# datetime "main_image_updated_at"
# datetime "lot_end_date"
# datetime "created_at", null: false
# datetime "updated_at", null: false
# integer "user_id"
# string "first_additional_image_file_name"
# string "first_additional_image_content_type"
# integer "first_additional_image_file_size"
# datetime "first_additional_image_updated_at"
# string "second_additional_image_file_name"
# string "second_additional_image_content_type"
# integer "second_additional_image_file_size"
# datetime "second_additional_image_updated_at"
# integer "current_bargain_id"
# decimal "autopurchase_price"
# boolean "inprocess", default: true
# index ["current_bargain_id"], name: "index_lots_on_current_bargain_id"
class Lot < ApplicationRecord
  include Clearable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  __elasticsearch__.client = Elasticsearch::Client.new :log => true

  settings do
    mappings dynamic: true do
      indexes :description, type: :text, analyzer: :english
      indexes :name, type: :string, analyzer: :english
      indexes :autopurchase_price, type: :decimal
      indexes :start_price, type: :decimal
    end
  end

  belongs_to :user
  has_one :current_bargain, dependent: :delete
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings
  validates :name, :autopurchase_price, :description, :start_price, :lot_end_date, presence: true 
  has_attached_file :main_image, styles: { medium: "300x350>", thumb: "100x100>" }, default_url: ':style/missing.png'
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\z/
  
  has_attached_file :first_additional_image, styles: { medium: '300x500>', thumb: '100x100>' }, default_url: '/images/missing.png'
  validates_attachment_content_type :first_additional_image, content_type: /\Aimage\/.*\z/ 
  
  has_attached_file :second_additional_image, styles: { medium: '300x500>', thumb: '100x100>' }, default_url: '/images/missing.png'
 	validates_attachment_content_type :second_additional_image, content_type: /\Aimage\/.*\z/

  before_destroy do
    clear_job(self.current_bargain)
  end

  after_save do
    current_bargain = CurrentBargain.find_by(lot_id: self)
    clear_job(current_bargain)
    if self.inprocess?
      if current_bargain.nil?
        current_bargain = CurrentBargain.create(
          lot: self, 
          user: self.user, 
          current_price: self.start_price
        )
        self.current_bargain = current_bargain
      else
        BroadcastMessage.call(bargain: current_bargain)
        id_job = DeterminingTheWinnerJob
          .set(wait_until: current_bargain.lot.lot_end_date)
          .perform_later(current_bargain)
          .provider_job_id
        current_bargain.update_attributes(delayed_job_id: id_job, played_out: false)
      end  
    end
  end

  def files=(array_files = [])
  end

  def load_imgs(files)
    if(files)
      self.update(
        main_image: files[0], 
        first_additional_image: files[1], 
        second_additional_image: files[2]
        )
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

  def as_indexed_json(options={})
    {
        name: self.name,
        description: self.description,
        autopurchase_price: self.autopurchase_price,
        start_price: self.start_price
      }.as_json
  end
end
