class AddMunicipalsController < ApplicationController
  before_action :set_add_municipal, only: %i[ show edit update destroy ]

  # GET /add_municipals or /add_municipals.json
  def index
    @add_municipals = AddMunicipal.all
  end

  # GET /add_municipals/1 or /add_municipals/1.json
  def show
  end

  # GET /add_municipals/new
  def new
    @add_municipal = AddMunicipal.new
  end

  # GET /add_municipals/1/edit
  def edit
  end

  # POST /add_municipals or /add_municipals.json
  def create
    @add_municipal = AddMunicipal.new(add_municipal_params)

    respond_to do |format|
      if @add_municipal.save
        format.html { redirect_to @add_municipal, notice: "Add municipal was successfully created." }
        format.json { render :show, status: :created, location: @add_municipal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @add_municipal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_municipals/1 or /add_municipals/1.json
  def update
    respond_to do |format|
      if @add_municipal.update(add_municipal_params)
        format.html { redirect_to @add_municipal, notice: "Add municipal was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @add_municipal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @add_municipal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_municipals/1 or /add_municipals/1.json
  def destroy
    @add_municipal.destroy!

    respond_to do |format|
      format.html { redirect_to add_municipals_path, notice: "Add municipal was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_municipal
      @add_municipal = AddMunicipal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_municipal_params
      params.require(:add_municipal).permit(:name, :add_province_id)
    end
end
