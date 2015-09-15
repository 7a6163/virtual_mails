Rails.application.routes.draw do
  mount VirtualMails::Engine => "/virtual_mails"

  resources :emails, :path => '/', :only => [:index, :new, :create]
end
