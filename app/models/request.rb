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

end
