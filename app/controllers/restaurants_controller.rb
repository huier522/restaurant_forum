class RestaurantsController < ApplicationController
  before_action :authenticate_user!
    # 想要修改或美化，可以至 app/views/devise/sessions/new.html.erb 進行編輯
    
	def index
		@restaurants = Restaurant.page(params[:page]).per(9)
		@categories = Category.all
	end
	
	def show
		@restaurant = Restaurant.find(params[:id])
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
		@restaurant = Restaurant.find(params[:id])
	end
end
