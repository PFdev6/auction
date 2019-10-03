class NewLotPage
  attr_accessor :name_field, :description, :end_date, :start_price, :autopurchase_price, :images

  URLS = { new: 'http://localhost:3000/lots/new' }.freeze

  def initialize(browser)
    @browser = browser
    visit
  end

  def page_title
    @browser.title
  end

  def fill_fields_correct_data
    name_field = @browser.text_field(id: 'lot_name').set('New Test Lot')
    description = @browser.textarea(id: 'lot_description').set('Description')
    start_price = @browser.text_field(id: 'lot_start_price').set(20.0)
    autopurchase_price = @browser.text_field(id: 'lot_autopurchase_price').set(100.0)
    end_date = @browser.execute_script("$('#lot_lot_end_date').val((new Date(new Date().getTime() + 4*60*60000)).toISOString().slice(0, 19));")
    images = @browser.file_field(id: 'lot_files').set(File.join(Rails.root) + '/app/assets/images/medium/missing.png')
  end

  def create_lot
    @browser.button(class: %w[btn btn-info]).click;
  end

  def current_url
    @browser.url
  end

  private

  def visit
    @browser.goto URLS[:new]
  end
end
