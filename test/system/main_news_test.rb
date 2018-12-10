require "application_system_test_case"

class MainNewsTest < ApplicationSystemTestCase
  setup do
    @main_news = main_news(:one)
  end

  test "visiting the index" do
    visit main_news_url
    assert_selector "h1", text: "Main News"
  end

  test "creating a Main news" do
    visit main_news_url
    click_on "New Main News"

    fill_in "Description", with: @main_news.description
    fill_in "Title", with: @main_news.title
    click_on "Create Main news"

    assert_text "Main news was successfully created"
    click_on "Back"
  end

  test "updating a Main news" do
    visit main_news_url
    click_on "Edit", match: :first

    fill_in "Description", with: @main_news.description
    fill_in "Title", with: @main_news.title
    click_on "Update Main news"

    assert_text "Main news was successfully updated"
    click_on "Back"
  end

  test "destroying a Main news" do
    visit main_news_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Main news was successfully destroyed"
  end
end
