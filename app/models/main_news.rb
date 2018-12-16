class MainNews < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ElasticAnalyzer
  include EsHelper
  settings ES_SETTING do
  mappings dynamic: 'true' do
    indexes :title, type: 'string', analyzer: 'my_analyzer'
    indexes :description, type: 'string', analyzer: 'my_analyzer'
  end
end
  belongs_to :user
  validates :title, :description, presence: true 
end
