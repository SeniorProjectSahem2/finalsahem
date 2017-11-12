class Rental < ActiveRecord::Base
  after_create :set_to_pending
  belongs_to :user
  belongs_to :item
  has_one :contract
  private
  def set_to_pending
    self.update_attribute(:status, "pending")
  end
  # #validation 
  #   validates_date :start_date, on_or_before: lambda { Date.current }, on_or_before_message: "cannot be in the future"
  # validates_date :end_date, after: :start_date, on_or_before: lambda { Date.current }, allow_blank: true
end
