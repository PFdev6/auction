class BargainPage
  URLS = { bargain: 'http://localhost:3000/current_bargains/' }.freeze

  def initialize(browser, bargain_id)
    browser.goto URLS[:bargain] + bargain_id.to_s
    @browser = browser
  end

  def do_bid
    @browser.button(id: 'do_bid').click
    @browser
  end

  def add_comment(message)
    @browser.textarea(id: 'comment_msg').set(message)
    @browser.button(id: 'add_comment').click
  end

  def reply_on_comment(match, message)
    message_id = @browser.div(text: match).id
    @browser.link(id: "comment_id_#{message_id}").click
    @browser.textarea(id: 'comment_msg').set(message)
    @browser.button(id: 'add_comment').click
  end
end
