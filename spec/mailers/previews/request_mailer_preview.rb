# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview
  def registration_confirmation
    request = Request.first
    RequestMailer.registration_confirmation(request)
  end
end
