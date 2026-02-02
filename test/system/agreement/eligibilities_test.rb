require "application_system_test_case"

class Agreement::EligibilitiesTest < ApplicationSystemTestCase
  setup do
    @agreement_eligibility = agreement_eligibilities(:one)
  end

  test "visiting the index" do
    visit agreement_eligibilities_url
    assert_selector "h1", text: "Eligibilities"
  end

  test "should create eligibility" do
    visit agreement_eligibilities_url
    click_on "New eligibility"

    fill_in "Commission", with: @agreement_eligibility.commission
    fill_in "Contestability", with: @agreement_eligibility.contestability
    check "Dependent" if @agreement_eligibility.dependent
    fill_in "Eligibility title", with: @agreement_eligibility.eligibility_title
    fill_in "Evidence limit", with: @agreement_eligibility.evidence_limit
    fill_in "Exit", with: @agreement_eligibility.exit
    fill_in "Max confinement", with: @agreement_eligibility.max_confinement
    fill_in "Max entry", with: @agreement_eligibility.max_entry
    fill_in "Medical limit", with: @agreement_eligibility.medical_limit
    fill_in "Min confinement", with: @agreement_eligibility.min_confinement
    fill_in "Min entry", with: @agreement_eligibility.min_entry
    fill_in "Service", with: @agreement_eligibility.service
    click_on "Create Eligibility"

    assert_text "Eligibility was successfully created"
    click_on "Back"
  end

  test "should update Eligibility" do
    visit agreement_eligibility_url(@agreement_eligibility)
    click_on "Edit this eligibility", match: :first

    fill_in "Commission", with: @agreement_eligibility.commission
    fill_in "Contestability", with: @agreement_eligibility.contestability
    check "Dependent" if @agreement_eligibility.dependent
    fill_in "Eligibility title", with: @agreement_eligibility.eligibility_title
    fill_in "Evidence limit", with: @agreement_eligibility.evidence_limit
    fill_in "Exit", with: @agreement_eligibility.exit
    fill_in "Max confinement", with: @agreement_eligibility.max_confinement
    fill_in "Max entry", with: @agreement_eligibility.max_entry
    fill_in "Medical limit", with: @agreement_eligibility.medical_limit
    fill_in "Min confinement", with: @agreement_eligibility.min_confinement
    fill_in "Min entry", with: @agreement_eligibility.min_entry
    fill_in "Service", with: @agreement_eligibility.service
    click_on "Update Eligibility"

    assert_text "Eligibility was successfully updated"
    click_on "Back"
  end

  test "should destroy Eligibility" do
    visit agreement_eligibility_url(@agreement_eligibility)
    click_on "Destroy this eligibility", match: :first

    assert_text "Eligibility was successfully destroyed"
  end
end
