require 'digest/sha1'

class NodesController < ApplicationController
          
  protect_from_forgery :except => [ :create ]

  MAX_NODES_IN_LIST = 25

  def home
    @nodes = Node.find( :all, :order => 'updated_at DESC', :limit => MAX_NODES_IN_LIST )
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
    node_params = params[ :node ].dup           
    key = Digest::SHA1.hexdigest( node_params[ :html ] ) 
    ( redirect_to node_path( @node ) and return ) if @node = Node.find_by_key( key ) 
    node_params.merge!( :key => key )
    @node = Node.new( node_params )
    if @node.save
      redirect_to node_path( @node )
    else           
      @nodes = []
      render :home 
    end
  end

end
