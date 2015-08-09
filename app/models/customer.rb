class Customer < ActiveRecord::Base
  has_many :ordered_items, dependent: :restrict_with_exception

  validates :forename, presence: true

  validates :surname, presence: true

  validates :email, presence: true

  validates_date :date_of_birth, :before => lambda { 18.years.ago },
                               :before_message => "You must be at least 18 years old"
end
