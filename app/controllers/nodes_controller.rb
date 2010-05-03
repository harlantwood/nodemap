class NodesController < ApplicationController

  MAX_NODES_IN_LIST = 25

  def home
    @nodes = Node.find( :all, :order => 'updated_at DESC', :limit => MAX_NODES_IN_LIST )
    @node = Node.new
  end

  def show
    key = params[ :key ].join( '/' )
    @node = Node.find_by_key( key )
    if @node
      render :layout => false
    else
      render :text => "Can't find the key: #{ key }", :status => '404 Not Found'
    end
  end

  def create
    @node = Node.new(params[:node])
    if @node.save
      redirect_to node_path( @node )
    else           
      @nodes = []
      render :action => "new" 
    end
  end

end
