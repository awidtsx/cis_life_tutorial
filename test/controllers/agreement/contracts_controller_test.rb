require "test_helper"

class Agreement::ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agreement_contract = agreement_contracts(:one)
  end

  test "should get index" do
    get agreement_contracts_url
    assert_response :success
  end

  test "should get new" do
    get new_agreement_contract_url
    assert_response :success
  end

  test "should create agreement_contract" do
    assert_difference("Agreement::Contract.count") do
      post agreement_contracts_url, params: { agreement_contract: { cooperative_id: @agreement_contract.cooperative_id, insurance_product_id: @agreement_contract.insurance_product_id } }
    end

    assert_redirected_to agreement_contract_url(Agreement::Contract.last)
  end

  test "should show agreement_contract" do
    get agreement_contract_url(@agreement_contract)
    assert_response :success
  end

  test "should get edit" do
    get edit_agreement_contract_url(@agreement_contract)
    assert_response :success
  end

  test "should update agreement_contract" do
    patch agreement_contract_url(@agreement_contract), params: { agreement_contract: { cooperative_id: @agreement_contract.cooperative_id, insurance_product_id: @agreement_contract.insurance_product_id } }
    assert_redirected_to agreement_contract_url(@agreement_contract)
  end

  test "should destroy agreement_contract" do
    assert_difference("Agreement::Contract.count", -1) do
      delete agreement_contract_url(@agreement_contract)
    end

    assert_redirected_to agreement_contracts_url
  end
end
