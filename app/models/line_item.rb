# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
end
