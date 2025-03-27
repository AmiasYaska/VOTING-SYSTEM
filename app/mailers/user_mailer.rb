class UserMailer < ApplicationMailer
    def welcome_email(user)
      @user = user
      # @login_url = new_user_session_url
      # mail(to: @user.email, subject: "Your Voting System Login Details")
    end
end