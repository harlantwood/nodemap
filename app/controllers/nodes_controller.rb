class NodesController < ApplicationController
          
  protect_from_forgery :except => [ :create ]

  MAX_NODES_IN_LIST = 999

  def home
    @nodes = Node.recent_with_title( MAX_NODES_IN_LIST )
    @node = Node.new
  end

  def show
    key = params[ :key ]
    @node = Node.find_by_key( key )
    if @node
      render :layout => false
    else
      render :text => "Can't find the key: #{ key }", :status => '404 Not Found'
    end
  end

  def create         
    @node = Node.custom_find_or_create( params[ :node ][ :html ] )
    if @node.save
      redirect_to node_path( @node )
    else           
      @nodes = []
      render :home 
    end
  end

end
