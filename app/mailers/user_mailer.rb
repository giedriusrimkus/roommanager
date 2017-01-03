class UserMailer < ApplicationMailer

  # Subject can be set in I18n file at config/locales/en.yml
  # with the lookup --> en.user_mailer.account_activation.subject
  
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "RoomManager - Account activation"
  end


  # Subject can be set in I18n file at config/locales/en.yml
  # with lookup --> en.user_mailer.password_reset.subject

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
