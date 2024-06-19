Rails.application.routes.draw do
  resources :users, only: %i[index edit update]

  root 'users#index'
end
