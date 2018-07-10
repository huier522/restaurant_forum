Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    # 利用 nested resources 的方式宣告特定餐廳下的評論，讓使用者可以 create，管理者可以 destroy
  end
  # except 語意與 only 相反
  # root "restaurants#index", except: [:new, :create, :edit, :update, 
  # :destroy]

  resources :users, only: [:show, :edit, :update]

  resources :categories, only: :show
  
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

end
