require "application_system_test_case"

class InsuranceContractsTest < ApplicationSystemTestCase
  setup do
    @insurance_contract = insurance_contracts(:one)
  end

  test "visiting the index" do
    visit insurance_contracts_url
    assert_selector "h1", text: "Insurance contracts"
  end

  test "should create insurance contract" do
    visit insurance_contracts_url
    click_on "New insurance contract"

    fill_in "Age", with: @insurance_contract.age
    fill_in "Amount covered", with: @insurance_contract.amount_covered
    fill_in "Effectivity", with: @insurance_contract.effectivity
    fill_in "Expiry", with: @insurance_contract.expiry
    fill_in "Insured", with: @insurance_contract.insured_id
    fill_in "Insured type", with: @insurance_contract.insured_type
    fill_in "Premium", with: @insurance_contract.premium
    fill_in "Rate", with: @insurance_contract.rate_id
    click_on "Create Insurance contract"

    assert_text "Insurance contract was successfully created"
    click_on "Back"
  end

  test "should update Insurance contract" do
    visit insurance_contract_url(@insurance_contract)
    click_on "Edit this insurance contract", match: :first

    fill_in "Age", with: @insurance_contract.age
    fill_in "Amount covered", with: @insurance_contract.amount_covered
    fill_in "Effectivity", with: @insurance_contract.effectivity
    fill_in "Expiry", with: @insurance_contract.expiry
    fill_in "Insured", with: @insurance_contract.insured_id
    fill_in "Insured type", with: @insurance_contract.insured_type
    fill_in "Premium", with: @insurance_contract.premium
    fill_in "Rate", with: @insurance_contract.rate_id
    click_on "Update Insurance contract"

    assert_text "Insurance contract was successfully updated"
    click_on "Back"
  end

  test "should destroy Insurance contract" do
    visit insurance_contract_url(@insurance_contract)
    click_on "Destroy this insurance contract", match: :first

    assert_text "Insurance contract was successfully destroyed"
  end
end
