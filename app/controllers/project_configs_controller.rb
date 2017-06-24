class ProjectConfigsController < Admin::ApplicationController
  before_action :set_project_config, only: [:edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :edit, :update, :destroy]

  layout 'admin/layouts/admin'

  # GET /project_configs/new
  def new
    @project_config = ProjectConfig.new
    @project_config.project = @project
  end

  # GET /project_configs/1/edit
  def edit
  end

  # POST /project_configs
  def create
    @project_config = ProjectConfig.new(project_config_params)
    @project_config.project = @project

    if @project_config.save
      redirect_to edit_project_path(@project_config.project), notice: 'Project config was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /project_configs/1
  def update
    if @project_config.update(project_config_params)
      redirect_to edit_project_path(@project_config.project), notice: 'Project config was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /project_configs/1
  def destroy
    @project_config.destroy
    redirect_to project_project_configs_url, notice: 'Project config was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_config
      @project_config = ProjectConfig.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by(key: params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_config_params
      params.require(:project_config).permit(:name, :content)
    end
end
