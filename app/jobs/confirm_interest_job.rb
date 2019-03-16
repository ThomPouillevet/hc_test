class ConfirmInterestJob < ApplicationJob
  queue_as :default

  def perform(request_id)
    request = Request.find(request_id)
    date = request.date_of_interest_confirmation
    if date == nil || date < 5.minute.ago
      request.update(state: 'expired')
    else
      RequestMailer.waiting_list_confirmation(request).deliver_later(wait: 2.second)
    end
  end

end
