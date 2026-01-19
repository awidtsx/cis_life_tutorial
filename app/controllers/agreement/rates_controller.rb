class Agreement::RatesController < ApplicationController
  before_action :set_agreement_rate, only: %i[ show edit update destroy ]
  before_action :load_rate, only: %i[ new create edit update ]
  # GET /agreement/rates or /agreement/rates.json
  def index
    @agreement_rates = Agreement::Rate.all
  end

  # GET /agreement/rates/1 or /agreement/rates/1.json
  def show
    @agreement_rates = Agreement::Rate.all
  end

  # GET /agreement/rates/new
  def new
    @agreement_rate = Agreement::Rate.new
  end

  # GET /agreement/rates/1/edit
  def edit
  end

  # POST /agreement/rates or /agreement/rates.json
  def create
    @agreement_rate = Agreement::Rate.new(agreement_rate_params)

    respond_to do |format|
      if @agreement_rate.save
        format.html { redirect_to @agreement_rate, notice: "Rate was successfully created." }
        format.json { render :show, status: :created, location: @agreement_rate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @agreement_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agreement/rates/1 or /agreement/rates/1.json
  def update
    respond_to do |format|
      if @agreement_rate.update(agreement_rate_params)
        format.html { redirect_to @agreement_rate, notice: "Rate was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @agreement_rate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @agreement_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agreement/rates/1 or /agreement/rates/1.json
  def destroy
    @agreement_rate.destroy!

    respond_to do |format|
      format.html { redirect_to agreement_rates_path, notice: "Rate was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agreement_rate
      @agreement_rate = Agreement::Rate.find(params[:id])
    end

    def load_rate
      @agreement_contracts = Agreement::Contract.all
    end
    
    def get_rate
    @agreement_contracts = Agreement::Contract.where(contract_id: params[:contract_id])
    respond_to do |format|
      format.json { render json: @products }
      end
    end

    # Only allow a list of trusted parameters through.
    def agreement_rate_params
      params.require(:agreement_rate).permit(:contract_id, :age_from, :age_to, :rate, :min_amount, :max_amount)
    end
end
