class Transaction < ActiveRecord::Base
  belongs_to :item
  belongs_to :rental
  belongs_to :borrower, class_name: "User"
  belongs_to :lender, class_name: "User"
end
