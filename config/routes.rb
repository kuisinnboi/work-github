Rails.application.routes.draw do

  get 'cart_items' => 'cart_items#index', as: 'cart_items_path'
  post 'cart_items' => 'cart_items#create'
  patch 'cart_items/:id' => 'cart_items#update', as: 'cart_item_path'
  delete 'cart_items/:id' => 'cart_items#destroy'
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'

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
 patch 'customers/withdraw' => 'customers#withdraw'


  # get 'customers/show'
  # get 'customers/edit'
  # get 'customers/update'
  # get 'customers/unsubscribe'


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

  get '/customers/my_page', to: 'customers#show', as: 'customers_show'
  get '/customers/infomation/edit', to: 'customers#edit', as: 'customers_edit'
  patch '/customers/infomation', to: 'customers#update', as: 'customers_update'
  get '/customers/unsbscribe', to: 'customers#unsubscribe', as: 'customers_unsubscribe'

  resources :items, only: [:show, :index]
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  # resources :customers, only: [:show, :edit, :update] do
  #   collection do
  #     get 'unsubscribe'

  #   end
  # end
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


end

