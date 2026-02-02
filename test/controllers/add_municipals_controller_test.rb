require "test_helper"

class AddMunicipalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_municipal = add_municipals(:one)
  end

  test "should get index" do
    get add_municipals_url
    assert_response :success
  end

  test "should get new" do
    get new_add_municipal_url
    assert_response :success
  end

  test "should create add_municipal" do
    assert_difference("AddMunicipal.count") do
      post add_municipals_url, params: { add_municipal: { add_province_id: @add_municipal.add_province_id, name: @add_municipal.name } }
    end

    assert_redirected_to add_municipal_url(AddMunicipal.last)
  end

  test "should show add_municipal" do
    get add_municipal_url(@add_municipal)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_municipal_url(@add_municipal)
    assert_response :success
  end

  test "should update add_municipal" do
    patch add_municipal_url(@add_municipal), params: { add_municipal: { add_province_id: @add_municipal.add_province_id, name: @add_municipal.name } }
    assert_redirected_to add_municipal_url(@add_municipal)
  end

  test "should destroy add_municipal" do
    assert_difference("AddMunicipal.count", -1) do
      delete add_municipal_url(@add_municipal)
    end

    assert_redirected_to add_municipals_url
  end
end
