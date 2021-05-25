class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  validates :start, :end, :name, :menu, :location, :price, :capacity, presence: true
  validates :name, length: { minimum: 6 }
  validates :capacity, numericality: { greater_than: 0, less_than: 10 }
  validates :price, numericality: { greater_than: 0, less_than: 20 }
end
