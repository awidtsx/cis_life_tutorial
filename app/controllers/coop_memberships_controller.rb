class CoopMembershipsController < ApplicationController
  before_action :set_coop_membership, only: %i[ show edit update destroy ]

  # GET /coop_memberships or /coop_memberships.json
  def index
    @coop_memberships = CoopMembership.includes(
      cooperative: [:region, :province, :municipal, :barangay],
      individual: [],
      insurance_contracts: []
    ).order(created_at: :desc)
  end

  # GET /coop_memberships/1 or /coop_memberships/1.json
  def show
    @coop_membership = CoopMembership.includes(
      cooperative: [:region, :province, :municipal, :barangay, :coop_memberships],
      individual: [],
      insurance_contracts: [:agreement]
    ).find(params[:id])
  end

  # GET /coop_memberships/new
  def new
    @coop_membership = CoopMembership.new
    
    # Pre-populate from params if provided
    @coop_membership.cooperative_id = params[:cooperative_id] if params[:cooperative_id]
    @coop_membership.individual_id = params[:individual_id] if params[:individual_id]
    
    load_ci
  end

  # GET /coop_memberships/1/edit
  def edit
    load_ci
  end

  # POST /coop_memberships or /coop_memberships.json
  def create
    @coop_membership = CoopMembership.new(coop_membership_params)

    respond_to do |format|
      if @coop_membership.save
        format.html { redirect_to @coop_membership, notice: "Cooperative membership was successfully created." }
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
        format.html { redirect_to @coop_membership, notice: "Cooperative membership was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @coop_membership }
      else
        load_ci
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coop_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coop_memberships/1 or /coop_memberships/1.json
  def destroy
    @coop_membership.destroy!

    respond_to do |format|
      format.html { redirect_to coop_memberships_path, notice: "Cooperative membership was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop_membership
      @coop_membership = CoopMembership.find(params[:id])
    end
    
    def load_ci
      @cooperatives = Cooperative.includes(:region, :province, :municipal, :barangay).order(:name)
      @individuals  = Individual.order(:last_name, :first_name)
    end

    # Only allow a list of trusted parameters through.
    def coop_membership_params
      params.require(:coop_membership).permit(:cooperative_id, :individual_id, :membership_date)
    end
end