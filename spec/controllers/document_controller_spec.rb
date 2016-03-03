require 'rails_helper'

RSpec.describe DocumentsController, :type => :controller do

  let(:user) { create(:user) }
  let(:document) { create(:document) }

  before :each do
    login_with(user)
  end

  describe "GET #index" do
    it "responses with index template" do
      get :index, user_id: user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "responses with new template" do
      get :new, user_id: user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do

    context "a successful create" do

      before do
        post :create, document: FactoryGirl.attributes_for(:document), user_id: user.id 
      end
      
      it "saves document object in the database" do
        expect(Document.count).to eq(1)
      end

      it "displays the flash message" do
        expect(flash[:success]).to eq("A Document has been created")
      end

      it "redirects_to show template" do
        expect(response).to redirect_to user_document_path(user, Document.last)
      end
    end

    context "an unsuccessful create" do

      before do
        post :create, document: FactoryGirl.attributes_for(:document, name: " "), user_id: user.id 
      end

      it "does not save document object in the database" do
        expect(Document.count).to eq(0)
      end

      it "redirects_to show template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do

    it "responses with edit template" do
      allow_any_instance_of(DocumentsController).to receive(:validate_user_file)
      get :edit, id: document, user_id: user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do

    context "a successful update" do

      before do
        allow_any_instance_of(DocumentsController).to receive(:validate_user_file)
        put :update, document: FactoryGirl.attributes_for(:document, name: "resume"),
                      id: document.id, user_id: user.id 
      end
      
      it "updates document object in the database" do
        expect(document.reload.name).to eq("resume")
      end

      it "displays the flash message" do
        expect(flash[:success]).to eq("A Document has been updated")
      end

      it "redirects_to show template" do
        expect(response).to redirect_to user_document_path(user, Document.last)
      end
    end

    context "an unsuccessful update" do

      before do
        allow_any_instance_of(DocumentsController).to receive(:validate_user_file)
        put :update, document: FactoryGirl.attributes_for(:document, name: " "),
                        id: document.id, user_id: user.id 
      end

      it "does not save document object in the database" do
        expect(document.reload.name).to eq(document.name)
      end

      it "redirects_to show template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do

    before do
      allow_any_instance_of(DocumentsController).to receive(:validate_user_file)
      delete :destroy, id: document.id, user_id: user.id
    end
    
    it "deletes an event object in the database" do
      expect(Document.count).to eq(0)
    end

    it "displays flash message" do
      expect(flash[:success]).to eq("A Document has been deleted")
    end

    it "redirects to event show page" do
      expect(response).to redirect_to user_documents_path
    end
  end
end