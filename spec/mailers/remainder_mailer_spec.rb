require "rails_helper"

RSpec.describe RemainderMailer, type: :mailer do

  describe 'remainder' do
    let(:user) { create(:user, first_name: 'Lucas', email: 'lucas@example.com') }
    let(:position) { create(:position, user_id: user.id) }
    let(:mail) { RemainderMailer.remainder(position) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Remainder - A Job position closes in less than 3 days')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['from@example.com'])
    end

    it 'assigns first_name' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it 'assigns employer' do
      expect(mail.body.encoded).to match(position.employer)
    end

    it 'assigns show template of the position' do
      expect(mail.body.encoded)
        .to match(user_position_path(position, user))
    end
  end
end
