class ErrorReportsController < Admin::ApplicationController
  before_action :set_error_report, only: [:show, :edit, :update, :destroy]
  layout 'admin/layouts/admin'

  # GET /error_reports
  def index
    @error_reports = ErrorReport.all
  end

  # GET /error_reports/1
  def show
  end

  # GET /error_reports/new
  def new
    @error_report = ErrorReport.new
  end

  # GET /error_reports/1/edit
  def edit
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

  # PATCH/PUT /error_reports/1
  def update
    respond_to do |format|
      if @error_report.update(error_report_params)
        format.html { redirect_to @error_report, notice: 'Error report was successfully update.' }
        format.json { render :show, status: :created, location: @error_report}
      else
        format.html { render :edit }
        format.json { render json: @error_report.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /error_reports/1
  def destroy
    @error_report.destroy
    respond_to do |format|
      format.html { redirect_to error_report_url, notice: 'Error report was successfully destroyed.' }
      format.json { head :no_content }
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
