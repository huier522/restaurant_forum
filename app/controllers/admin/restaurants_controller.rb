class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
      # 新增完成後，回後台首頁
    else
      flash.now[:alart] = "restaurant was failed to create"
      render :new
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully updated"
      redirect_to admin_restaurants_path(@restaurant)
      # 修改完成後，回到原展示頁
    else
      flash.now[:alart] = "restaurant was failed to update"
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    flash[:notice] = "restaurant was successfully deleted"
    redirect_to admin_restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :opening_hours, :description, :image, :category_id)
    # 使用 params 取出從 Client 端送進的 request 裡 controller 所需參數，要求(require) restaurant 
    # 拿出的表單資料必須使用 permit 允許指定的屬性資料傳進 Model
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
