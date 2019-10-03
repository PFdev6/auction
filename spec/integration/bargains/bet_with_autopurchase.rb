require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe 'BetWithAutopurchase', type: :feature do
	let(:root_url) { 'http://localhost:3000' }

	before(:all) do
		user = create(:user) 
		@lot = create(:lot, start_price: 10, autopurchase_price: 11, user: user)
		@current_bargain = @lot.current_bargain
		
		@winner = create(:user)
		@loser = create(:user)

		Support::SignIn.new(browser, { email: @winner.email, password: 'qwe123' })
									 .call

		BargainPage.new(browser, @lot.current_bargain.id).do_bid
		wait_until(1)

		Support::LogOut.new(browser).call

    Support::SignIn.new(browser, { email: @loser.email, password: 'qwe123' })
                   .call
	end
	
	context 'bet with autopurchase' do
		subject(:bet_page) do
			bid_id = @lot.id
			bargain_page = BargainPage.new(browser, bid_id)
		end

		before do
      bet_page
			wait_until(1)
		end

		let!(:bid) { @current_bargain.reload }

		it 'shows winner' do
			expect(browser.link(:href, "/users/#{@winner.id}").exists?).to be_truthy
    end
    
    it 'can\'t bet' do
      expect(browser.button(id: 'do_bid').present?).to be_falsey
    end
	end
end

