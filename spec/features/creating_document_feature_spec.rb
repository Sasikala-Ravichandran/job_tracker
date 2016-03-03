require 'rails_helper'

RSpec.feature "Creating a document" do

  scenario do
    user = create(:user)
    
    login_as(user)

    visit new_user_document_path(user_id: user.id)
    fill_in "Name", with: "Sales force"
    attach_file "Resume","app/assets/images/job.jpg"

    click_button "submit"

    expect(page).to have_content("A Document has been created")
    expect(current_path).to eq(user_document_path(user, Document.last))
  end

end