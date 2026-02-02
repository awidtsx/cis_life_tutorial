require "test_helper"

class Agreement::PerilsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agreement_peril = agreement_perils(:one)
  end

  test "should get index" do
    get agreement_perils_url
    assert_response :success
  end

  test "should get new" do
    get new_agreement_peril_url
    assert_response :success
  end

  test "should create agreement_peril" do
    assert_difference("Agreement::Peril.count") do
      post agreement_perils_url, params: { agreement_peril: { acronym: @agreement_peril.acronym, coverage: @agreement_peril.coverage, description: @agreement_peril.description, eligibility_id: @agreement_peril.eligibility_id, peril: @agreement_peril.peril, premium: @agreement_peril.premium } }
    end

    assert_redirected_to agreement_peril_url(Agreement::Peril.last)
  end

  test "should show agreement_peril" do
    get agreement_peril_url(@agreement_peril)
    assert_response :success
  end

  test "should get edit" do
    get edit_agreement_peril_url(@agreement_peril)
    assert_response :success
  end

  test "should update agreement_peril" do
    patch agreement_peril_url(@agreement_peril), params: { agreement_peril: { acronym: @agreement_peril.acronym, coverage: @agreement_peril.coverage, description: @agreement_peril.description, eligibility_id: @agreement_peril.eligibility_id, peril: @agreement_peril.peril, premium: @agreement_peril.premium } }
    assert_redirected_to agreement_peril_url(@agreement_peril)
  end

  test "should destroy agreement_peril" do
    assert_difference("Agreement::Peril.count", -1) do
      delete agreement_peril_url(@agreement_peril)
    end

    assert_redirected_to agreement_perils_url
  end
end
