# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :types
  has_many :products

  validates :name, presence: true
  validates :name, length: { minimum: 1, maximum: 25, message: 'Between 1 and 25 characters' }
end
