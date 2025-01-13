require "test_helper"

class MindMapControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mind_map_index_url
    assert_response :success
  end
end
