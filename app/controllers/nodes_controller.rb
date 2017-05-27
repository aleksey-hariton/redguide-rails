class NodesController < Admin::ApplicationController
  before_action :set_node, only: [:show]
  layout 'admin/layouts/admin'

  # GET /nodes
  def index
    @organization = Organization.find(params[:organization_id])
    @environment = Environment.find(params[:environment_id])
    @nodes = []
    @nodes << Node.find_by(environment: @environment)
  end

  # GET /nodes/1
  def show
    @organization = Organization.find(params[:organization_id])
    @environment = Environment.find(params[:environment_id])
  end

  # GET /nodes/new
  def new
    @organization = Organization.find(params[:organization_id])
    @environment = Environment.find(params[:environment_id])
    @node = Node.new
    @node.environment @environment
  end

  # POST /nodes
  def create
    @node = Node.new(node_params)

    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: @node}
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity}
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def node_params
      params.require(:node).permit(:name, :environment_id, :status)
    end
end
