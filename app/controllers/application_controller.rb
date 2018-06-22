class ApplicationController < ActionController::Base
  # application_controller.rb 是所有 controller 都可以取用的地方。即所有 controller 的 super class
  
  protect_from_forgery with: :exception

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
end
