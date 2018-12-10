require 'test_helper'

class MainNewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @main_news = main_news(:one)
  end

  test "should get index" do
    get main_news_index_url
    assert_response :success
  end

  test "should get new" do
    get new_main_news_url
    assert_response :success
  end

  test "should create main_news" do
    assert_difference('MainNews.count') do
      post main_news_index_url, params: { main_news: { description: @main_news.description, title: @main_news.title } }
    end

    assert_redirected_to main_news_url(MainNews.last)
  end

  test "should show main_news" do
    get main_news_url(@main_news)
    assert_response :success
  end

  test "should get edit" do
    get edit_main_news_url(@main_news)
    assert_response :success
  end

  test "should update main_news" do
    patch main_news_url(@main_news), params: { main_news: { description: @main_news.description, title: @main_news.title } }
    assert_redirected_to main_news_url(@main_news)
  end

  test "should destroy main_news" do
    assert_difference('MainNews.count', -1) do
      delete main_news_url(@main_news)
    end

    assert_redirected_to main_news_index_url
  end
end
