class DocumentsController < ApplicationController

  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_file, only: [:show, :edit, :update, :destroy]
  before_action :user_authorize, only: [:index, :new, :create]
  
  def index
    @documents = current_user.documents.all.paginate(page: params[:page], per_page: 10) 
    @page = (params[:page] || 1).to_i
  end

  def show
  end

  def new
    @document = current_user.documents.build
  end

  def create
    @document = current_user.documents.build(document_params)
    if @document.save
      flash[:success] = "A Document has been created"
      redirect_to [current_user, @document]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      flash[:success] = "A Document has been updated"
      redirect_to [current_user, @document]
    else
      render :edit
    end
  end

  def destroy
    @document.destroy
    flash[:success] = "A Document has been deleted"
    redirect_to user_documents_path
  end

  private

  def document_params
    params.require(:document).permit(:name, :resume)
  end

  def set_document
    @document = Document.find(params[:id])
  end
end