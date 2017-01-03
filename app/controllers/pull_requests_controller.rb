class PullRequestsController < Admin::ApplicationController
  before_action :set_pull_request, only: [:show, :edit, :update, :destroy]
  layout 'admin/layouts/admin'

  # GET /pull_requests
  def index
    @pull_requests = PullRequest.all
  end

  # GET /pull_requests/1
  def show
  end

  # GET /pull_requests/new
  def new
    @pull_request = PullRequest.new
  end

  # GET /pull_requests/1/edit
  def edit
  end

  # POST /pull_requests
  def create
    @pull_request = PullRequest.new(pull_request_params)

    if @pull_request.save
      redirect_to @pull_request, notice: 'Pull request was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pull_requests/1
  def update
    if @pull_request.update(pull_request_params)
      redirect_to @pull_request, notice: 'Pull request was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pull_requests/1
  def destroy
    @pull_request.destroy
    redirect_to pull_requests_url, notice: 'Pull request was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pull_request
      @pull_request = PullRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pull_request_params
      params.require(:pull_request).permit(:url, :short, :status, :message, :cookbook_build_id)
    end
end
