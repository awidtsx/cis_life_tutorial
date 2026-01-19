require "application_system_test_case"

class InsuranceProductsTest < ApplicationSystemTestCase
  setup do
    @insurance_product = insurance_products(:one)
  end

  test "visiting the index" do
    visit insurance_products_url
    assert_selector "h1", text: "Insurance products"
  end

  test "should create insurance product" do
    visit insurance_products_url
    click_on "New insurance product"

    fill_in "Description", with: @insurance_product.description
    fill_in "Name", with: @insurance_product.name
    fill_in "Product type", with: @insurance_product.product_type
    click_on "Create Insurance product"

    assert_text "Insurance product was successfully created"
    click_on "Back"
  end

  test "should update Insurance product" do
    visit insurance_product_url(@insurance_product)
    click_on "Edit this insurance product", match: :first

    fill_in "Description", with: @insurance_product.description
    fill_in "Name", with: @insurance_product.name
    fill_in "Product type", with: @insurance_product.product_type
    click_on "Update Insurance product"

    assert_text "Insurance product was successfully updated"
    click_on "Back"
  end

  test "should destroy Insurance product" do
    visit insurance_product_url(@insurance_product)
    click_on "Destroy this insurance product", match: :first

    assert_text "Insurance product was successfully destroyed"
  end
end
