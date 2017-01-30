class NodesController < Admin::ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]
  layout 'admin/layouts/admin'

  # GET /nodes
  def index
    @nodes = Node.all
  end

  # GET /nodes/1
  def show
  end

  # GET /nodes/new
  def new
    @node = Node.new
  end

  # GET /nodes/1/edit
  def edit
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

  # PATCH/PUT /nodes/1
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { render :show, status: :created, location: @node}
      else
        format.html { render :edit }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  def destroy
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
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
