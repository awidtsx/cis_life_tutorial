require "application_system_test_case"

class AddBarangaysTest < ApplicationSystemTestCase
  setup do
    @add_barangay = add_barangays(:one)
  end

  test "visiting the index" do
    visit add_barangays_url
    assert_selector "h1", text: "Add barangays"
  end

  test "should create add barangay" do
    visit add_barangays_url
    click_on "New add barangay"

    fill_in "Add municipal", with: @add_barangay.add_municipal_id
    fill_in "Name", with: @add_barangay.name
    click_on "Create Add barangay"

    assert_text "Add barangay was successfully created"
    click_on "Back"
  end

  test "should update Add barangay" do
    visit add_barangay_url(@add_barangay)
    click_on "Edit this add barangay", match: :first

    fill_in "Add municipal", with: @add_barangay.add_municipal_id
    fill_in "Name", with: @add_barangay.name
    click_on "Update Add barangay"

    assert_text "Add barangay was successfully updated"
    click_on "Back"
  end

  test "should destroy Add barangay" do
    visit add_barangay_url(@add_barangay)
    click_on "Destroy this add barangay", match: :first

    assert_text "Add barangay was successfully destroyed"
  end
end
