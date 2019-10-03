module Support
  class LogOut

    def initialize(browser)
      @browser = browser
    end

    def call
      @browser.cookies.clear
      @browser.refresh
      @browser
    end
  end
end
