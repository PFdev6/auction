require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe 'BetWithoutAutopurchase', type: :feature do
  let(:root_url) { 'http://localhost:3000' }

  before(:all) do
    user = create(:user)
    @lot = create(:lot, user: user)
    @current_bargain = @lot.current_bargain

    @new_user = create(:user)

    Support::SignIn.new(browser, { email: @new_user.email, password: 'qwe123' })
                   .call
  end

  context 'bet w/o autopurchase' do
    subject(:bet) do
      bid_id = @lot.id
      bargain_page = BargainPage.new(browser, bid_id)
      bargain_page.do_bid
    end

    let(:bid) { @current_bargain.reload }
    let(:lot) { @lot }
    let(:new_user) { @new_user }

    before do
      bet
      wait_until(1)
    end

    it 'changes coast of bid' do
      expect(bid.current_price).not_to eq lot.start_price
    end

    it 'potential winner is new user' do
      expect(browser.link(:href, "/users/#{new_user.id}").exists?).to be_truthy
    end
  end
end
