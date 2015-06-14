class Item < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :ordered_items
  #accepts_nested_attributes_for :categories
end
