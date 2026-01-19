require "application_system_test_case"

class CoopMembershipsTest < ApplicationSystemTestCase
  setup do
    @coop_membership = coop_memberships(:one)
  end

  test "visiting the index" do
    visit coop_memberships_url
    assert_selector "h1", text: "Coop memberships"
  end

  test "should create coop membership" do
    visit coop_memberships_url
    click_on "New coop membership"

    fill_in "Cooperative", with: @coop_membership.cooperative_id
    fill_in "Individual", with: @coop_membership.individual_id
    fill_in "Membership date", with: @coop_membership.membership_date
    click_on "Create Coop membership"

    assert_text "Coop membership was successfully created"
    click_on "Back"
  end

  test "should update Coop membership" do
    visit coop_membership_url(@coop_membership)
    click_on "Edit this coop membership", match: :first

    fill_in "Cooperative", with: @coop_membership.cooperative_id
    fill_in "Individual", with: @coop_membership.individual_id
    fill_in "Membership date", with: @coop_membership.membership_date
    click_on "Update Coop membership"

    assert_text "Coop membership was successfully updated"
    click_on "Back"
  end

  test "should destroy Coop membership" do
    visit coop_membership_url(@coop_membership)
    click_on "Destroy this coop membership", match: :first

    assert_text "Coop membership was successfully destroyed"
  end
end
