class Guest < ApplicationRecord
  has_many :reservations, class_name: 'Reservations::Base'

  serialize :phone_numbers, coder: Array

  validates :email, uniqueness: true

  def phone_numbers=(value)
    super Array(value)
  end
end
