require "application_system_test_case"

class Agreement::PerilsTest < ApplicationSystemTestCase
  setup do
    @agreement_peril = agreement_perils(:one)
  end

  test "visiting the index" do
    visit agreement_perils_url
    assert_selector "h1", text: "Perils"
  end

  test "should create peril" do
    visit agreement_perils_url
    click_on "New peril"

    fill_in "Acronym", with: @agreement_peril.acronym
    fill_in "Coverage", with: @agreement_peril.coverage
    fill_in "Description", with: @agreement_peril.description
    fill_in "Eligibility", with: @agreement_peril.eligibility_id
    fill_in "Peril", with: @agreement_peril.peril
    fill_in "Premium", with: @agreement_peril.premium
    click_on "Create Peril"

    assert_text "Peril was successfully created"
    click_on "Back"
  end

  test "should update Peril" do
    visit agreement_peril_url(@agreement_peril)
    click_on "Edit this peril", match: :first

    fill_in "Acronym", with: @agreement_peril.acronym
    fill_in "Coverage", with: @agreement_peril.coverage
    fill_in "Description", with: @agreement_peril.description
    fill_in "Eligibility", with: @agreement_peril.eligibility_id
    fill_in "Peril", with: @agreement_peril.peril
    fill_in "Premium", with: @agreement_peril.premium
    click_on "Update Peril"

    assert_text "Peril was successfully updated"
    click_on "Back"
  end

  test "should destroy Peril" do
    visit agreement_peril_url(@agreement_peril)
    click_on "Destroy this peril", match: :first

    assert_text "Peril was successfully destroyed"
  end
end
