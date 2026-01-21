class InsuranceGroupsController < ApplicationController
  before_action :set_insurance_group, only: %i[ show edit update destroy ]
  before_action :load_options, only: %i[ new create edit update ]

  # GET /insurance_groups or /insurance_groups.json
  def index
    @insurance_groups = InsuranceGroup.includes(:cooperative, :contract).all
  end

  # GET /insurance_groups/1 or /insurance_groups/1.json
  def show
    @insurance_group = InsuranceGroup.includes(
      cooperative: { coop_memberships: :individual },
      contract: :insurance_product
    ).find(params[:id])
    
    # Get all insurance contracts created through this group
    @group_insurance_contracts = InsuranceContract.where(insurance_group_id: @insurance_group.id)
  end

  # GET /insurance_groups/new
  def new
    @insurance_group = InsuranceGroup.new
  end

  # GET /insurance_groups/1/edit
  def edit
  end

  # POST /insurance_groups or /insurance_groups.json
  def create
    @insurance_group = InsuranceGroup.new(insurance_group_params)

    respond_to do |format|
      if @insurance_group.save
        format.html { redirect_to @insurance_group, notice: "Insurance group was successfully created." }
        format.json { render :show, status: :created, location: @insurance_group }
      else
        load_options
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @insurance_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_groups/1 or /insurance_groups/1.json
  def update
    respond_to do |format|
      if @insurance_group.update(insurance_group_params)
        format.html { redirect_to @insurance_group, notice: "Insurance group was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @insurance_group }
      else
        load_options
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @insurance_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_groups/1 or /insurance_groups/1.json
  def destroy
    @insurance_group.destroy!

    respond_to do |format|
      format.html { redirect_to insurance_groups_path, notice: "Insurance group was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  
  # GET /insurance_groups/:id/rates - AJAX endpoint to get filtered rates
  def rates_for_contract
    contract = Agreement::Contract.find(params[:contract_id])
    @rates = contract.agreement_rates.order(:age_from)
    
    respond_to do |format|
      format.json { render json: @rates.map { |r| { id: r.id, rate: r.rate, age_from: r.age_from, age_to: r.age_to, min_amount: r.min_amount, max_amount: r.max_amount } } }
    end
  end

  private
    def set_insurance_group
      @insurance_group = InsuranceGroup.find(params[:id])
    end
    
    def load_options
      @cooperatives = Cooperative.order(:name)
      @contracts = Agreement::Contract.includes(:insurance_product).order(:id)
    end

    def insurance_group_params
      params.require(:insurance_group).permit(:cooperative_id, :contract_id)
    end
end