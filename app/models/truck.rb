class Truck < ApplicationRecord
  has_many :products
  has_many :orders

  validates :name, :owner, :city, presence: true
  validates :name, :owner, :city, length: { minimum: 1, maximum: 25, message: "character length: 1-25" }
end
