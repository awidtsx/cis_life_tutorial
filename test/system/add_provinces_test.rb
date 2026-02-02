require "application_system_test_case"

class AddProvincesTest < ApplicationSystemTestCase
  setup do
    @add_province = add_provinces(:one)
  end

  test "visiting the index" do
    visit add_provinces_url
    assert_selector "h1", text: "Add provinces"
  end

  test "should create add province" do
    visit add_provinces_url
    click_on "New add province"

    fill_in "Add region", with: @add_province.add_region_id
    fill_in "Name", with: @add_province.name
    click_on "Create Add province"

    assert_text "Add province was successfully created"
    click_on "Back"
  end

  test "should update Add province" do
    visit add_province_url(@add_province)
    click_on "Edit this add province", match: :first

    fill_in "Add region", with: @add_province.add_region_id
    fill_in "Name", with: @add_province.name
    click_on "Update Add province"

    assert_text "Add province was successfully updated"
    click_on "Back"
  end

  test "should destroy Add province" do
    visit add_province_url(@add_province)
    click_on "Destroy this add province", match: :first

    assert_text "Add province was successfully destroyed"
  end
end
