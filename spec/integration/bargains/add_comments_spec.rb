require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe 'AddComments', type: :feature do
  let(:root_url) { 'http://localhost:3000' }

  before(:all) do
    user = create(:user)
    @lot = create(:lot, user: user)
    @current_bargain = @lot.current_bargain

    @users = create_list(:user, 3)

    bid_id = @current_bargain.id

    @users.each do |user|
      Support::SignIn.new(browser, { email: user.email, password: 'qwe123' })
                     .call

      message = "Message by user #{user.id}"
      bid_page = BargainPage.new(browser, bid_id)
      bid_page.add_comment(message)
      reply_msg = "Reply On comment by #{user.id}"
      bid_page.reply_on_comment(message, reply_msg)

      wait_until(1)

      Support::LogOut.new(browser).call
    end

    Support::SignIn.new(browser, { email: user.email, password: 'qwe123' })
                   .call
    bid_page = BargainPage.new(browser, bid_id)
  end

  context 'usual comment' do
    subject(:comment) do
      browser.div(text: "Message by user #{users.first.id}").id.to_i
    end

    let(:users) { @users }
    let(:bid) { @current_bargain.reload }

    it 'adds comment' do
      expect(Comment.find_by(id: comment)).to be_present
    end
  end

  context 'reply on comment' do
    subject(:comment) do
      browser.div(text: "Reply On comment by #{users.first.id}").id.to_i
    end

    let(:users) { @users }
    let(:bid) { @current_bargain.reload }

    it 'adds comment' do
      expect(Comment.find_by(id: comment)).to be_present
    end
  end
end
