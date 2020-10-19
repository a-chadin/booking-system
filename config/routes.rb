Rails.application.routes.draw do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :venues, only: [:index, :show] do
    resources :bookings, only: [:new, :create, :update, :edit, :destroy]
  end
end
