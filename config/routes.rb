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

      # 收藏與不收藏並不需要請求樣板所以習慣使用 post
      post :favorite
      post :unfavorite

      # 喜歡與不喜歡並不需要請求樣板所以習慣使用 post
      post :like
      post :unlike
    end
  end
  # except 語意與 only 相反
  # root "restaurants#index", except: [:new, :create, :edit, :update, 
  # :destroy]

  # index page route for follow/unfollow 
  resources :users, only: [:index, :show, :edit, :update]
  # follow/unfollow 除了自訂路由，也可以使用符合 CRUD 慣例的設定方式
  resources :followships, only: [:create, :destroy]

  resources :categories, only: :show

  resources :friendships, only: [:create, :destroy]
  
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

end
