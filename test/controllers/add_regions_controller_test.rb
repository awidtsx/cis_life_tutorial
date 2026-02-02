require "test_helper"

class AddRegionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_region = add_regions(:one)
  end

  test "should get index" do
    get add_regions_url
    assert_response :success
  end

  test "should get new" do
    get new_add_region_url
    assert_response :success
  end

  test "should create add_region" do
    assert_difference("AddRegion.count") do
      post add_regions_url, params: { add_region: { name: @add_region.name } }
    end

    assert_redirected_to add_region_url(AddRegion.last)
  end

  test "should show add_region" do
    get add_region_url(@add_region)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_region_url(@add_region)
    assert_response :success
  end

  test "should update add_region" do
    patch add_region_url(@add_region), params: { add_region: { name: @add_region.name } }
    assert_redirected_to add_region_url(@add_region)
  end

  test "should destroy add_region" do
    assert_difference("AddRegion.count", -1) do
      delete add_region_url(@add_region)
    end

    assert_redirected_to add_regions_url
  end
end
