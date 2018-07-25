class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    # 評論過的餐廳
    # .uniq 使得 @user.restaurants 資料不重覆
    @commented_restaurants = @user.restaurants.uniq

    # 收藏過的餐廳
    @favorited_restaurants = @user.favorited_restaurants.uniq  
    # 追縱的美食達人
    @followings = @user.followings
    # 當前使用者被哪些美食達人追縱
    @followers = @user.followers
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully updated"
      redirect_to user_path(@user)
    else
      flash[:alarm] = "Profile was failed to update"
      render :edit
    end
  end

  def friend_list
    @frineds = current_user.all_friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
  
end
