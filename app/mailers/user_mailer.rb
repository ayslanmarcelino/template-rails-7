class UserMailer < ApplicationMailer
  default from: 'ayslamarcelino@gmail.com'

  def new_user
    @user = params[:user]
    mail(to: @user.email, subject: 'Seus dados de acesso ao sistema!')
  end
end
