class NodesController < ApplicationController
  def show
    key = params[ :key ].join( '/' )
    @node = Node.find_by_key( key )
    if @node
      render :layout => false
    else
      render :text => "Can't find the key: #{ key }", :status => '404 Not Found'
    end
  end

  def new
    @nodes = Node.all.reverse
    @node = Node.new
  end

  def create
    @node = Node.new(params[:node])
    if @node.save
      redirect_to node_path( @node )
    else
      render :action => "new" 
    end
  end

end
