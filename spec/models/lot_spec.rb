require 'rails_helper'

RSpec.describe Lot, type: :model do
  context 'Checking validation for lot' do
    it 'Validate without attributes' do
      lot = Lot.new(
        user: nil,
        name: '', 
        description: '',
        autopurchase_price: '',
        start_price: '', 
        lot_end_date: ''
      )
      lot.valid?
      expect(lot).to_not be_valid
    end

    it 'Validate with attributes' do
      user = FactoryGirl.create(:user)
      lot = Lot.new( 
        user_id: user.id,
        name: 'test', 
        description: 'test',
        autopurchase_price: 200,
        start_price: 100, 
        lot_end_date: Time.now
      )
      expect(lot).to be_valid
    end
  end
end
