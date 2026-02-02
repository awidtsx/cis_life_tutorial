require "test_helper"

class AddBarangaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_barangay = add_barangays(:one)
  end

  test "should get index" do
    get add_barangays_url
    assert_response :success
  end

  test "should get new" do
    get new_add_barangay_url
    assert_response :success
  end

  test "should create add_barangay" do
    assert_difference("AddBarangay.count") do
      post add_barangays_url, params: { add_barangay: { add_municipal_id: @add_barangay.add_municipal_id, name: @add_barangay.name } }
    end

    assert_redirected_to add_barangay_url(AddBarangay.last)
  end

  test "should show add_barangay" do
    get add_barangay_url(@add_barangay)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_barangay_url(@add_barangay)
    assert_response :success
  end

  test "should update add_barangay" do
    patch add_barangay_url(@add_barangay), params: { add_barangay: { add_municipal_id: @add_barangay.add_municipal_id, name: @add_barangay.name } }
    assert_redirected_to add_barangay_url(@add_barangay)
  end

  test "should destroy add_barangay" do
    assert_difference("AddBarangay.count", -1) do
      delete add_barangay_url(@add_barangay)
    end

    assert_redirected_to add_barangays_url
  end
end
