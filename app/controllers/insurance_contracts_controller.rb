class InsuranceContractsController < ApplicationController
  before_action :set_insured
  before_action :set_insurance_contract, only: %i[ show edit update destroy ]
  before_action :load_contract, only: %i[ new create edit update ]
  # GET /insurance_contracts or /insurance_contracts.json
  def index
    @insurance_contracts = InsuranceContract.all
  end

  # GET /insurance_contracts/1 or /insurance_contracts/1.json
  def show
  end

  # GET /insurance_contracts/new
  def new
    @insurance_contract = @insured.insurance_contracts.build
  end

  # GET /insurance_contracts/1/edit
  def edit
  end

  # POST /insurance_contracts or /insurance_contracts.json
  def create
  @insurance_contract =
    @insured.insurance_contracts.build(insurance_contract_params)

  respond_to do |format|
    if @insurance_contract.save
      format.html { redirect_to [@insured, @insurance_contract], notice: "Insurance contract was successfully created." }
      format.json { render :show, status: :created }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @insurance_contract.errors, status: :unprocessable_entity }
    end
  end
end


  # PATCH/PUT /insurance_contracts/1 or /insurance_contracts/1.json
  def update
    respond_to do |format|
      if @insurance_contract.update(insurance_contract_params)
        format.html { redirect_to [@insured, @insurance_contract], notice: "Insurance contract was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @insurance_contract }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @insurance_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_contracts/1 or /insurance_contracts/1.json
  def destroy
    @insurance_contract.destroy!

    respond_to do |format|
      format.html { redirect_to @insured, notice: "Insurance contract was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def load_contract
      @agreement_rates = Agreement::Rate.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_contract
      @insurance_contract = InsuranceContract.find(params[:id])
    end

    def set_insured
      if params[:individual_id]
        @insured = Individual.find(params[:individual_id])
      elsif params[:coop_membership_id]
        @insured = CoopMembership.find(params[:coop_membership_id])
      else
        raise ActiveRecord::RecordNotFound, "Insured not found"
      end
    end

    # Only allow a list of trusted parameters through.
    def insurance_contract_params
      params.require(:insurance_contract).permit(:rate_id, :age, :amount_covered, :premium, :effectivity, :expiry)
    end
end
