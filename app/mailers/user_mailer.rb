
class UserMailer < ApplicationMailer
    def welcome_email(user)
      @user = user
      @url  = 'http://localhost:3000/login'
      mail(to: @user.email, subject: 'Welcome to library management') do |format|
        format.html
      end
    end
  end
  