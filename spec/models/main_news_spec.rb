require 'rails_helper'

RSpec.describe MainNews, type: :model do
  context "Checking validation for main_news" do
    it 'Validate without attributes' do
      news = MainNews.new(
        user: nil,
        title: '',
        description: '',
      )
      news.valid?
      expect(news).to_not be_valid
    end

    it 'Validate with attributes' do
      user = FactoryGirl.create(:user)
      news = MainNews.new( 
        user_id: user.id,
        title: 'test',
        description: 'test',
      )
      expect(news).to be_valid
    end
  end
end
