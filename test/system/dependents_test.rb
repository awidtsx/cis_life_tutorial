require "application_system_test_case"

class DependentsTest < ApplicationSystemTestCase
  setup do
    @dependent = dependents(:one)
  end

  test "visiting the index" do
    visit dependents_url
    assert_selector "h1", text: "Dependents"
  end

  test "should create dependent" do
    visit dependents_url
    click_on "New dependent"

    fill_in "Birthdate", with: @dependent.birthdate
    fill_in "First name", with: @dependent.first_name
    fill_in "Gender", with: @dependent.gender
    fill_in "Individual", with: @dependent.individual_id
    fill_in "Last name", with: @dependent.last_name
    fill_in "Middle name", with: @dependent.middle_name
    fill_in "Relationship", with: @dependent.relationship_id
    click_on "Create Dependent"

    assert_text "Dependent was successfully created"
    click_on "Back"
  end

  test "should update Dependent" do
    visit dependent_url(@dependent)
    click_on "Edit this dependent", match: :first

    fill_in "Birthdate", with: @dependent.birthdate
    fill_in "First name", with: @dependent.first_name
    fill_in "Gender", with: @dependent.gender
    fill_in "Individual", with: @dependent.individual_id
    fill_in "Last name", with: @dependent.last_name
    fill_in "Middle name", with: @dependent.middle_name
    fill_in "Relationship", with: @dependent.relationship_id
    click_on "Update Dependent"

    assert_text "Dependent was successfully updated"
    click_on "Back"
  end

  test "should destroy Dependent" do
    visit dependent_url(@dependent)
    click_on "Destroy this dependent", match: :first

    assert_text "Dependent was successfully destroyed"
  end
end
