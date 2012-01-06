Nodemap::Application.routes.draw do
  get  '/' => 'nodes#home'
  post '/' => 'nodes#create'
  get  ':key' => 'nodes#show', :as => 'node', :constraints => { :key => SHA512_PATTERN }
end
