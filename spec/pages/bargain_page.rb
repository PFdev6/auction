class BargainPage
	attr_accessor :comments

  URLS = { bargain: 'http://localhost:3000/current_bargains/' }

  def initialize(browser, bargain_id)
    browser.goto URLS[:bargain] + bargain_id.to_s
    @browser = browser
  end

  def method_missing(sym, *args, &block)
    @browser.send sym, *args, &block
  end

  def do_bid
    @browser.button(id: 'do_bid').click
    @browser
  end
end