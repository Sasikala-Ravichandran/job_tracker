class PositionsController < ApplicationController

  before_action :set_position, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_position, only: [:show, :edit, :update, :destroy]
  before_action :user_authorize, only: [:index, :new, :create]

  def index
    @positions = current_user.positions.paginate(page: params[:page], per_page: 10) 
    @page = (params[:page] || 1).to_i
  end

  def show
  end

  def new
    @position = current_user.positions.build
    @documents = current_user.documents
    @applieds = @position.applieds.build
  end

  def create
    @position = current_user.positions.build(position_params)
    if params.has_key? "document"
      params[:document][:id].each do |document|
        unless document.empty?
          @applieds = @position.applieds.build(:document_id => document)
        end
      end
    end
    if @position.save
      flash[:success] = "A position has been created"
      redirect_to [current_user, @position]
    else 
      flash[:error] = "A position has not been created"
      render 'new'
    end
  end

  def edit
    @documents = current_user.documents
    @applieds = @position.applieds.build
  end

  def update
    params[:document][:id].each do |document|
      unless document.empty?
        unless @position.applieds.count == 0 
          @position.applieds.each do |applied|
            applied.destroy
          end
        end
        @applieds = @position.applieds.build(:document_id => document)
      end
    end
    if @position.update(position_params)
      flash[:success] = "Position has been updated"
      redirect_to [current_user, @position]
    else
      flash[:error] = "Position has not been updated"
      render 'edit'
    end
  end

  def destroy
    @position.destroy
    flash[:success] = "Position has been deleted"
    redirect_to user_positions_path(current_user)
  end
  
  private

  def position_params
    params.require(:position).permit(:employer, :reg_id, :open_date, :close_date,
        :applied_date, :interview_date, :notes)
  end

  def set_position
    @position = Position.find(params[:id])
  end
end
