class AddRegionsController < ApplicationController
  before_action :set_add_region, only: %i[ show edit update destroy ]

  # GET /add_regions or /add_regions.json
  def index
    @add_regions = AddRegion.all
  end

  # GET /add_regions/1 or /add_regions/1.json
  def show
  end

  # GET /add_regions/new
  def new
    @add_region = AddRegion.new
  end

  # GET /add_regions/1/edit
  def edit
  end

  # POST /add_regions or /add_regions.json
  def create
    @add_region = AddRegion.new(add_region_params)

    respond_to do |format|
      if @add_region.save
        format.html { redirect_to @add_region, notice: "Add region was successfully created." }
        format.json { render :show, status: :created, location: @add_region }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @add_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_regions/1 or /add_regions/1.json
  def update
    respond_to do |format|
      if @add_region.update(add_region_params)
        format.html { redirect_to @add_region, notice: "Add region was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @add_region }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @add_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_regions/1 or /add_regions/1.json
  def destroy
    @add_region.destroy!

    respond_to do |format|
      format.html { redirect_to add_regions_path, notice: "Add region was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_region
      @add_region = AddRegion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_region_params
      params.require(:add_region).permit(:name)
    end
end
