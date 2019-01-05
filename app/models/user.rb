class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "300x300>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :nickname, 
    :email, 
    :first_name, 
    :second_name,
    presence: true   
  devise  :confirmable, 
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

end
