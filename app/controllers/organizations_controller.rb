class OrganizationsController < Admin::ApplicationController
  before_action :set_organization, only: [:show,]
  layout 'admin/layouts/admin'

  # GET /organizations
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  def show
  end


  # POST /organizations
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def organization_params
      params.require(:organization).permit(:name)
    end
end
