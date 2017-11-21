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
  
  ##validations dont make sense here right?
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :location_id, presence: true
  validates :user_type_id, presence: true
  validates :email, presence: true
  
  ##############################################################
  
  
  
  #scopes
  scope :current_borrowed_items,      ->(id) { Item.joins(:rentals).where("user_id = ?", id).where("end_date>= ?", Date.today).where("status = ?","accepted") }
  scope :past_borrowed_items,      ->(user_id) { Rental.where("user_id = ?", user_id).where("end_date<= ?", Date.today).where("status = ?","accepted") }
  scope :pending_requests,      ->(user_id) { Rental.where("user_id = ?", user_id).where("end_date<= ?", Date.today).where("status = ?","pending") }

  #scope :Rental_request,       ->(user_id) { joins(:items).where(items: {user_id: user_id}).joins}
 def Rental_request
   user_items= Item.where(user_id: self.id)
   temp = []
   user_items.each do |item| 
   temp = temp+Rental.where(item_id: item.id).where(status: "pending").order(:start_date)
  end 
  temp
 end
 
 
 
  
  def name
    "#{first_name} #{last_name}"
  end
end
