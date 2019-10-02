require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe 'CreateBid', type: :feature do
	let(:root_url) { 'http://localhost:3000' }

	before(:all) do
		user = User.first
		new_user = User.last

		Support::SignIn.new(@browser, { email: user.email, password: 'qwe123' })
									 .call

		new_lot = NewLotPage.new(@browser)
		new_lot.fill_fields_correct_data
		new_lot.create_lot
		sleep 1

		Support::LogOut.new(@browser).call

		Support::SignIn.new(@browser, { email: new_user.email, password: 'qwe123' })
									 .call
	end
	
	context 'with correct fields' do

		before(:all) do
			bid_id = Lot.last.id
			bargain_page = BargainPage.new(@browser, bid_id)
			@browser = bargain_page.do_bid
			sleep 1
		end

		let(:new_user) { User.last }
		let!(:bid) { CurrentBargain.last }
		let!(:lot) { bid.lot }

		it 'changes coast of bid' do
			expect(bid.current_price).not_to eq lot.start_price
		end

		it 'potential winner is new user' do
			expect(browser.link(:href, "/users/#{new_user.id}").exists?).to be_truthy
		end
	end
end

