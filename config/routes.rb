Rails.application.routes.draw do

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get '/homes/about', to:  'homes#about', as: 'about'

  resources :items, only: [:show, :index]
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :customers, only: [:show, :edit, :update] do
    collection do
      get 'unsubscribe'
      get 'withdraw'
    end
  end
  resources :cart_items, only: [:index, :update] do
    collection do
      get 'destroy'
      get 'deatroy_all'
    end
  end
  resources :orders, only: [:new, :create, :index, :show] do
    collection do
      get 'confirm'
      get 'thanks'
    end
  end
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  namespace :admin do
      resources :sessions, only: [:new, :create, :destroy]
      resources :homes, only: [:top]
      resources :items, only: [:show, :index, :new, :create, :edit, :update]
      resources :genres, only: [:edit, :create,:index, :update]


      resources :customers, only: [:show, :edit, :update, :index]
      resources :orders, only: [:show, :update]
      resources :order_details, only: [:update]

      end


end

      resources :customers, only: [:show, :edit, :update, :index]
      resources :orders, only: [:show, :update]
      resources :order_details, only: [:update]
  end
end

