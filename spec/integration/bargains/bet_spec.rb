require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe 'CreateAndBet', type: :feature do
	let(:root_url) { 'http://localhost:3000' }

	before(:all) do
		user = create(:user) 
		@lot = create(:lot, user: user)
		@current_bargain = @lot.current_bargain
		
		@new_user = create(:user)
		
		Support::SignIn.new(browser, { email: @new_user.email, password: 'qwe123' })
									 .call
	end
	
	context 'with correct fields' do
		before do
			bid_id = @lot.id
			bargain_page = BargainPage.new(browser, bid_id)
			browser = bargain_page.do_bid
			wait_until(1)
		end

		let!(:bid) { @lot.reload.current_bargain }

		it 'changes coast of bid' do
			expect(bid.current_price).not_to eq @lot.start_price
		end

		it 'potential winner is new user' do
			expect(browser.link(:href, "/users/#{@new_user.id}").exists?).to be_truthy
		end
	end
end

