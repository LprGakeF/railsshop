class Address < ActiveRecord::Base
  belongs_to :customer

  validates :street, length: { in: 2..32 }
  validates :house_number, length: { in: 1..8 }
  validates :postcode, length: { in: 2..16 }
  validates :country, length: { in: 2..32 }
end
