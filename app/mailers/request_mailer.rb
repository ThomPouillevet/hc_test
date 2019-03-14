class RequestMailer < ActionMailer::Base
  default from: "frenchcoworkingspace@gmail.com"

  def registration_confirmation(request)
    @request = request
    mail(to: @request.email, subject: "French Coworking Space : Confirm your email")
  end
end
