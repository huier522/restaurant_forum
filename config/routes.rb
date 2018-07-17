Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    # 利用 nested resources 的方式宣告特定餐廳下的評論，讓使用者可以 create，管理者可以 destroy
    resources :comments, only: [:create, :destroy]

    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
    end

    # 自訂路由
    member do
      # 瀏覽個別餐廳的 dashboard
      get :dashboard

      # 收藏與不收藏不需要請求樣板所以習慣使用 post
      post :favorite
      post :unfavorite
    end
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
