require "application_system_test_case"

class RegistriesTest < ApplicationSystemTestCase
  setup do
    @registry = registries(:one)
  end

  test "visiting the index" do
    visit registries_url
    assert_selector "h1", text: "Registries"
  end

  test "should create registry" do
    visit registries_url
    click_on "New registry"

    fill_in "Cooperative", with: @registry.cooperative_id
    fill_in "Name", with: @registry.name
    click_on "Create Registry"

    assert_text "Registry was successfully created"
    click_on "Back"
  end

  test "should update Registry" do
    visit registry_url(@registry)
    click_on "Edit this registry", match: :first

    fill_in "Cooperative", with: @registry.cooperative_id
    fill_in "Name", with: @registry.name
    click_on "Update Registry"

    assert_text "Registry was successfully updated"
    click_on "Back"
  end

  test "should destroy Registry" do
    visit registry_url(@registry)
    click_on "Destroy this registry", match: :first

    assert_text "Registry was successfully destroyed"
  end
end
