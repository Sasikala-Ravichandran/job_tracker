require 'rails_helper'

RSpec.feature "Sign Out" do
    
  let(:user) { create(:user) }
  
  scenario do
    login_as(user)
    visit user_path(user)
    click_link "Logout"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed out successfully.")
  end
end