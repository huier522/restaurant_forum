class FollowshipsController < ApplicationController

  def create
    # 產生一個新的 Followship 物件，並設定兩個外鍵 user_id 和 following_id
    @followship = current_user.followships.build(following_id: params[:following_id])

    # 將攜帶資料的 Followship 物件存入資料庫
    if @followship.save
      # 如果通過 Model 驗證，成功儲存到資料庫裡，則導回同一頁，並顯示成功訊息
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      # 如果驗證失敗，也導回同一頁，並將錯誤訊息顯示給使用者
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    # 查詢追蹤記錄時，使用 current_user.followships 來確保找出來的紀錄，一定是屬於當前登入的使用者
    # 使用 where 方法，傳入 following_id 的值，找出符合的紀錄
    # 在這裡，無法使用 find 方法，因為 find 方法只能用主鍵 id 查詢，而 following_id 不是主鍵
    # 當使用 where 方法時，無論資料有幾筆，他都會回傳一組物件集合（也就是陣列），所以需要再串接 first，將特定物件從陣列取出。
    @followship = current_user.followships.where(following_id: params[:id]).first
    # 若不串接 first，就要使用 destroy_all
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
