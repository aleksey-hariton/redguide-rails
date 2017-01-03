class CookbooksController < Admin::ApplicationController
  before_action :set_cookbook, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  layout 'admin/layouts/admin'

  # GET /cookbooks
  def index
    @cookbooks = @project.cookbooks
  end

  # GET /cookbooks/1
  def show
  end

  # GET /cookbooks/new
  def new
    @cookbook = Cookbook.new
    @cookbook.project = @project
  end

  # GET /cookbooks/1/edit
  def edit
  end

  # POST /cookbooks
  def create
    @cookbook = Cookbook.new(cookbook_params)
    @cookbook.project = @project

    if @cookbook.save
      redirect_to [@cookbook.project, @cookbook], notice: 'Cookbook was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cookbooks/1
  def update
    if @cookbook.update(cookbook_params)
      redirect_to [@cookbook.project, @cookbook], notice: 'Cookbook was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cookbooks/1
  def destroy
    @cookbook.destroy
    redirect_to project_cookbooks_url, notice: 'Cookbook was successfully destroyed.'
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
