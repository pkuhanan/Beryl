Rails.application.routes.draw do
  resources :data_entries
  resources :columns
  resources :entries
  resources :logbooks
  resources :users

  post   "/login"       => "sessions#create"
  delete "/logout"      => "sessions#destroy"
end
