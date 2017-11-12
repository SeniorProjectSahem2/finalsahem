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
  
  def name
    "#{first_name} #{last_name}"
  end
end
