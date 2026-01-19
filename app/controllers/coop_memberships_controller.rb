class CoopMembershipsController < ApplicationController
  before_action :set_coop_membership, only: %i[ show edit update destroy ]

  # GET /coop_memberships or /coop_memberships.json
  def index
    @coop_memberships = CoopMembership.all
  end

  # GET /coop_memberships/1 or /coop_memberships/1.json
  def show
    @coop_memberships = CoopMembership.all
  end

  # GET /coop_memberships/new
  def new
    @coop_membership = CoopMembership.new
    load_ci
  end

  # GET /coop_memberships/1/edit
  def edit
  end

  # POST /coop_memberships or /coop_memberships.json
  def create
    @coop_membership = CoopMembership.new(coop_membership_params)

    respond_to do |format|
      if @coop_membership.save
        format.html { redirect_to @coop_membership, notice: "Coop membership was successfully created." }
        format.json { render :show, status: :created, location: @coop_membership }
      else
        load_ci
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coop_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coop_memberships/1 or /coop_memberships/1.json
  def update
    respond_to do |format|
      if @coop_membership.update(coop_membership_params)
        format.html { redirect_to @coop_membership, notice: "Coop membership was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @coop_membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coop_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coop_memberships/1 or /coop_memberships/1.json
  def destroy
    @coop_membership.destroy!

    respond_to do |format|
      format.html { redirect_to coop_memberships_path, notice: "Coop membership was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop_membership
      @coop_membership = CoopMembership.find(params[:id])
    end
    
    def load_ci
      @cooperatives = Cooperative.all
      @individuals  = Individual.all
    end


    def get_cooperative
    @cooperatives = Cooperative.where(cooperative_id: params[:cooperative_id])
    respond_to do |format|
      format.json { render json: @cooperatives }
      end
    end

    def get_individual
    @individuals = Individual.where(individual_id: params[:individual_id])
    respond_to do |format|
      format.json { render json: @individuals }
      end
    end


    # Only allow a list of trusted parameters through.
    def coop_membership_params
      params.require(:coop_membership).permit(:cooperative_id, :individual_id, :membership_date)
    end
end
