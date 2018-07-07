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
end
