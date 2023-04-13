class UserMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def new_user
    @user = params[:user]
    mail(to: @user.email, subject: 'Seus dados de acesso ao sistema!')
  end
end
