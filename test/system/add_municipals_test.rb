require "application_system_test_case"

class AddMunicipalsTest < ApplicationSystemTestCase
  setup do
    @add_municipal = add_municipals(:one)
  end

  test "visiting the index" do
    visit add_municipals_url
    assert_selector "h1", text: "Add municipals"
  end

  test "should create add municipal" do
    visit add_municipals_url
    click_on "New add municipal"

    fill_in "Add province", with: @add_municipal.add_province_id
    fill_in "Name", with: @add_municipal.name
    click_on "Create Add municipal"

    assert_text "Add municipal was successfully created"
    click_on "Back"
  end

  test "should update Add municipal" do
    visit add_municipal_url(@add_municipal)
    click_on "Edit this add municipal", match: :first

    fill_in "Add province", with: @add_municipal.add_province_id
    fill_in "Name", with: @add_municipal.name
    click_on "Update Add municipal"

    assert_text "Add municipal was successfully updated"
    click_on "Back"
  end

  test "should destroy Add municipal" do
    visit add_municipal_url(@add_municipal)
    click_on "Destroy this add municipal", match: :first

    assert_text "Add municipal was successfully destroyed"
  end
end
