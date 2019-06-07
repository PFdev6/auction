class User < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  USER_ES_SETTING = {
    index: {
      number_of_shards: 1
    }
  }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :nickname,
            :email,
            :first_name,
            :second_name,
            presence: true
  devise :confirmable,
         :database_authenticatable,
         :omniauthable,
         :recoverable,
         :rememberable,
         :registerable,
         :trackable,
         :validatable
  has_many :lots, dependent: :destroy
  has_many :main_news, dependent: :destroy
  has_many :messages, dependent: :destroy

  settings USER_ES_SETTING do
    mappings dynamic: 'false' do
      indexes :first_name, analyzer: 'english', index_options: 'offsets'
      indexes :second_name, analyzer: 'english', index_options: 'offsets'
      indexes :email, analyzer: 'english', index_options: 'offsets'
      indexes :about_users, type: :text
      indexes :likes, type: :integer
    end
  end

  def as_indexed_json(options={})
    {
      nickname: self.nickname,
      first_name: self.first_name,
      second_name: self.second_name,
      email: self.email,
      about_users: self.about_users,
      likes: self.likes
    }.as_json
  end
end
