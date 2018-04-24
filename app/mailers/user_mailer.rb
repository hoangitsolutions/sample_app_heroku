class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t "static_pages.acctivation"
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t "static_pages.resetpassword"
  end
end
