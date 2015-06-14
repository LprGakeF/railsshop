class Customer < ActiveRecord::Base
  has_many :ordered_items

  validates :forename, presence: true

  validates :surname, presence: true

  validates :email, presence: true

  validates :date_of_birth, presence: true
end
