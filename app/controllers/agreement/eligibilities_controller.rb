class Agreement::EligibilitiesController < ApplicationController
  before_action :set_agreement_eligibility, only: %i[ show edit update destroy ]

  # GET /agreement/eligibilities or /agreement/eligibilities.json
  def index
    @agreement_eligibilities = Agreement::Eligibility.all
  end

  # GET /agreement/eligibilities/1 or /agreement/eligibilities/1.json
  def show
    @agreement_eligibility = Agreement::Eligibility.find(params[:id])
  end

  # GET /agreement/eligibilities/new
  def new
    @agreement_eligibility = Agreement::Eligibility.new
  end

  # GET /agreement/eligibilities/1/edit
  def edit
  end

  # POST /agreement/eligibilities or /agreement/eligibilities.json
  def create
    @agreement_eligibility = Agreement::Eligibility.new(agreement_eligibility_params)

    respond_to do |format|
      if @agreement_eligibility.save
        format.html { redirect_to @agreement_eligibility, notice: "Eligibility was successfully created." }
        format.json { render :show, status: :created, location: @agreement_eligibility }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @agreement_eligibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agreement/eligibilities/1 or /agreement/eligibilities/1.json
  def update
    respond_to do |format|
      if @agreement_eligibility.update(agreement_eligibility_params)
        format.html { redirect_to @agreement_eligibility, notice: "Eligibility was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @agreement_eligibility }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @agreement_eligibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agreement/eligibilities/1 or /agreement/eligibilities/1.json
  def destroy
    @agreement_eligibility.destroy!

    respond_to do |format|
      format.html { redirect_to agreement_eligibilities_path, notice: "Eligibility was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agreement_eligibility
      @agreement_eligibility = Agreement::Eligibility.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agreement_eligibility_params
      params.require(:agreement_eligibility).permit(:eligibility_title, :dependent, :evidence_limit, :medical_limit, :contestability, :min_entry, :max_entry, :exit, :service, :commission, :min_confinement, :max_confinement)
    end
end
