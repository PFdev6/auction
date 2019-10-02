module Support
  class LogOut

    def initialize(browser)
      @browser = browser
    end

    def method_missing(sym, *args, &block)
      @browser.send sym, *args, block
    end

    def call
      @browser.cookies.clear
      @browser.refresh
      @browser
    end
  end
end