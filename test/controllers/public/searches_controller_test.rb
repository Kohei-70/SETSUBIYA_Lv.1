require "test_helper"

class Public::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_searches_index_url
    assert_response :success
  end

  test "should get show" do
    get public_searches_show_url
    assert_response :success
  end
end
