class RestaurantsController < ApplicationController
  before_action :authenticate_user!
		# 想要修改或美化，可以至 app/views/devise/sessions/new.html.erb 進行編輯
	before_action :set_restaurant, only: [:show, :dashboard, 
		:favorite, :unfavorite, :like, :unlike]
    
	def index
		@restaurants = Restaurant.page(params[:page]).per(9)
		@categories = Category.all
	end
	
	def show
		# @restaurant = Restaurant.find(params[:id])
		@comment = Comment.new
		# 將 show page 的最近留言保持在最上方
		@comments = @restaurant.comments.order('created_at desc')
	end

	# GET restaurants/feeds
	# 會去 render app/views/restuarants/feeds.html.erb
	def feeds
		# 最近建立的10筆餐廳
		@recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
		# 最近建立的10筆評論
		@recent_comments = Comment.order(created_at: :desc).limit(10)
	end

	# GET /restaurants/:id/dashboard(.:format)
	# 會去 render app/views/restuarants/dashboard.html.erb
	def dashboard
		# @restaurant = Restaurant.find(params[:id])
	end

	def favorite
		# 依 params[:id] 確認餐廳物件
		# @restaurant = Restaurant.find(params[:id])
		# 在 favorites 資料表上建立一筆新紀錄，並寫入 restaurant_id 和 user_id
		Favorite.create(restaurant: @restaurant, user: current_user)
		# 新增計算餐廳收藏數的方法
		@restaurant.ranking_favorites
		# 導回上一頁
		redirect_back(fallback_location: root_path)
	end

	def unfavorite
		# 要利用 @restaurant 和 current_user 兩個線索，在 favorites table 上找到對應的 Favorite 紀錄
		favorites = Favorite.where(restaurant: @restaurant, user: current_user)
		# 由於有多個條件，所以我們會使用 where 方法來操作。
		# 然而，因為 where 會回傳一個「物件集合」，不一定只有一筆資料，所以在這裡搭配刪除集合的 destroy_all 方法。
		favorites.destroy_all
		# 新增計算餐廳收藏數的方法
		@restaurant.ranking_favorites
		redirect_back(fallback_location: root_path)
	end

	def ranking
		# 以餐廳的favorites_count欄位值排出前10大
		@ranking_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
	end

	def like
		# 在 likes 資料表上建立一筆新紀錄，並寫入 restaurant_id 和 user_id
		Like.create(restaurant: @restaurant, user: current_user)
		redirect_back(fallback_location: root_path)
	end

	def unlike
		likes = Like.where(restaurant: @restaurant, user: current_user)
		likes.destroy_all
		redirect_back(fallback_location: root_path)
	end

	private

	def set_restaurant
		@restaurant = Restaurant.find(params[:id])
	end
end
