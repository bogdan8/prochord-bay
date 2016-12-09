Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

  get 'home/search', to: 'home#search'

  resources :songs do
    get :like, on: :member
    get :search, on: :collection
    get :not_active, on: :collection
    get :do_active, on: :member
  end
end
