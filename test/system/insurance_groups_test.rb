require "application_system_test_case"

class InsuranceGroupsTest < ApplicationSystemTestCase
  setup do
    @insurance_group = insurance_groups(:one)
  end

  test "visiting the index" do
    visit insurance_groups_url
    assert_selector "h1", text: "Insurance groups"
  end

  test "should create insurance group" do
    visit insurance_groups_url
    click_on "New insurance group"

    fill_in "Contract", with: @insurance_group.contract_id
    fill_in "Cooperative", with: @insurance_group.cooperative_id
    fill_in "Insurance contract", with: @insurance_group.insurance_contract_id
    click_on "Create Insurance group"

    assert_text "Insurance group was successfully created"
    click_on "Back"
  end

  test "should update Insurance group" do
    visit insurance_group_url(@insurance_group)
    click_on "Edit this insurance group", match: :first

    fill_in "Contract", with: @insurance_group.contract_id
    fill_in "Cooperative", with: @insurance_group.cooperative_id
    fill_in "Insurance contract", with: @insurance_group.insurance_contract_id
    click_on "Update Insurance group"

    assert_text "Insurance group was successfully updated"
    click_on "Back"
  end

  test "should destroy Insurance group" do
    visit insurance_group_url(@insurance_group)
    click_on "Destroy this insurance group", match: :first

    assert_text "Insurance group was successfully destroyed"
  end
end
