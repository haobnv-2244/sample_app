class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("email.subject")
  end

  def password_reset
    @greeting = t "email.hi"
    mail to: "to@example.org"
  end
end
