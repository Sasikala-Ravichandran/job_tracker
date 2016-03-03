require 'rails_helper'

RSpec.feature "Editing a document" do

  scenario do
    user = create(:user)
    document = create(:document, user_id: user.id)
    
    login_as(user)

    visit edit_user_document_path(id: document.id, user_id: user.id)
    fill_in "Name", with: "Edited document name"
    attach_file "Resume","app/assets/images/job.jpg"

    click_button "submit"

    expect(page).to have_content("A Document has been updated")
    expect(page).to have_content("Edited document name")
    expect(current_path).to eq(user_document_path(user, document))
  end

end