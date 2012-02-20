class NodesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create

  MAX_NODES_IN_LIST = 333

  def home
    #@nodes = Node.recent( MAX_NODES_IN_LIST )

    @node = Node.new
  end

  def show
    key = params[ :key ]
    @content = Node.find_by_key( key )
    if @content
      render :layout => false
    else
      render :text => "Can't find the key: #{ key }", :status => '404 Not Found'
    end
  end

  def create         
    @content_id = Node.custom_find_or_create( params[ :node ][ :content ] )
    redirect_to "/#{@content_id.toString(16)}"
  end

end
