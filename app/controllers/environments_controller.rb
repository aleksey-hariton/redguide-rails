class EnvironmentsController < Admin::ApplicationController
  before_action :set_environment, only: [:show]
  layout 'admin/layouts/admin'

  before_filter :check_auth, only: [:status_update]
  before_action :authenticate_user!

  def check_auth
    authenticate_or_request_with_http_basic do |username, password|
      resource = User.find_by_email(username)
      if resource && resource.valid_password?(password)
        sign_in :user, resource
      end
    end
  end

  # GET /environments
  def index
    @environments = []
    @organization = Organization.find(params[:organization_id])
    @environments << Environment.find_by(organization: @organization)
  end

  # GET /environments/1
  def show
    @organization = Organization.find(params[:organization_id])
  end

  # POST /environments
  def create
    @environment = Environment.new(environment_params)

    respond_to do |format|
      if @environment.save
        format.html { redirect_to organization_environment_path, notice: 'Environment was successfully created.' }
        format.json { render :show, status: :created, location: @environment}
      else
        format.html { render :new }
        format.json { render json: @environment.errors, status: :unprocessable_entity}
      end
    end
  end


  def status_update
    return unless params[:organization]
    return unless params[:environment]
    return unless params[:node]
    return unless params[:status]

    @organization = Organization.find_or_create_by(name: params[:organization])
    @environment = Environment.find_or_create_by(name: params[:environment], organization: @organization)
    @node = Node.find_or_create_by(name: params[:node], environment: @environment)
    @node.status = params[:status].to_i

    @error_report = ErrorReport.new(
      node: @node,
      environment: @environment,
      stacktrace: params[:stacktrace],
      error_passed: params[:error_passed],
      error_msg: params[:error_msg],
      status: params[:status]
    )

    @node.save
    @error_report.save

    respond_to do |format|
      format.json {render :status_update}
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Environment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def environment_params
      params.require(:environment).permit(:name, :organization_id)
    end
end
