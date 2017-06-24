class StagesController < ApplicationController
  before_action :set_stage, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  layout 'admin/layouts/admin'

  # GET /stages
  def index
    @stages = Stage.all
  end

  # GET /stages/1
  def show
  end

  # GET /stages/new
  def new
    @stage = Stage.new
    @stage.project = @project
  end

  # GET /stages/1/edit
  def edit
  end

  # POST /stages
  def create
    @stage = Stage.new(stage_params)
    @stage.project = @project

    if @stage.save
      redirect_to  edit_project_path(@project,tab: :stages), notice: 'Stage was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /stages/1
  def update
    _params = stage_params
    if _params[:name].empty?
      _params[:name] = @stage.name
    end

    if _params[:description].empty?
      _params[:description] = @stage.description
    end

    if @stage.update(_params)
      redirect_to  edit_project_path(@project,tab: :stages), notice: 'Stage was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /stages/1
  def destroy
    @stage.destroy
    redirect_to  edit_project_path(@project,tab: :stages), notice: 'Stage was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_stage
    @stage = Stage.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  # Only allow a trusted parameter "white list" through.
  def stage_params
    params.require(:stage).permit(:name, :description, :project_id, :jenkins_job)
  end

end
