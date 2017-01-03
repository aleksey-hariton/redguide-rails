module Api
  class CookbooksController < Api::ApiController
    before_action :set_cookbook, only: [:show]
    before_action :set_project, only: [:index, :show]

    # GET /cookbooks
    def index
      @cookbooks = @project.cookbooks
    end

    # GET /cookbooks/1
    def show
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_cookbook
        @cookbook = Cookbook.friendly.find(params[:id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.friendly.find(params[:project_id])
      end

      # Only allow a trusted parameter "white list" through.
      def cookbook_params
        params.require(:cookbook).permit(:name, :vcs_url, :project_id)
      end
  end
end