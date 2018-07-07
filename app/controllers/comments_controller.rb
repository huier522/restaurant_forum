class CommentsController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    # 因為是用 nested resources 所以是用 ：:restaurant_id 而不是 :id
    @comment = @restaurant.comments.build(comment_params)
    # 由於「一家餐廳有很多評論」，因此，我們可以透過關聯方法 @restaurant.comments.build 
    # 來建立一筆新的 Comment 物件，建立的新物件會自動帶入外鍵 restaurant_id。
    @comment.user = current_user
    @comment.save!
    # save！ 儲存失敗會跳出錯誤訊息
    redirect_to restaurant_path(@restaurant)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
