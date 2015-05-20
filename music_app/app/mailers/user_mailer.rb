class UserMailer < ApplicationMailer
  default from: 'activation@musicapp.com'

  def activation_email(user)
    @user = user
    mail(to: user.email,
         subject: "Please activate your Music App Account")
  end
end
