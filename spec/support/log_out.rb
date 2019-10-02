module Support
  class LogOut

    def initialize(browser)
      @browser = browser
    end

    def method_missing(sym, *args, &block)
      @browser.send sym, *args, block
    end

		def call
      @browser.button(class: %w[nav-item active mr-sm-5 badge badge-info]).click
      @browser
    end
  end
end