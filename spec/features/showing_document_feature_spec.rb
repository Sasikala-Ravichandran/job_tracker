require 'rails_helper'

RSpec.feature "Showing a document" do

  scenario do
    user = create(:user)
    document = create(:document, user_id: user.id)
    
    login_as(user)
    visit user_document_path(id: document.id, user_id: user.id)
    expect(page).to have_content(document.name)
    expect(current_path).to eq(user_document_path(user, document))
  end
end
