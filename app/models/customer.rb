class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :timeoutable, :validatable
  has_many :ordered_items, dependent: :restrict_with_exception

  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address

  after_create :do_admin

  validates :forename, length: { in: 2..32 }
  validates :surname, length: { in: 2..32 }

  validates_date :date_of_birth, :on_or_before => lambda { 18.years.ago },
    :on_or_before_message => "you must be at least 18 years old"

  validates_date :date_of_birth, :on_or_after => lambda { 150.years.ago },
    :on_or_after_message => "you must not be older least 150"

  private

  def do_admin
     if self.email == "railsshoptest@gmail.com"
       self.update_column(:admin, true)
     end
   end

end
