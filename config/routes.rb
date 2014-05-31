UbiregiNotice::Application.routes.draw do
  namespace :admin do
    get '/' => 'notices#index'

    resources :notices do
      resources :messages, shallow: true
    end
  end

  get '/notices'      => 'notices#index', :as => :notices

  get '/' => 'welcome#index'
end
