Rails.application.routes.draw do
  resources :books
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "books#index"
  get 'borrow/(:id)', to: 'books#borrow'
  get 'borrow/(:id)', to: 'books#checkedout'


end
