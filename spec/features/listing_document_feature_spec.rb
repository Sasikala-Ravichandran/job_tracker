require 'rails_helper'

RSpec.feature "Listing the documents" do

  scenario "non logged in user" do
    user = create(:user)
    visit user_documents_path(user)
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "logged in user" do
    user = create(:user)
    document1 = create(:document, user_id: user.id)
    document2 = create(:document, user_id: user.id)

    login_as(user)
    visit user_documents_path(user)
    expect(page).to have_content("All Documents")
    expect(page).to have_content("Name of Document")
    expect(page).to have_content(document1.name)
    expect(page).to have_content(document2.name)
    expect(current_path).to eq(user_documents_path(user))
  end
end