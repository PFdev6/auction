module Support
  class SignIn
    attr_reader :email, :password

    def initialize(browser, user_data)
      browser.goto('http://localhost:3000/users/sign_in')
      @browser = browser
      @email = user_data[:email]
      @password = user_data[:password]
    end

    def method_missing(sym, *args, &block)
      @browser.send sym, *args, block
    end

    def call
      @browser.text_field(id: 'user_email').set(email);
      @browser.text_field(id: 'user_password').set(password);
      @browser.button(class: %w[ml-2 btn btn-success]).click
      @browser
    end
  end
end