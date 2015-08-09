class Item < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :ordered_items, dependent: :restrict_with_exception
  #accepts_nested_attributes_for :categories
end
