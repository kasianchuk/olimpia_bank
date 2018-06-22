require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get profile_dashboard_url
    assert_response :success
  end

end
