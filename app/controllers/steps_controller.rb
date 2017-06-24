class StepsController < ApplicationController

  before_action :set_step, only: [:show, :edit, :update, :destroy]
  before_action :set_stage, :set_project, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  layout 'admin/layouts/admin'

  # GET /Steps
  def index
    @steps = Step.all
  end

  # GET /Steps/1
  def show
  end

  # GET /Steps/new
  def new
    @step = Step.new
    @step.stage = @stage
    #@step.project = @project
  end

  # GET /Steps/1/edit
  def edit
    @step.stage = @stage
  end

  # POST /Steps
  def create
    @step = Step.new(step_params)
    #@step.project = @project
    @step.stage = @stage

    if @step.save
      redirect_to edit_project_path(@project,tab: :stages), notice: 'Step was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /Steps/1
  def update
    _params = step_params
    if _params[:name].empty?
      _params[:name] = @step.name
    end

    if _params[:description].empty?
      _params[:description] = @step.description
    end

    if _params[:icon].empty?
      _params[:icon] = @step.icon
    end


    if @step.update(_params)
      redirect_to [@stage.project, @stage], notice: 'Step was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /Steps/1
  def destroy
    @step.destroy
    redirect_to [@stage.project, @stage], notice: 'Project was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_step
    @step = Step.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_stage
    @stage = Stage.find(params[:stage_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  # Only allow a trusted parameter "white list" through.
  def step_params
    params.require(:step).permit(:name, :description, :icon, :stage_id, :project_id)
  end

end
