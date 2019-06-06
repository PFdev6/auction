class User < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  USER_ES_SETTING = {
    index: {
      number_of_shards: 1
    },
    analysis: {
      filter: {
        user_nGram: {
          type: 'ngram',
          min_gram: 4,
          max_gram: 8
        }
      },
      analyzer: {
        user_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: [
            'lowercase', 'english_morphology', 'user_nGram'
          ]
        }
      }
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
    mappings dynamic: 'true' do
      indexes :nickname, type: :string
      indexes :first_name, type: :string
      indexes :second_name, type: :string
      indexes :email, type: :string
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
