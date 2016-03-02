require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  let(:user) { create(:user) }

  before :each do
    login_with(user)
  end

  describe "GET #show" do
    
    it "responses with show template" do
      get :show, id: user.id
      #require 'pry';binding.pry
      expect(response).to have_http_status(:success)
    end
  end
end