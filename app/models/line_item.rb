# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product
end
