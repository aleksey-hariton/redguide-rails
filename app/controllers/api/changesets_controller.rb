module Api
  class ChangesetsController < Api::ApiController
    before_action :set_changeset, only: [:show, :add_cookbook, :destroy, :push, :notify]
    before_action :set_project

    def add_cookbook
      @cookbook = Cookbook.find_by(name: params[:cookbook][:name], project_id: @project.id)
      if @cookbook
        cookbook_build = @changeset.add_cookbook(@cookbook)
        if cookbook_build[:status]
          render :show
        else
          render partial: 'api/shared/error', status: :bad_request, locals: {error_obj: cookbook_build[:build]}
        end
      else
        render partial: 'api/shared/error', status: :not_found, notice: "Cookbook with name '#{params[:cookbook][:name]}' not found"
      end
    end

    def notify
      cookbook = Cookbook.find_by(name: params[:cookbook_build][:cookbook], project_id: @project.id)
      build = CookbookBuild.find_by(changeset_id: @changeset.id, cookbook_id: cookbook.id)
      case params[:cookbook_build][:stage]
        when 'foodcritic'
          build.foodcritic_status = params[:cookbook_build][:status]
        when 'cookstyle'
          build.cookstyle_status = params[:cookbook_build][:status]
        when 'rspec'
          build.rspec_status = params[:cookbook_build][:status]
        when 'kitchen'
          build.kitchen_status = params[:cookbook_build][:status]
        else
          ''
      end
      build.save
      render partial: 'api/shared/error'
    end

    def push
      params[:cookbooks].each do |cookbook_name, value|
        cookbook = Cookbook.find_by(name: cookbook_name, project_id: @project.id)
        if cookbook
          @changeset.project.stages.select { |stage| stage.stage_type == 'Cookbook' }.each do |stage|
            cookbook_build = @changeset.cookbook_builds.find_by(cookbook_id: cookbook.id)
            unless cookbook_build
              cookbook_build = @changeset.add_cookbook(cookbook)[:build]
            end
            cookbook_build.reset if cookbook_build.commit_sha != value[:commit_sha]
            cookbook_build.commit_sha = value[:commit_sha]
            cookbook_build.remote_branch = value[:remote_branch]
            cookbook_build.stage_id = stage.id
            cookbook_build.save
          end
        else
          render partial: 'api/shared/error', status: :not_found, notice: "Cookbook with name '#{params[:name]}' not found"
          return
        end
      end
      render :show
    end

    # GET /changesets
    def index
      @changesets = @project.changesets
    end

    # GET /changesets/1
    def show
    end

    # POST /changesets
    def create
      @changeset = Changeset.new(changeset_params)
      @changeset.project = @project
      @changeset.author = current_user

      if @changeset.save
        render :show
      else
        render partial: 'api/shared/error', locals: {error_obj: @changeset}, status: :bad_request
      end
    end

    # DELETE /changesets/1
    def destroy
      @changeset.destroy
      render :index, notice: 'Changeset was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_changeset
        @changeset = Changeset.friendly.find(params[:id] || params[:changeset_id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.friendly.find(params[:project_id])
      end

      # Only allow a trusted parameter "white list" through.
      def changeset_params
        params.require(:changeset).permit(:key, :project_id, :description)
      end

      # Only allow a trusted parameter "white list" through.
      def add_cookbook_params
        params.require(:cookbook).permit(:name)
      end
  end
end