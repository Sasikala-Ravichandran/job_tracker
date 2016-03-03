require 'rails_helper'

RSpec.describe PositionsController, type: :controller do
  
  let(:user) { create(:user) }
  let(:position) { create(:position) }
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
        post :create, position: FactoryGirl.attributes_for(:position), user_id: user.id,
                      document: { id: [1,2,3] }
      end
      
      it "saves a position object in the database" do
        expect(Position.count).to eq(1)
      end

      it "displays the flash message" do
        expect(flash[:success]).to eq("A position has been created")
      end

      it "redirects_to show template" do
        expect(response).to redirect_to user_position_path(user, Position.last)
      end
    end

    context "an unsuccessful create" do

      before do
        post :create, position: FactoryGirl.attributes_for(:position, employer: " "), user_id: user.id,
                      document: { id: [1,2,3] } 
      end

      it "does not save position object in the database" do
        expect(Position.count).to eq(0)
      end

      it "redirects_to show template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do

    it "responses with edit template" do
      allow_any_instance_of(PositionsController).to receive(:validate_user_position)
      get :edit, id: position, user_id: user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do

    context "a successful update" do

      before do
        allow_any_instance_of(PositionsController).to receive(:validate_user_position)
        put :update, position: FactoryGirl.attributes_for(:position, employer: "IBM"),
                      id: position.id, user_id: user.id, document: { id: [1,2,3] }
      end
      
      it "updates position object in the database" do
        expect(position.reload.employer).to eq("IBM")
      end

      it "displays the flash message" do
        expect(flash[:success]).to eq("Position has been updated")
      end

      it "redirects_to show template" do
        expect(response).to redirect_to user_position_path(user, Position.last)
      end
    end

    context "an unsuccessful update" do

      before do
        allow_any_instance_of(PositionsController).to receive(:validate_user_position)
        put :update, position: FactoryGirl.attributes_for(:position, employer: " "),
                        id: position.id, user_id: user.id, document: { id: [1,2,3] }
      end

      it "does not save position object in the database" do
        expect(position.reload.employer).to eq(position.employer)
      end

      it "redirects_to show template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do

    before do
      allow_any_instance_of(PositionsController).to receive(:validate_user_position)
      delete :destroy, id: position.id, user_id: user.id
    end
    
    it "deletes an event object in the database" do
      expect(Position.count).to eq(0)
    end

    it "displays flash message" do
      expect(flash[:success]).to eq("Position has been deleted")
    end

    it "redirects to event show page" do
      expect(response).to redirect_to user_positions_path
    end
  end
end