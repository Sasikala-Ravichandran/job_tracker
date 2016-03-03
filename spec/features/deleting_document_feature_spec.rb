require 'rails_helper'

RSpec.feature "Deleting a document" do

  scenario do
    user = create(:user)
    document = create(:document, user_id: user.id)
    
    login_as(user)
    visit user_document_path(id: document.id, user_id: user.id)
    click_link "Delete"
    expect(page).to have_content("A Document has been deleted")
    expect(current_path).to eq(user_documents_path(user))
  end
end