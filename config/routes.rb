ActionController::Routing::Routes.draw do |map|
  map.connect '',                    :controller => 'nodes', :action => 'home',   :conditions => { :method => :get  }
  map.connect '',                    :controller => 'nodes', :action => 'create', :conditions => { :method => :post }
  map.node    ':key/*friendly_text', :controller => 'nodes', :action => 'show', :key => /[0-9a-f]{40}/
end
