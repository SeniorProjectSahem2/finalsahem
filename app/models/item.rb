class Item < ActiveRecord::Base
  belongs_to :user , dependent: :destroy
  belongs_to :category
  has_many :rentals , dependent: :destroy
  
   
  
  ##validations 
  
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :size, presence: true
  validates :weight, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :daily_price, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :weekly_price, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :monthly_price, presence: true, numericality: { :greater_than_or_equal_to => 0 }

 ##############################################################
 
  def quantity_left
    q = self.quantity
    Rental.where(item_id: self.id).current.each do |r|
      q = q - r.quantity
      puts r.id
    end
    return q
  end
  def owner
    return User.find(self.user_id)
  end
  #functions
  def prices
    price = Pricing.find(self.id)
    "#{price.daily}/per day, #{price.monthly}/per month, #{price.yearly}/per year"
  end
  
end