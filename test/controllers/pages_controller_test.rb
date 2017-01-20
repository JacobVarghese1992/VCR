require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get launchpad" do
    get pages_launchpad_url
    assert_response :success
  end

  test "should get contacts" do
    get pages_contacts_url
    assert_response :success
  end

end
