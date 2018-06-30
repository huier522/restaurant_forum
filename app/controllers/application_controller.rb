class ApplicationController < ActionController::Base
  # application_controller.rb 是所有 controller 都可以取用的地方。即所有 controller 的 super class
  
  protect_from_forgery with: :exception

  before_action :authenticate_user!

end
