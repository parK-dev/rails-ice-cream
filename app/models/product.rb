# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :truck

  validates :name, :price, :stock, presence: true
  validates :name, length: { minimum: 1, maximum: 25, message: 'Between 1 and 25 characters' }
  validates :price, numericality: { greater_than: 0 }
end
