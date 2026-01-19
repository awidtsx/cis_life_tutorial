require "application_system_test_case"

class Agreement::RatesTest < ApplicationSystemTestCase
  setup do
    @agreement_rate = agreement_rates(:one)
  end

  test "visiting the index" do
    visit agreement_rates_url
    assert_selector "h1", text: "Rates"
  end

  test "should create rate" do
    visit agreement_rates_url
    click_on "New rate"

    fill_in "Age from", with: @agreement_rate.age_from
    fill_in "Age to", with: @agreement_rate.age_to
    fill_in "Contract", with: @agreement_rate.contract_id
    fill_in "Max amount", with: @agreement_rate.max_amount
    fill_in "Min amount", with: @agreement_rate.min_amount
    fill_in "Rate", with: @agreement_rate.rate
    click_on "Create Rate"

    assert_text "Rate was successfully created"
    click_on "Back"
  end

  test "should update Rate" do
    visit agreement_rate_url(@agreement_rate)
    click_on "Edit this rate", match: :first

    fill_in "Age from", with: @agreement_rate.age_from
    fill_in "Age to", with: @agreement_rate.age_to
    fill_in "Contract", with: @agreement_rate.contract_id
    fill_in "Max amount", with: @agreement_rate.max_amount
    fill_in "Min amount", with: @agreement_rate.min_amount
    fill_in "Rate", with: @agreement_rate.rate
    click_on "Update Rate"

    assert_text "Rate was successfully updated"
    click_on "Back"
  end

  test "should destroy Rate" do
    visit agreement_rate_url(@agreement_rate)
    click_on "Destroy this rate", match: :first

    assert_text "Rate was successfully destroyed"
  end
end
