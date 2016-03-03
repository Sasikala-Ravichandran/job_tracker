class UsersController < ApplicationController

  def show
    @positions = current_user.positions.all.paginate(page: params[:page], per_page: 10) 
    @page = (params[:page] || 1).to_i
  end
  
end