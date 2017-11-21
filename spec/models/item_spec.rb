require "rails_helper"

RSpec.describe Item, :type => :model do
    before(:all) do 
        @item = Item.new(id: 1, name: "speakers", description: "black dell", size: "medium", user_id: 10, quantity: 5)
        
        @rental = Rental.new( quantity: 2,start_date: "2017-11-15", end_date: "2017-11-22", status: "accepted", user_id: 10)
        @rental.item = @item
        @rental = Rental.new(item_id: 1,  quantity: 1,start_date: "2017-11-15", end_date: "2017-11-27", status: "accepted", user_id: 13)
        @rental.save
    end
  it "it should create an item successfully" do
        expect(@item.quantity_left).to eq(2)
  end
end