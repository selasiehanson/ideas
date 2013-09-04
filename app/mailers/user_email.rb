class UserEmail < ActionMailer::Base
  default from: "info@mytots.com"

  def signup_notify(user)
  	@user = user
  	mail(:to => @user.email, :subject => "thanks!")
  end
end
