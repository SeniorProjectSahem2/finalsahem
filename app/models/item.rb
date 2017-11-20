class Item < ActiveRecord::Base
  belongs_to :user 
  belongs_to :category
  has_many :rentals , dependent: :destroy
  
  
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