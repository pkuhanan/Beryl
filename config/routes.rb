Rails.application.routes.draw do
  resources :data_entries
  resources :entries
  resources :logbooks
  resources :users
  resources :columns, only: [:index, :show, :create]

  post   "/login"       => "sessions#create"
  delete "/logout"      => "sessions#destroy"
end
