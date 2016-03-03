require 'rails_helper'

RSpec.feature "Creating a position" do
  
  let(:user) { create(:user_with_documents) }

  scenario "with valid inputs" do
    login_as(user)
    visit new_user_position_path(user_id: user.id)
    print page.html
    fill_in "Employer", with: "IBM"
    fill_in "position_open_date", with: "2016-03-02"
    fill_in "position_close_date", with: "2016-03-02"
    fill_in "position_applied_date", with: "2016-03-02"
    fill_in "position_interview_date", with: "2016-03-02"
    fill_in "position_notes", with: "I am applying to IBM"
    find('#document_id').find(:xpath, 'option[1]').click
    find('#document_id').find(:xpath, 'option[2]').click
    click_button "submit"

    expect(page).to have_content("A position has been created")
    expect(current_path).to eq(user_position_path(user, Position.last))
  end

  scenario "with invalid inputs" do
    login_as(user)
    visit new_user_position_path(user_id: user.id)
    print page.html
    fill_in "Employer", with: " "
    fill_in "position_open_date", with: "2016-03-02"
    fill_in "position_close_date", with: "2016-03-02"
    fill_in "position_applied_date", with: "2016-03-02"
    fill_in "position_interview_date", with: "2016-03-02"
    fill_in "position_notes", with: "I am applying to IBM"
    find('#document_id').find(:xpath, 'option[1]').click
    find('#document_id').find(:xpath, 'option[2]').click
    click_button "submit"

    expect(page).to have_content("A position has not been created")
    expect(page).to have_content("errors prohibited from being saved")
  end

end