class RemainderMailer < ApplicationMailer

  def remainder(position)
    @position = position
    @user = @position.user
    mail to: @user.email, subject: 'Remainder - A Job position closes in less than 3 days'
  end

end
