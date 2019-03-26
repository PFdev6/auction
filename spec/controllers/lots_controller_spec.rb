require 'rails_helper'

RSpec.describe LotsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
  end
  describe 'POST lot#create' do
    context 'When params is valid' do
      it "increase count of lots by 1 and render lot action show" do
        expect {
          post(:create, params: 
            {
              lot:
              { 
                files: "qweqweqwe",
                name: "name",
                start_price: 10,
                autopurchase_price: 200,
                lot_end_date: Time.new('2000'),
                description: "description"
                }})}.to change(Lot, :count).by(1)
      end
    end
    context 'When params is invalid' do
      it 'increase count of lots by 0 and should be error' do
        expect {
            post(:create, params: { lot: { 
                name: "",
                start_price: 10,
                autopurchase_price: 200,
                lot_end_date: Time.new('2000'),
                description: "description"
            }})
          }.to change(Lot, :count).by(0)
      end
    end
  end
end