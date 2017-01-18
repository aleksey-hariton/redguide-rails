class ProjectsController < Admin::ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  layout 'admin/layouts/admin'

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    _params = project_params
    if _params[:jenkins_password].empty?
      _params[:jenkins_password] = @project.jenkins_password
    end

    if _params[:vcs_server_user_password].empty?
      _params[:vcs_server_user_password] = @project.vcs_server_user_password
    end

    if @project.update(_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(
          :key,
          :description,
          :cookbook_build_job,
          :jenkins_host,
          :jenkins_user,
          :jenkins_password,
          :vcs_server,
          :vcs_server_user,
          :vcs_server_user_password,
          :vcs_server_project,
          :environment_build_job,
          :foodcritic_config,
          :cookstyle_config,
          :kitchen_config,
          :chef_server_url,
          :chef_user,
          :chef_user_pem,
          :supermarket_url
      )
    end
end
