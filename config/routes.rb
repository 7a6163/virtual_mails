# frozen_string_literal: true

VirtualMails::Engine.routes.draw do
  resources :emails, path: '/', only: %i[index show] do
    member do
      get 'raw'
    end
    collection do
      delete 'clear'
    end
  end
end
