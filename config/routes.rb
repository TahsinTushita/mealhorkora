Rails.application.routes.draw do
  get '/revenues',                  to: "revenues#new"
  root 'static_pages#home'
  get '/status',                    to:"static_pages#status"
  post '/status',                   to:"status#update"
  get '/preference',                to: "static_pages#preference"
  get '/signup',                    to: "users#new"
  post '/signup',                   to: "users#create"
  get '/signin',                    to: "sessions#new"
  post 'signin',                    to: "sessions#create"
  delete '/signout',                to: "sessions#destroy"
  get '/dashboard',                 to: "static_pages#dashboard"
  get '/lunch_manager',             to: "lunch_managers#new"
  post '/lunch_manager',            to: "lunch_managers#create"
  get '/dinner_manager',            to: "dinner_managers#new"
  post '/dinner_manager',           to: "dinner_managers#create"
  get '/manager_panel',             to: "managers#new"
  get '/reports',                   to: "meal_account_factory#new"
  post '/reports',                  to: "meal_account_factory#create"
  get '/about',                     to: 'static_pages#about'
  get '/contact',                   to: 'static_pages#contact'
  get '/preference',                to: 'static_pages#preference'
  post '/newadmin',                 to: 'managers#create_admin'
  post '/manager_panel',            to: 'managers#remove_admin'
  get  '/add_expense',              to: 'expenses#new'
  post '/add_expense',              to: 'expenses#create'
  get '/show_expense',              to: 'expenses#show_blank'
  post '/show_expense',             to: 'expenses#show'
  get '/update_balance',            to: 'managers#update_balance'
  post '/update_balance',           to: 'managers#setbalance'

  get  '/create_new_lunch_menu',    to: 'lunch_managers#new_meal'
  post '/create_new_lunch_menu' ,   to: 'lunch_managers#create_meal'
  get '/edit_lunch_menu',           to: 'lunch_managers#edit'
  # patch '/edit_lunch_menu',         to: 'lunch_managers#update'
  # delete '/delete_lunch_menu',      to: 'lunch_managers#destroy'
  get  '/create_new_dinner_menu',   to: 'dinner_managers#new_meal'
  post '/create_new_dinner_menu',   to: 'dinner_managers#create_meal'
  get '/edit_dinner_menu',          to: 'dinner_managers#edit'
  resources :users
  resources :preferrences, only: [:create, :destroy]
  resources :expenses
end
