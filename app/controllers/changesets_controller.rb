class ChangesetsController < Admin::ApplicationController
  before_action :set_changeset, only: [:show, :edit, :update, :destroy, :build_cookbook, :stage_status, :check_pr, :build_details]
  before_action :set_project

  layout 'admin/layouts/admin'

  # GET /changesets
  def index
    @changesets = @project.changesets
  end

  # GET /changesets/1
  def show
  end

  def console
    @cookbook_build = CookbookBuild.find(params[:build_id])
  end

  def build_cookbook
    build = @changeset.cookbook_builds.find(params[:cookbook_build_id])
    build.build
  end

  def check_pr
    build = @changeset.cookbook_builds.find(params[:cookbook_build_id])
    build.pull_request.delay.check
  end

  # GET /changesets/new
  def new
    @changeset = Changeset.new
    @changeset.project = @project
    @changeset.author = current_user
  end

  # GET /changesets/1/edit
  def edit
  end

  # POST /changesets
  def create
    @changeset = Changeset.new(changeset_params)
    @changeset.project = @project
    @changeset.author = current_user

    if @changeset.save
      redirect_to [@project, @changeset], notice: 'Changeset was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /changesets/1
  def update
    if @changeset.update(changeset_params)
      redirect_to [@project, @changeset], notice: 'Changeset was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /changesets/1
  def destroy
    @changeset.destroy
    redirect_to project_changesets_url, notice: 'Changeset was successfully destroyed.'
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
      params.require(:changeset).permit(:key, :project_id, :description, :slug)
    end
end
