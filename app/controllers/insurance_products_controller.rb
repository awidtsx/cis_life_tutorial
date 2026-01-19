class InsuranceProductsController < ApplicationController
  before_action :set_insurance_product, only: %i[ show edit update destroy ]

  # GET /insurance_products or /insurance_products.json
  def index
    @insurance_products = InsuranceProduct.all
  end

  # GET /insurance_products/1 or /insurance_products/1.json
  def show
  end

  # GET /insurance_products/new
  def new
    @insurance_product = InsuranceProduct.new
  end

  # GET /insurance_products/1/edit
  def edit
  end

  # POST /insurance_products or /insurance_products.json
  def create
    @insurance_product = InsuranceProduct.new(insurance_product_params)

    respond_to do |format|
      if @insurance_product.save
        format.html { redirect_to @insurance_product, notice: "Insurance product was successfully created." }
        format.json { render :show, status: :created, location: @insurance_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @insurance_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_products/1 or /insurance_products/1.json
  def update
    respond_to do |format|
      if @insurance_product.update(insurance_product_params)
        format.html { redirect_to @insurance_product, notice: "Insurance product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @insurance_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @insurance_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_products/1 or /insurance_products/1.json
  def destroy
    @insurance_product.destroy!

    respond_to do |format|
      format.html { redirect_to insurance_products_path, notice: "Insurance product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_product
      @insurance_product = InsuranceProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def insurance_product_params
      params.require(:insurance_product).permit(:name, :description, :product_type)
    end
end
