require 'rails_helper'

RSpec.feature "Editing a position" do

  scenario do
    user = create(:user)
    position = create(:position, user_id: user.id)
    
    login_as(user)

    visit edit_user_position_path(id: position.id, user_id: user.id)
    print page.html
    fill_in "Employer", with: "Edited employer name"

    click_button "submit"

    expect(page).to have_content("Position has been updated")
    expect(page).to have_content("Edited employer name")
    expect(current_path).to eq(user_position_path(user, position))
  end

end