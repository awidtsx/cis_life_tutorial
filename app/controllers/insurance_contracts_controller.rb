class InsuranceContractsController < ApplicationController
  before_action :set_insured
  before_action :set_insurance_contract, only: %i[ show edit update destroy ]
  before_action :load_contract, only: %i[ new create edit update ]
  
  def index
    @insurance_contracts = InsuranceContract.all
  end

  def show
  end

  def new
    @insurance_contract = if @insured.is_a?(InsuranceGroup)
      InsuranceContract.new
    else
      @insured.insurance_contracts.build
    end
  end

  def edit
  end

  def create
    if @insured.is_a?(InsuranceGroup)
      create_group_member_contract
    else
      create_individual_contract
    end
  end

  def update
    if insurance_contract_params[:amount_covered].present? && 
       insurance_contract_params[:effectivity].present? && 
       insurance_contract_params[:expiry].present?
      
      term = calculate_term(
        insurance_contract_params[:effectivity].to_date, 
        insurance_contract_params[:expiry].to_date
      )
      rate = 0
      
      if @insured.is_a?(Individual)
        if params[:insurance_contract][:custom_rate].present?
          rate = params[:insurance_contract][:custom_rate].to_f
        end
      else
        agreement_id = insurance_contract_params[:agreement_id]
        agreement_type = insurance_contract_params[:agreement_type]
        
        if agreement_type == 'Agreement::Rate'
          agreement = Agreement::Rate.find_by(id: agreement_id)
          rate = agreement&.rate.to_f || 0
        end
      end
      
      premium = (insurance_contract_params[:amount_covered].to_f / 1000) * rate * term
      
      params_with_calculations = insurance_contract_params.to_h.merge(
        premium: premium,
        rate: rate
      )
      
      respond_to do |format|
        if @insurance_contract.update(params_with_calculations)
          format.html { redirect_to [@insured, @insurance_contract], notice: "Insurance contract was successfully updated.", status: :see_other }
          format.json { render :show, status: :ok, location: @insurance_contract }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @insurance_contract.errors, status: :unprocessable_entity }
        end
      end
    else
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
  end

  def destroy
    @insurance_contract.destroy!

    respond_to do |format|
      format.html { redirect_to @insured, notice: "Insurance contract was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def load_contract
    @agreement_rates = Agreement::Rate.order(:age_from)
    @agreement_contracts = Agreement::Contract.includes(:contractable, :insurance_product).order(:id)
    
    if @insured.is_a?(InsuranceGroup)
      @group_contract = @insured.contract
      @available_rates = @group_contract&.agreement_rates || []
      @members = @insured.cooperative.coop_memberships.includes(:individual)
    end
    
    if @insured.is_a?(Individual)
      @individual_contracts = Agreement::Contract
        .where(contractable_type: 'Individual', contractable_id: @insured.id)
        .includes(:insurance_product)
        .order(:id)
    end
  end

  private
    def set_insurance_contract
      @insurance_contract = InsuranceContract.find(params[:id])
    end

    def set_insured
      if params[:individual_id]
        @insured = Individual.find(params[:individual_id])
      elsif params[:coop_membership_id]
        @insured = CoopMembership.find(params[:coop_membership_id])
      elsif params[:insurance_group_id]
        @insured = InsuranceGroup.find(params[:insurance_group_id])
      else
        raise ActiveRecord::RecordNotFound, "Insured not found"
      end
    end
    
    def calculate_term(start_date, end_date)
      return 0 if start_date.blank? || end_date.blank?
      (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
    end

    def create_individual_contract
      @insurance_contract = @insured.insurance_contracts.build(insurance_contract_params)
      
      if @insurance_contract.amount_covered.present? && 
         @insurance_contract.effectivity.present? && 
         @insurance_contract.expiry.present?
        
        term = calculate_term(@insurance_contract.effectivity, @insurance_contract.expiry)
        rate = 0
        
        if @insured.is_a?(Individual)
          if params[:insurance_contract][:custom_rate].present?
            rate = params[:insurance_contract][:custom_rate].to_f
            @insurance_contract.rate = rate
          end
        else
          if @insurance_contract.agreement_type == 'Agreement::Rate' && @insurance_contract.agreement
            rate = @insurance_contract.agreement.rate.to_f
            @insurance_contract.rate = rate
          end
        end
        
        @insurance_contract.premium = (@insurance_contract.amount_covered.to_f / 1000) * rate * term
      end

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

    def create_group_member_contract
      coop_membership_id = params[:insurance_contract][:coop_membership_id]
      
      unless coop_membership_id.present?
        @insurance_contract = InsuranceContract.new(insurance_contract_params)
        @insurance_contract.errors.add(:coop_membership_id, "must be selected")
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
        end
        return
      end
      
      coop_membership = CoopMembership.find(coop_membership_id)
      
      # Build the insurance contract for the selected member
      @insurance_contract = coop_membership.insurance_contracts.build(
        insurance_contract_params.except(:coop_membership_id)
      )
      
      if @insurance_contract.amount_covered.present? && 
         @insurance_contract.effectivity.present? && 
         @insurance_contract.expiry.present? &&
         @insurance_contract.agreement_id.present?
        
        term = calculate_term(@insurance_contract.effectivity, @insurance_contract.expiry)
        
        # Get rate from Agreement::Rate
        if @insurance_contract.agreement_type == 'Agreement::Rate'
          agreement_rate = Agreement::Rate.find(@insurance_contract.agreement_id)
          rate = agreement_rate.rate.to_f
          @insurance_contract.rate = rate
          @insurance_contract.premium = (@insurance_contract.amount_covered.to_f / 1000) * rate * term
        end
      end

      respond_to do |format|
        if @insurance_contract.save
          format.html { redirect_to @insured, notice: "Insurance contract was successfully created for #{coop_membership.individual.full_name}." }
          format.json { render :show, status: :created }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @insurance_contract.errors, status: :unprocessable_entity }
        end
      end
    end

    def insurance_contract_params
      params.require(:insurance_contract).permit(
        :agreement_id, :agreement_type, :age, :amount_covered, 
        :premium, :rate, :effectivity, :expiry, :coop_membership_id
      )
    end
end