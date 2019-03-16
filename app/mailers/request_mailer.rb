class RequestMailer < ActionMailer::Base
  default from: "no-reply@frenchcoworkingspace.com"

  def registration_confirmation(request)
    @request = request
    mail(to: @request.email, subject: "French Coworking Space : Confirm your email")
  end

  def waiting_list_confirmation(request)
    @request = request
    if @request.state == 'confirmed'
      mail(to: @request.email, subject: "French Coworking Space : Confirm your interest and save your spot in the waiting list")
      ConfirmInterestJob.set(wait: 2.minute).perform_later(request.id)
    end
  end

    def request_accepted(request)
      @request = request
      mail(to: @request.email, subject: "French Coworking Space : Welcome among us!")
    end
end
