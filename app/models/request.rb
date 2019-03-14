class Request < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A(\+33|0)[1-9](\d\d){4}\z/ }
  validates :biography, presence: true, length: { maximum: 500 }
  validates :state, presence: true, inclusion: {
    in: %w(unconfirmed confirmed accepted expired),
    message: "%{value} is not a valid state"
  }


  scope :unconfirmed, -> { where(state: 'unconfirmed') }
  scope :confirmed, -> { where(state: 'confirmed') }
  scope :accepted, -> { where(state: 'accepted') }
  scope :expired, -> { where(state: 'expired') }

  def accept!
    self.state = 'accepted'
  end

  def validate_email
    self.state = 'confirmed'
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
