module Api
class ProjectConfigsController < Api::ApiController
    before_action :set_project_config, only: [:show]
    before_action :set_project

    # GET /project_configs
    def index
      @project_configs = ProjectConfig.all
    end

    # GET /project_configs/1
    def show
    end

    def get_by_name
      @conf = ProjectConfig.find_by(name: params[:name])
    end

    # POST /project_configs
    def create
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
end