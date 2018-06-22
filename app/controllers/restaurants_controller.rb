class RestaurantsController < ApplicationController
    before_action :authenticate_user!
    # 想要修改或美化，可以至 app/views/devise/sessions/new.html.erb 進行編輯
    def index
    end
end
