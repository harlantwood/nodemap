Nodemap::Application.routes.draw do
  get  '/' => 'nodes#home'
  post '/' => 'nodes#create'
  get  '/:key' => 'nodes#show', :as => 'node', :constraints => { :key => /[0-9a-f]{40}/ }
end
