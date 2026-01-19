require "test_helper"

class InsuranceGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @insurance_group = insurance_groups(:one)
  end

  test "should get index" do
    get insurance_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_insurance_group_url
    assert_response :success
  end

  test "should create insurance_group" do
    assert_difference("InsuranceGroup.count") do
      post insurance_groups_url, params: { insurance_group: { contract_id: @insurance_group.contract_id, cooperative_id: @insurance_group.cooperative_id, insurance_contract_id: @insurance_group.insurance_contract_id } }
    end

    assert_redirected_to insurance_group_url(InsuranceGroup.last)
  end

  test "should show insurance_group" do
    get insurance_group_url(@insurance_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_insurance_group_url(@insurance_group)
    assert_response :success
  end

  test "should update insurance_group" do
    patch insurance_group_url(@insurance_group), params: { insurance_group: { contract_id: @insurance_group.contract_id, cooperative_id: @insurance_group.cooperative_id, insurance_contract_id: @insurance_group.insurance_contract_id } }
    assert_redirected_to insurance_group_url(@insurance_group)
  end

  test "should destroy insurance_group" do
    assert_difference("InsuranceGroup.count", -1) do
      delete insurance_group_url(@insurance_group)
    end

    assert_redirected_to insurance_groups_url
  end
end
