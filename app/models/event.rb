class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  validates :start, :name, :menu, :location, :price, :capacity, presence: true
  validates :name, length: { minimum: 6 }
  validates :capacity, numericality: { greater_than: 0, less_than: 10 }
  validates :price, numericality: { greater_than: 0, less_than: 20 }
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  has_one_attached :photo
end
