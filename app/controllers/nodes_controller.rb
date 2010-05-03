class NodesController < ApplicationController
  def show
    @node = Node.find_by_key( params[ :key ] )
    if @node
      render :layout => false
    else
      flash.now[ :error ] = "Can't find the key: #{ params[ :key ] }"
    end
  end

  def new
    @nodes = Node.all.reverse
    @node = Node.new
  end

  def create
    @node = Node.new(params[:node])
    if @node.save
      redirect_to( "/#{@node.key}" ) 
    else
      render :action => "new" 
    end
  end

end
