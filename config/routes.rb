Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, -> (u) { u.has_role? :admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  scope module: :users do
    get 'user/color/:color', to: 'users#color'
  end
  scope ':locale' do
    get '/home/search', to: 'home#search'

    resources :songs do
      get :like, on: :member
      get :search, on: :collection
      get :not_active, on: :collection
      get :do_active, on: :member
    end

    scope module: :admin do
      resources :performers

      get 'users/all/', to: 'users#index'
      get 'user/:id/do_admin', to: 'users#do_admin'
      get 'user/:id/do_user', to: 'users#do_user'
    end
  end
end
