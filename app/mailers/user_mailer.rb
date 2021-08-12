class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("user_mailer.account_activations.subject")
  end

  def password_reset user
    @user = user

    mail to: user.email, subject: t("user_mailer.account_activations.
      password.subject")
  end
end
