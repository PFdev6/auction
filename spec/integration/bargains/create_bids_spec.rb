require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe 'CreateBid', type: :feature do
	let(:root_url) { 'http://localhost:3000' }

	before(:all) do
		user = User.first
		Support::SignIn.new(@browser, { email: user.email, password: 'qwe123' })
									 .call
	end
	
	context 'with correct fields' do
		subject(:create_lot) do 
			new_lot = NewLotPage.new(@browser)
			new_lot.fill_fields_correct_data
			new_lot.create_lot
			new_lot.current_url
		end

		it 'should create bids' do
			expect do 
				new_lot = NewLotPage.new(@browser)
				new_lot.fill_fields_correct_data
				new_lot.create_lot
				sleep 1
			end.to change { Lot.count }.by(1)
		end

		it 'should create bids' do
			expect(@browser.url).to eq [root_url, 'lots', Lot.count].join('/') 
		end
	end
end

