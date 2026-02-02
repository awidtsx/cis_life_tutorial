require "test_helper"

class AddProvincesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_province = add_provinces(:one)
  end

  test "should get index" do
    get add_provinces_url
    assert_response :success
  end

  test "should get new" do
    get new_add_province_url
    assert_response :success
  end

  test "should create add_province" do
    assert_difference("AddProvince.count") do
      post add_provinces_url, params: { add_province: { add_region_id: @add_province.add_region_id, name: @add_province.name } }
    end

    assert_redirected_to add_province_url(AddProvince.last)
  end

  test "should show add_province" do
    get add_province_url(@add_province)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_province_url(@add_province)
    assert_response :success
  end

  test "should update add_province" do
    patch add_province_url(@add_province), params: { add_province: { add_region_id: @add_province.add_region_id, name: @add_province.name } }
    assert_redirected_to add_province_url(@add_province)
  end

  test "should destroy add_province" do
    assert_difference("AddProvince.count", -1) do
      delete add_province_url(@add_province)
    end

    assert_redirected_to add_provinces_url
  end
end
