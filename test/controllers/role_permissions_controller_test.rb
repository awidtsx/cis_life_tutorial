require "test_helper"

class RolePermissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get role_permissions_edit_url
    assert_response :success
  end

  test "should get update" do
    get role_permissions_update_url
    assert_response :success
  end
end
