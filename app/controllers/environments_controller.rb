class EnvironmentsController < Admin::ApplicationController
  before_action :set_environment, only: [:show, :edit, :update, :destroy]
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

  # GET /environments/new
  def new
    @organization = Organization.find(params[:organization_id])
    @environment = Environment.new(organization: @organization)

  end

  # GET /environments/1/edit
  def edit
    @organization = Organization.find(params[:organization_id])
  end

  # POST /environments
  def create
    @environment = Environment.new(environment_params)

    respond_to do |format|
      if @environment.save
        format.html { redirect_to @environment, notice: 'Environment was successfully created.' }
        format.json { render :show, status: :created, location: @environment}
      else
        format.html { render :new }
        format.json { render json: @environment.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /environments/1
  def update
    respond_to do |format|
      if @environment.update(environment_params)
        format.html { redirect_to @environment, notice: 'Environment was successfully updated.' }
        format.json { render :show, status: :created, location: @environment}
      else
        format.html { render :edit }
        format.json { render json: @environment.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /environments/1
  def destroy
    @environment.destroy

    respond_to do |format|
      format.html { redirect_to environments_url, notice: 'Environment was successfully destroyed.' }
      format.json { head :no_content }
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

    if @node.status == Node::STATUS_NOK
      @error_report = ErrorReport.new(
        node: @node,
        stacktrace: params[:stacktrace],
        error_passed: params[:error_passed],
        error_msg: params[:error_msg]
      )

      @error_report.save
    end

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
