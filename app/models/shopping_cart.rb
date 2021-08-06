# frozen_string_literal: true

class ShoppingCart < ApplicationRecord
  belongs_to :truck
  belongs_to :customer
  has_many :products, through: :line_items

  validates :cost, :sales_tax, presence: true

  # Dealing with currencies can be done with the Money gem if required.
end
