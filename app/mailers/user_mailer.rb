class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("mailer.mail_activate.subject")
  end

  def password_reset user
    @user = user

    mail to: user.email, subject: t("mailer.mail_reset.subject")
  end
end
