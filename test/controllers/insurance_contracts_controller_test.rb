require "test_helper"

class InsuranceContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @insurance_contract = insurance_contracts(:one)
  end

  test "should get index" do
    get insurance_contracts_url
    assert_response :success
  end

  test "should get new" do
    get new_insurance_contract_url
    assert_response :success
  end

  test "should create insurance_contract" do
    assert_difference("InsuranceContract.count") do
      post insurance_contracts_url, params: { insurance_contract: { age: @insurance_contract.age, amount_covered: @insurance_contract.amount_covered, effectivity: @insurance_contract.effectivity, expiry: @insurance_contract.expiry, insured_id: @insurance_contract.insured_id, insured_type: @insurance_contract.insured_type, premium: @insurance_contract.premium, rate_id: @insurance_contract.rate_id } }
    end

    assert_redirected_to insurance_contract_url(InsuranceContract.last)
  end

  test "should show insurance_contract" do
    get insurance_contract_url(@insurance_contract)
    assert_response :success
  end

  test "should get edit" do
    get edit_insurance_contract_url(@insurance_contract)
    assert_response :success
  end

  test "should update insurance_contract" do
    patch insurance_contract_url(@insurance_contract), params: { insurance_contract: { age: @insurance_contract.age, amount_covered: @insurance_contract.amount_covered, effectivity: @insurance_contract.effectivity, expiry: @insurance_contract.expiry, insured_id: @insurance_contract.insured_id, insured_type: @insurance_contract.insured_type, premium: @insurance_contract.premium, rate_id: @insurance_contract.rate_id } }
    assert_redirected_to insurance_contract_url(@insurance_contract)
  end

  test "should destroy insurance_contract" do
    assert_difference("InsuranceContract.count", -1) do
      delete insurance_contract_url(@insurance_contract)
    end

    assert_redirected_to insurance_contracts_url
  end
end
