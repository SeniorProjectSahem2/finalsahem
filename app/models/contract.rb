class Contract < ActiveRecord::Base
  belongs_to :rental
  
  #validation
  validates_date :start_date, on_or_before: lambda { Date.current }, on_or_before_message: "cannot be in the future"
  validates_date :end_date, after: :start_date, on_or_before: lambda { Date.current }, allow_blank: true
end
