require "test_helper"

class Agreement::RatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agreement_rate = agreement_rates(:one)
  end

  test "should get index" do
    get agreement_rates_url
    assert_response :success
  end

  test "should get new" do
    get new_agreement_rate_url
    assert_response :success
  end

  test "should create agreement_rate" do
    assert_difference("Agreement::Rate.count") do
      post agreement_rates_url, params: { agreement_rate: { age_from: @agreement_rate.age_from, age_to: @agreement_rate.age_to, contract_id: @agreement_rate.contract_id, max_amount: @agreement_rate.max_amount, min_amount: @agreement_rate.min_amount, rate: @agreement_rate.rate } }
    end

    assert_redirected_to agreement_rate_url(Agreement::Rate.last)
  end

  test "should show agreement_rate" do
    get agreement_rate_url(@agreement_rate)
    assert_response :success
  end

  test "should get edit" do
    get edit_agreement_rate_url(@agreement_rate)
    assert_response :success
  end

  test "should update agreement_rate" do
    patch agreement_rate_url(@agreement_rate), params: { agreement_rate: { age_from: @agreement_rate.age_from, age_to: @agreement_rate.age_to, contract_id: @agreement_rate.contract_id, max_amount: @agreement_rate.max_amount, min_amount: @agreement_rate.min_amount, rate: @agreement_rate.rate } }
    assert_redirected_to agreement_rate_url(@agreement_rate)
  end

  test "should destroy agreement_rate" do
    assert_difference("Agreement::Rate.count", -1) do
      delete agreement_rate_url(@agreement_rate)
    end

    assert_redirected_to agreement_rates_url
  end
end
