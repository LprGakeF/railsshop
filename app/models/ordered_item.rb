class OrderedItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :customer

  validates :quantity, presence: true
  validates :quantity, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100}

  validates :is_in_process, presence: true, if: :is_dispatched?
  validates :is_dispatched, presence: true, if: :is_delivered?

  validates :is_delivered, absence: true, if: :is_rejected?
end
