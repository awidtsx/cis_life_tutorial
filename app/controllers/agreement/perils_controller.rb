class Agreement::PerilsController < ApplicationController
  before_action :set_agreement_peril, only: %i[ show edit update destroy ]
  before_action :set_agreement_eligibility

  # GET /agreement/perils or /agreement/perils.json
  def index
    if params[:eligibility_id]
      # Nested route - perils for specific eligibility
      @agreement_eligibility = Agreement::Eligibility.find(params[:eligibility_id])
      @agreement_perils = @agreement_eligibility.agreement_perils
    else
      # Standalone route - all perils
      @agreement_perils = Agreement::Peril.all
    end
  end

  # GET /agreement/perils/1 or /agreement/perils/1.json
  def show
  end

  # GET /agreement/perils/new
  def new
      @agreement_eligibility = Agreement::Eligibility.find(params[:eligibility_id])
      @agreement_peril = @agreement_eligibility.agreement_perils.build
  end

  # GET /agreement/perils/1/edit
  def edit
  end

  # POST /agreement/perils or /agreement/perils.json
  def create
    @agreement_peril = @agreement_eligibility.agreement_perils.build(agreement_peril_params)

    respond_to do |format|
      if @agreement_peril.save
        format.html { redirect_to agreement_eligibility_path(@agreement_eligibility), notice: "Peril was successfully created." }
        format.json { render :show, status: :created, location: @agreement_peril }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @agreement_peril.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agreement/perils/1 or /agreement/perils/1.json
  def update
    respond_to do |format|
      if @agreement_peril.update(agreement_peril_params)
        format.html { redirect_to agreement_eligibility_path(@agreement_eligibility), notice: "Peril was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: [@agreement_eligibility, @agreement_peril] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @agreement_peril.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agreement/perils/1 or /agreement/perils/1.json
  def destroy
    @agreement_peril.destroy!

    respond_to do |format|
      format.html { redirect_to agreement_eligibility_path(@agreement_eligibility), notice: "Peril was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agreement_peril
      @agreement_peril = Agreement::Peril.find(params[:id])
    end

    def set_agreement_eligibility
    @agreement_eligibility = Agreement::Eligibility.find(params[:eligibility_id])
    end

    # Only allow a list of trusted parameters through.
    def agreement_peril_params
      params.require(:agreement_peril).permit(:peril,
    :coverage,
    :premium,
    :description,
    :acronym)
    end
end
