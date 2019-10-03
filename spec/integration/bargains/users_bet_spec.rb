require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe 'UsersBet', type: :feature do
  let(:root_url) { 'http://localhost:3000' }

  before(:all) do
    user = create(:user)
    @lot = create(:lot, user: user)
    @current_bargain = @lot.current_bargain

    @users = create_list(:user, 30)

    bid_id = @current_bargain.id

    @users.each do |user|
      Support::SignIn.new(browser, { email: user.email, password: 'qwe123' })
                     .call
      BargainPage.new(browser, bid_id).do_bid
      wait_until(1)

      Support::LogOut.new(browser).call
    end

  end

  context '30 users' do
    let(:users) { @users }
    let(:bid) { @current_bargain.reload }

    it 'involve in the auction' do
      expect(bid.users - users).to eq []
    end
  end
end
