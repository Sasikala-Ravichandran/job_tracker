require 'rails_helper'

RSpec.feature "Showing a position" do

  scenario do
    user = create(:user)
    position = create(:position, user_id: user.id)
    
    login_as(user)
    visit user_position_path(id: position.id, user_id: user.id)
    expect(page).to have_content(position.employer)
    expect(current_path).to eq(user_position_path(user, position))
  end
end
