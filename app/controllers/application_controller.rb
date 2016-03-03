class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    session.delete(:return_to) || current_user
  end
  
  def validate_user_file
    unless current_user == @document.user
      flash[:error] = "You do not have access to that page"
      redirect_to current_user
    end
  end

  def validate_user_position
    unless current_user === @position.user
      flash[:error] = "You do not have access to that page"
      redirect_to current_user
    end
  end

  def user_authorize
    unless current_user.id == params[:user_id].to_i
      flash[:error] = "You do not have access to that page"
      redirect_to current_user
    end
  end
end
