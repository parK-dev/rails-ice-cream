class Order < ApplicationRecord
  belongs_to :truck
  has_many :products, through: :line_items

  validates :cost_before_tax, :sales_tax, :cost_after_tax, presence: true
end
