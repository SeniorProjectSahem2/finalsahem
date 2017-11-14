class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :user_type
  has_many :rental_requests
  has_many :rentals
  has_many :items
  has_many :notifications, foreign_key: :recipient_id
  
  #scopes
  scope :current_borrowed_items,      ->(user_id) { Rental.where("user_id = ?", user_id).where("start_date<= ?", Date.today).where("end_date>= ?", Date.today).where("status = ?","accepted") }
  scope :past_borrowed_items,      ->(user_id) { Rental.where("user_id = ?", user_id).where("end_date<= ?", Date.today).where("status = ?","accepted") }
  scope :pending_requests,      ->(user_id) { Rental.where("user_id = ?", user_id).where("end_date<= ?", Date.today).where("status = ?","pending") }
  scope :Rental_request,      ->(user_id) { Rental.joins(self.get_all_items).where("status = ?","pending") }

  #scope :Rental_request,       ->(user_id) { joins(:items).where(items: {user_id: user_id}).joins}
 def Rental_request
   user_items= Item.where(user_id: self.id)
   temp = []
   user_items.each do |item| 
   temp = temp+Rental.where(item_id: item.id).where(status: "pending")
  end 
  temp
 end
  
  def name
    "#{first_name} #{last_name}"
  end
end
