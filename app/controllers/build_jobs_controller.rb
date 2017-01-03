class BuildJobsController < Admin::ApplicationController
  before_action :set_build_job, only: [:show, :edit, :update, :destroy]
  layout 'admin/layouts/admin'

  # GET /build_jobs
  def index
    @build_jobs = BuildJob.all
  end

  # GET /build_jobs/1
  def show
  end

  # GET /build_jobs/new
  def new
    @build_job = BuildJob.new
  end

  # GET /build_jobs/1/edit
  def edit
  end

  # POST /build_jobs
  def create
    @build_job = BuildJob.new(build_job_params)

    if @build_job.save
      redirect_to @build_job, notice: 'Build job was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /build_jobs/1
  def update
    if @build_job.update(build_job_params)
      redirect_to @build_job, notice: 'Build job was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /build_jobs/1
  def destroy
    @build_job.destroy
    redirect_to build_jobs_url, notice: 'Build job was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build_job
      @build_job = BuildJob.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def build_job_params
      params.require(:build_job).permit(:name, :url, :console_out, :status)
    end
end
