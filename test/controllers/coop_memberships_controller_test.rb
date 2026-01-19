require "test_helper"

class CoopMembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coop_membership = coop_memberships(:one)
  end

  test "should get index" do
    get coop_memberships_url
    assert_response :success
  end

  test "should get new" do
    get new_coop_membership_url
    assert_response :success
  end

  test "should create coop_membership" do
    assert_difference("CoopMembership.count") do
      post coop_memberships_url, params: { coop_membership: { cooperative_id: @coop_membership.cooperative_id, individual_id: @coop_membership.individual_id, membership_date: @coop_membership.membership_date } }
    end

    assert_redirected_to coop_membership_url(CoopMembership.last)
  end

  test "should show coop_membership" do
    get coop_membership_url(@coop_membership)
    assert_response :success
  end

  test "should get edit" do
    get edit_coop_membership_url(@coop_membership)
    assert_response :success
  end

  test "should update coop_membership" do
    patch coop_membership_url(@coop_membership), params: { coop_membership: { cooperative_id: @coop_membership.cooperative_id, individual_id: @coop_membership.individual_id, membership_date: @coop_membership.membership_date } }
    assert_redirected_to coop_membership_url(@coop_membership)
  end

  test "should destroy coop_membership" do
    assert_difference("CoopMembership.count", -1) do
      delete coop_membership_url(@coop_membership)
    end

    assert_redirected_to coop_memberships_url
  end
end
