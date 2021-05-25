class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  validates :start, :end, :name, :menu, :location, :price, :capacity, presence: true
  validates :name, length: { minimum: 6}
end
