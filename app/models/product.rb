class Product < ApplicationRecord
  belongs_to :truck

  validates :name, :price, :stock, :type, presence: true
  validates :name, length: { minimum: 1, maximum: 25, message: "character length: 1-25" }
  validates :type, inclusion: { in: %w(ShavedIce IceCream SnackBar), 
                                message: "type must be of 'ShavedIce'
                                          'IceCream' or 'SnackBar'" }
end
