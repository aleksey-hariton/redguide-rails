class PrconfigsController < Admin::ApplicationController
  before_action :set_prconfig, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  layout 'admin/layouts/admin'

  # GET /prconfigs
  def index
    @prconfigs = Prconfig.all
  end

  # GET /prconfigs/1
  def show
  end

  # GET /prconfigs/new
  def new
    @prconfig = Prconfig.new
    @prconfig.project = @project
  end

  # GET /prconfigs/1/edit
  def edit
  end

  # POST /prconfigs
  def create
    puts "PRCONFIG PARAMS config1: #{prconfig_params[:prconfigs]}"
    @prconfig = Prconfig.new(prconfig_params)
    @prconfig.project = @project

    if @prconfig.save
      redirect_to [@prconfig.project, @prconfig], notice: 'Prconfig was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /prconfigs/1
  def update
    if @prconfig.update(prconfig_params)
      redirect_to [@prconfig.project, @prconfig], notice: 'Prconfig was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /prconfigs/1
  def destroy
    @prconfig.destroy
    redirect_to project_prconfigs_url, notice: 'Prconfig was successfully destroyed.'
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
