module Api
  class ProjectsController < Api::ApiController
    before_action :set_project, only: [:show]

    # GET /projects
    def index
      @projects = Project.all
    end

    # GET /projects/1
    def show
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:key, :description, :slug)
    end
  end
end