VirtualMails::Engine.routes.draw do
  resources :emails, :path => '/', :only => [:index, :show] do
    member do
      get 'raw'
    end
    collection do
      delete 'clear'
    end
  end
end
