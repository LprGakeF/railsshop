class Category < ActiveRecord::Base
  has_and_belongs_to_many :items

  validates :name, length: { in: 2..32 }
end
