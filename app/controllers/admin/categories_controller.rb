class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    # 傳入表單資料強制使用 strong parameter
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      # 儲存失敗時，由於要重新 render index 樣板，需要再額外傳入 index 需要的 @categories 實例變數
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
