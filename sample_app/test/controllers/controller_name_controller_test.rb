require "test_helper"

class ControllerNameControllerTest < ActionDispatch::IntegrationTest
  test "should get abc" do
    get controller_name_abc_url
    assert_response :success
  end
end
