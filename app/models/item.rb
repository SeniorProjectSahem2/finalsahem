class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :rentals
  #functions
  def prices
    price = Pricing.find(self.id)
    "#{price.daily}/per day, #{price.monthly}/per month, #{price.yearly}/per year"
  end
  
end