Rails.application.routes.draw do

  get 'cart_items/index'
  get 'cart_items/update'
  get 'cart_items/destroy'
  get 'cart_items/destroy_all'
  get 'cart_items/create'
  get 'addresses/edit'
  get 'addresses/index'
  patch 'addresses/:id' => 'addresses#update', as: 'update_addresses'
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



  get 'customers/show'
  get 'customers/edit'
  get 'customers/update'
  get 'customers/unsubscribe'
  get 'customers/withdraw'
  get 'orders/new'
  get 'orders/show'
  get 'orders/index'
  get '/orders/complete'
   post '/orders/confirm', to: 'orders#confirm', as: 'orders_confirm'
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'homes/top'
  end

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
      root to: 'homes#top'
      resources :sessions, only: [:new, :create, :destroy]
      resources :homes, only: [:top,:show]
      resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]
      resources :genres, only: [:edit, :create,:index, :update,:new]


      resources :customers, only: [:show, :edit, :update, :index]
      resources :orders, only: [:show, :update] do
        member do
          resources :order_details, only: [:update]
        end

      end
    end
    # ジャンル検索
  get '/genre/search' => 'genre_searches#genre_search'

end

