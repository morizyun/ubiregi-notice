UbiregiNotice::Application.routes.draw do
  get "welcome/index"

  get '/notices' => 'notices#index', :as => :notices
  get '/notices/open' => 'notices#index_open', :as => :open_notices
  get '/notices/:id' => 'notices#show', :as => :notice

  post '/notices' => 'notices#create'
  put '/notices/:id' => 'notices#update'
  post '/notices/:id/close' => 'notices#close'

  get '/' => 'welcome#index'
end
