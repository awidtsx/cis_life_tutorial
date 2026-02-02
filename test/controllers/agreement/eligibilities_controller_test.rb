require "test_helper"

class Agreement::EligibilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agreement_eligibility = agreement_eligibilities(:one)
  end

  test "should get index" do
    get agreement_eligibilities_url
    assert_response :success
  end

  test "should get new" do
    get new_agreement_eligibility_url
    assert_response :success
  end

  test "should create agreement_eligibility" do
    assert_difference("Agreement::Eligibility.count") do
      post agreement_eligibilities_url, params: { agreement_eligibility: { commission: @agreement_eligibility.commission, contestability: @agreement_eligibility.contestability, dependent: @agreement_eligibility.dependent, eligibility_title: @agreement_eligibility.eligibility_title, evidence_limit: @agreement_eligibility.evidence_limit, exit: @agreement_eligibility.exit, max_confinement: @agreement_eligibility.max_confinement, max_entry: @agreement_eligibility.max_entry, medical_limit: @agreement_eligibility.medical_limit, min_confinement: @agreement_eligibility.min_confinement, min_entry: @agreement_eligibility.min_entry, service: @agreement_eligibility.service } }
    end

    assert_redirected_to agreement_eligibility_url(Agreement::Eligibility.last)
  end

  test "should show agreement_eligibility" do
    get agreement_eligibility_url(@agreement_eligibility)
    assert_response :success
  end

  test "should get edit" do
    get edit_agreement_eligibility_url(@agreement_eligibility)
    assert_response :success
  end

  test "should update agreement_eligibility" do
    patch agreement_eligibility_url(@agreement_eligibility), params: { agreement_eligibility: { commission: @agreement_eligibility.commission, contestability: @agreement_eligibility.contestability, dependent: @agreement_eligibility.dependent, eligibility_title: @agreement_eligibility.eligibility_title, evidence_limit: @agreement_eligibility.evidence_limit, exit: @agreement_eligibility.exit, max_confinement: @agreement_eligibility.max_confinement, max_entry: @agreement_eligibility.max_entry, medical_limit: @agreement_eligibility.medical_limit, min_confinement: @agreement_eligibility.min_confinement, min_entry: @agreement_eligibility.min_entry, service: @agreement_eligibility.service } }
    assert_redirected_to agreement_eligibility_url(@agreement_eligibility)
  end

  test "should destroy agreement_eligibility" do
    assert_difference("Agreement::Eligibility.count", -1) do
      delete agreement_eligibility_url(@agreement_eligibility)
    end

    assert_redirected_to agreement_eligibilities_url
  end
end
