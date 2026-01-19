require "test_helper"

class InsuranceProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @insurance_product = insurance_products(:one)
  end

  test "should get index" do
    get insurance_products_url
    assert_response :success
  end

  test "should get new" do
    get new_insurance_product_url
    assert_response :success
  end

  test "should create insurance_product" do
    assert_difference("InsuranceProduct.count") do
      post insurance_products_url, params: { insurance_product: { description: @insurance_product.description, name: @insurance_product.name, product_type: @insurance_product.product_type } }
    end

    assert_redirected_to insurance_product_url(InsuranceProduct.last)
  end

  test "should show insurance_product" do
    get insurance_product_url(@insurance_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_insurance_product_url(@insurance_product)
    assert_response :success
  end

  test "should update insurance_product" do
    patch insurance_product_url(@insurance_product), params: { insurance_product: { description: @insurance_product.description, name: @insurance_product.name, product_type: @insurance_product.product_type } }
    assert_redirected_to insurance_product_url(@insurance_product)
  end

  test "should destroy insurance_product" do
    assert_difference("InsuranceProduct.count", -1) do
      delete insurance_product_url(@insurance_product)
    end

    assert_redirected_to insurance_products_url
  end
end
