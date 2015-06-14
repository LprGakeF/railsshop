class Customer < ActiveRecord::Base
  has_many :ordered_items
end
