# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview
  def registration_confirmation
    request = Request.first
    RequestMailer.registration_confirmation(request)
  end

  def waiting_list_confirmation
    request = Request.first
    RequestMailer.waiting_list_confirmation(request)
  end

  def request_accepted
    request = Request.first
    RequestMailer.request_accepted(request)
  end
end
