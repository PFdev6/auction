require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Checking validation for user' do
    it 'Validate without attributes' do
      user = User.new(
        nickname: '',
        first_name: '',
        second_name: '',
        about_users: '',
        confirmed_at: '', 
        email: '',
        password: '',
        password_confirmation: ''
      )
      user.valid?
      expect(user).to_not be_valid
    end

    it 'Validate with attributes' do
      user = FactoryBot.create(:user)
      user.valid?
      expect(user).to be_valid
    end
  end
end
