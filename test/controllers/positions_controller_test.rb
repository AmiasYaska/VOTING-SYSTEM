require "test_helper"

class PositionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get positions_index_url
    assert_response :success
  end

  test "should get show" do
    get positions_show_url
    assert_response :success
  end

  test "should get vote" do
    get positions_vote_url
    assert_response :success
  end
end
