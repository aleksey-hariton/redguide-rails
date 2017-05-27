class ErrorReportsController < Admin::ApplicationController
  before_action :set_error_report, only: [:show]
  layout 'admin/layouts/admin'

  # GET /error_reports
  def index
    @organization = Organization.find(params[:organization_id])
    @environment = Environment.find(params[:environment_id])
    @node = Node.find(params[:node_id])
    @error_reports = []
    @error_reports << ErrorReport.find_by(node: @node)
  end

  # GET /error_reports/1
  def show
    @organization = Organization.find(params[:organization_id])
    @environment = Environment.find(params[:environment_id])
    @node = Node.find(params[:node_id])
  end


  # POST /error_reports
  def create
    @error_report = ErrorReport.new(error_report_params)

    respond_to do |format|
      if @error_report.save
        format.html { redirect_to @error_report, notice: 'Error report was successfully created.' }
        format.json { render :show, status: :created, location: @error_report}
      else
        format.html { render :new }
        format.json { render json: @error_report.errors, status: :unprocessable_entity}
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_error_report
      @error_report = ErrorReport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def error_report_params
      params.require(:error_report).permit(:stacktrace, :error_msg, :error_passed, :changed_resources, :node_id)
    end
end
