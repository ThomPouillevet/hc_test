class ConfirmInterestJob < ApplicationJob
  queue_as :default

  def perform(request_id)
    request = Request.find(request_id)
    date = request.date_of_interest_confirmation
    if request.in_waiting_list? && (date == nil || date < 3.month.ago)
      request.refused!
    elsif request.in_waiting_list?
      RequestMailer.waiting_list_confirmation(request).deliver_later(wait: 3.month)
    end
  end

end
