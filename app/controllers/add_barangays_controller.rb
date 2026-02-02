class AddBarangaysController < ApplicationController
  before_action :set_add_barangay, only: %i[ show edit update destroy ]

  # GET /add_barangays or /add_barangays.json
  def index
    @add_barangays = AddBarangay.all
  end

  # GET /add_barangays/1 or /add_barangays/1.json
  def show
  end

  # GET /add_barangays/new
  def new
    @add_barangay = AddBarangay.new
  end

  # GET /add_barangays/1/edit
  def edit
  end

  # POST /add_barangays or /add_barangays.json
  def create
    @add_barangay = AddBarangay.new(add_barangay_params)

    respond_to do |format|
      if @add_barangay.save
        format.html { redirect_to @add_barangay, notice: "Add barangay was successfully created." }
        format.json { render :show, status: :created, location: @add_barangay }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @add_barangay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_barangays/1 or /add_barangays/1.json
  def update
    respond_to do |format|
      if @add_barangay.update(add_barangay_params)
        format.html { redirect_to @add_barangay, notice: "Add barangay was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @add_barangay }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @add_barangay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_barangays/1 or /add_barangays/1.json
  def destroy
    @add_barangay.destroy!

    respond_to do |format|
      format.html { redirect_to add_barangays_path, notice: "Add barangay was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_barangay
      @add_barangay = AddBarangay.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_barangay_params
      params.require(:add_barangay).permit(:name, :add_municipal_id)
    end
end
