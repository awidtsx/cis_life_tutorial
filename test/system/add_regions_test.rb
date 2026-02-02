require "application_system_test_case"

class AddRegionsTest < ApplicationSystemTestCase
  setup do
    @add_region = add_regions(:one)
  end

  test "visiting the index" do
    visit add_regions_url
    assert_selector "h1", text: "Add regions"
  end

  test "should create add region" do
    visit add_regions_url
    click_on "New add region"

    fill_in "Name", with: @add_region.name
    click_on "Create Add region"

    assert_text "Add region was successfully created"
    click_on "Back"
  end

  test "should update Add region" do
    visit add_region_url(@add_region)
    click_on "Edit this add region", match: :first

    fill_in "Name", with: @add_region.name
    click_on "Update Add region"

    assert_text "Add region was successfully updated"
    click_on "Back"
  end

  test "should destroy Add region" do
    visit add_region_url(@add_region)
    click_on "Destroy this add region", match: :first

    assert_text "Add region was successfully destroyed"
  end
end
