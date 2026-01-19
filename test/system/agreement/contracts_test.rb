require "application_system_test_case"

class Agreement::ContractsTest < ApplicationSystemTestCase
  setup do
    @agreement_contract = agreement_contracts(:one)
  end

  test "visiting the index" do
    visit agreement_contracts_url
    assert_selector "h1", text: "Contracts"
  end

  test "should create contract" do
    visit agreement_contracts_url
    click_on "New contract"

    fill_in "Cooperative", with: @agreement_contract.cooperative_id
    fill_in "Insurance product", with: @agreement_contract.insurance_product_id
    click_on "Create Contract"

    assert_text "Contract was successfully created"
    click_on "Back"
  end

  test "should update Contract" do
    visit agreement_contract_url(@agreement_contract)
    click_on "Edit this contract", match: :first

    fill_in "Cooperative", with: @agreement_contract.cooperative_id
    fill_in "Insurance product", with: @agreement_contract.insurance_product_id
    click_on "Update Contract"

    assert_text "Contract was successfully updated"
    click_on "Back"
  end

  test "should destroy Contract" do
    visit agreement_contract_url(@agreement_contract)
    click_on "Destroy this contract", match: :first

    assert_text "Contract was successfully destroyed"
  end
end
