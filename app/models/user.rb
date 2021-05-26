class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_many :events, through: :bookings
  has_many :owned_events, class_name: 'Event', foreign_key: :user_id
  # validates :first_name, :last_name, :date_of_birth, presence: true
end
