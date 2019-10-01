class BargainPage
	attr_accessor :comments, :do_bid

  URLS = { bargain: 'localhost:3000/current_bargains/' }

  def initialize(browser, bargain_id)
    @browser = browser
    @bargain_id = bargain_id
  end

  def method_missing(sym, *args, &amp;block)
    @browser.send sym, *args, &amp;block
  end

  def visit
    @browser.goto URLS[:bargain] + bargain_id 
  end

  def page_title
    @browser.title
  end
end