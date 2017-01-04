module Api
  class CookbooksController < Api::ApiController
    before_action :set_cookbook, only: [:show]
    before_action :set_project

    # GET /cookbooks
    def index
      @cookbooks = @project.cookbooks
    end

    # GET /cookbooks/1
    def show
    end

    # POST /cookbooks
    def create
      @cookbook = Cookbook.new(cookbook_params)
      @cookbook.project = @project

      if @cookbook.save
        render :show
      else
        render partial: 'api/shared/error', locals: {error_obj: @cookbook}, status: :bad_request
      end
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