class Tagging < ApplicationRecord
  belongs_to :lot
  belongs_to :tag
end
