module Api
class PrconfigsController < Api::ApiController
    before_action :set_prconfig, only: [:show]
    before_action :set_project

    # GET /prconfigs
    def index
      @prconfigs = Prconfig.all
    end

    # GET /prconfigs/1
    def show
    end

    def get_by_name
      @conf = Prconfig.find_by(name: params[:name])
    end

    # POST /prconfigs
    def create
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_prconfig
        @prconfig = Prconfig.find(params[:id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find_by(key: params[:project_id])
      end

      # Only allow a trusted parameter "white list" through.
      def prconfig_params
        params.require(:prconfig).permit(:name, :content)
      end
  end
end