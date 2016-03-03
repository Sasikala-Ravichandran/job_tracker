require 'rails_helper'

RSpec.feature "Listing the positions" do

  let(:user) { create(:user_with_positions) }

  scenario "non logged in user" do
    visit user_positions_path(user)
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "logged in user" do
    login_as(user)
    visit user_positions_path(user)
    expect(page).to have_content("All APPLIED JOBS")
    expect(page).to have_link(user.positions.first.employer)
    expect(page).to have_link(user.positions.second.employer)
    expect(current_path).to eq(user_positions_path(user))
  end
end