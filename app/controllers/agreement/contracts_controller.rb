class Agreement::ContractsController < ApplicationController
  before_action :set_agreement_contract, only: %i[ show edit update destroy ]
  before_action :load_contract, only: %i[ new create edit update ]
  
  # GET /agreement/contracts or /agreement/contracts.json
  def index
    @agreement_contracts = Agreement::Contract.includes(:contractable, :insurance_product).all
  end

  # GET /agreement/contracts/1 or /agreement/contracts/1.json
  def show
    @agreement_contracts = Agreement::Contract.all
  end

  # GET /agreement/contracts/new
  def new
    @agreement_contract = Agreement::Contract.new
    
    # Pre-populate from params if provided
    if params[:contractable_type].present? && params[:contractable_id].present?
      @agreement_contract.contractable_type = params[:contractable_type]
      @agreement_contract.contractable_id = params[:contractable_id]
    end
  end

  # GET /agreement/contracts/1/edit
  def edit
  end

  # POST /agreement/contracts or /agreement/contracts.json
  def create
    @agreement_contract = Agreement::Contract.new(agreement_contract_params)

    respond_to do |format|
      if @agreement_contract.save
        format.html { redirect_to @agreement_contract, notice: "Contract was successfully created." }
        format.json { render :show, status: :created, location: @agreement_contract }
      else
        load_contract
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @agreement_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agreement/contracts/1 or /agreement/contracts/1.json
  def update
    respond_to do |format|
      if @agreement_contract.update(agreement_contract_params)
        format.html { redirect_to @agreement_contract, notice: "Contract was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @agreement_contract }
      else
        load_contract
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @agreement_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agreement/contracts/1 or /agreement/contracts/1.json
  def destroy
    @agreement_contract.destroy!

    respond_to do |format|
      format.html { redirect_to agreement_contracts_path, notice: "Contract was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  
  # AJAX endpoint to get filtered products based on contract type
  def products_for_type
    contractable_type = params[:contractable_type]
    
    if contractable_type == 'Cooperative'
      # Group products for cooperatives
      @products = InsuranceProduct.where(product_type: 'Group').order(:name)
    elsif contractable_type == 'Individual'
      # Individual products for individuals
      @products = InsuranceProduct.where(product_type: 'Individual').order(:name)
    else
      @products = InsuranceProduct.none
    end
    
    respond_to do |format|
      format.json { render json: @products.map { |p| { id: p.id, name: p.name, product_type: p.product_type } } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agreement_contract
      @agreement_contract = Agreement::Contract.find(params[:id])
    end

    def load_contract
      @cooperatives = Cooperative.order(:name)
      @individuals = Individual.order(:last_name, :first_name)
      @products = InsuranceProduct.order(:name)
    end

    # Only allow a list of trusted parameters through.
    def agreement_contract_params
      params.require(:agreement_contract).permit(:insurance_product_id, :contractable_id, :contractable_type)
    end
end