class CooperativesController < ApplicationController
  before_action :set_cooperative, only: %i[ show edit update destroy ]

  # GET /cooperatives or /cooperatives.json
  def index
    @cooperatives = Cooperative.includes(:region, :province, :municipal, :barangay, :coop_memberships).all
  end

  # GET /cooperatives/1 or /cooperatives/1.json
  def show
    @cooperative = Cooperative.includes(
      :region, :province, :municipal, :barangay,
      coop_memberships: :individual,
      contracts: :insurance_product
    ).find(params[:id])
  end

  # GET /cooperatives/new
  def new
    @cooperative = Cooperative.new
    load_location
  end

  # GET /cooperatives/1/edit
  def edit
    # Location data is already loaded by existing location relationships
  end

  # POST /cooperatives or /cooperatives.json
  def create
    @cooperative = Cooperative.new(cooperative_params)

    respond_to do |format|
      if @cooperative.save
        format.html { redirect_to @cooperative, notice: "Cooperative was successfully created." }
        format.json { render :show, status: :created, location: @cooperative }
      else
        load_location
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cooperative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cooperatives/1 or /cooperatives/1.json
  def update
    respond_to do |format|
      if @cooperative.update(cooperative_params)
        format.html { redirect_to @cooperative, notice: "Cooperative was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @cooperative }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cooperative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cooperatives/1 or /cooperatives/1.json
  def destroy
    @cooperative.destroy!

    respond_to do |format|
      format.html { redirect_to cooperatives_path, notice: "Cooperative was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # AJAX endpoints for cascading dropdowns
  def provinces_for_region
    @provinces = AddProvince.where(add_region_id: params[:add_region_id]).order(:name)
    respond_to do |format|
      format.json { render json: @provinces }
    end
  end

  def municipals_for_province
    @municipals = AddMunicipal.where(add_province_id: params[:add_province_id]).order(:name)
    respond_to do |format|
      format.json { render json: @municipals }
    end
  end

  def barangays_for_municipal
    @barangays = AddBarangay.where(add_municipal_id: params[:add_municipal_id]).order(:name)
    respond_to do |format|
      format.json { render json: @barangays }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cooperative
      @cooperative = Cooperative.find(params[:id])
    end

    def load_location
      @regions     = AddRegion.order(:name)
      @provinces   = AddProvince.none
      @municipals  = AddMunicipal.none
      @barangays   = AddBarangay.none
    end

    # Only allow a list of trusted parameters through.
    def cooperative_params
      params.require(:cooperative).permit(:name, :add_region_id, :add_province_id, :add_municipal_id, :add_barangay_id)
    end
end