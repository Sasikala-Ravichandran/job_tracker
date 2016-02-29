require 'rails_helper';

describe 'User registration' do
  let(:user_email) { 'registration_test_user@example.org' }
  let(:user_password) { 'registration_test_password' }

  before :each do
    visit new_user_registration_path

    fill_in 'user_email', with: user_email
    fill_in 'user_password', with: user_password
    fill_in 'user_password_confirmation', with: user_password

    click_button 'Sign up'
  end

  it "shows message about confirmation email" do
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
  end

  describe "confirmation email" do
    include EmailSpec::Helpers
    include EmailSpec::Matchers

    
    subject { open_email(user_email) }

    it { is_expected.to deliver_to(user_email) }
    it { is_expected.to have_body_text(/You can confirm your account email through the link below/) }
    it { is_expected.to have_subject(/Confirmation instructions/) }
  end

  context "when clicking confirmation link in email" do
    before :each do
      open_email(user_email)
      current_email.click_link 'Confirm my account'
    end

    it "shows confirmation message" do
      expect(page).to have_content('Your email address has been successfully confirmed.')
    end

    it "confirms user" do
      user = User.find_for_authentication(email: user_email)
      expect(user).to be_confirmed
    end
  end
end