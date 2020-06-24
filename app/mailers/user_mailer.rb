class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("email.subject")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("reset_password.password_reset")
  end
end
