class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :number_of_guests, presence: true
  attribute :status, :string, default: 'pending'
  validates :status, inclusion: { in: [ 'pending', 'rejected', 'approved' ] }
end
