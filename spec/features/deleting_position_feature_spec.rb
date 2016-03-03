require 'rails_helper'

RSpec.feature "Deleting a position" do

  scenario do
    user = create(:user)
    position = create(:position, user_id: user.id)
    
    login_as(user)
    visit user_position_path(id: position.id, user_id: user.id)
    print page.html
    click_link "Delete"
    expect(page).to have_content("Position has been deleted")
    expect(current_path).to eq(user_positions_path(user))
  end
end