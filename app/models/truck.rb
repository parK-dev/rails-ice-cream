# frozen_string_literal: true

class Truck < ApplicationRecord
  has_many :products
  has_many :shopping_carts

  validates :name, :owner, :city, presence: true
  validates :name, :owner, :city, length: { minimum: 1, maximum: 25, message: 'Between 1 and 25 characters' }
end
