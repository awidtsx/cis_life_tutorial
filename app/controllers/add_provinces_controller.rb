class AddProvincesController < ApplicationController
  before_action :set_add_province, only: %i[ show edit update destroy ]

  # GET /add_provinces or /add_provinces.json
  def index
    @add_provinces = AddProvince.all
  end

  # GET /add_provinces/1 or /add_provinces/1.json
  def show
  end

  # GET /add_provinces/new
  def new
    @add_province = AddProvince.new
  end

  # GET /add_provinces/1/edit
  def edit
  end

  # POST /add_provinces or /add_provinces.json
  def create
    @add_province = AddProvince.new(add_province_params)

    respond_to do |format|
      if @add_province.save
        format.html { redirect_to @add_province, notice: "Add province was successfully created." }
        format.json { render :show, status: :created, location: @add_province }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @add_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_provinces/1 or /add_provinces/1.json
  def update
    respond_to do |format|
      if @add_province.update(add_province_params)
        format.html { redirect_to @add_province, notice: "Add province was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @add_province }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @add_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_provinces/1 or /add_provinces/1.json
  def destroy
    @add_province.destroy!

    respond_to do |format|
      format.html { redirect_to add_provinces_path, notice: "Add province was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_province
      @add_province = AddProvince.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_province_params
      params.require(:add_province).permit(:name, :add_region_id)
    end
end
