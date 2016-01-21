require_relative 'lib/checkout.rb'
require_relative 'lib/item.rb'
describe 'SuperMarket' do
  before do
    rules = { "FR1" => "(quantity/2)*price+(quantity%2)*price",
              "AP1" => "quantity >= 3 ? 4.5 * quantity : price * quantity"}
    @co = Checkout.new(rules)
  end

  describe Checkout, "#scan" do
    it "should increment the count" do  
      expect(%w(FR1 FR1 FR1).map {|code| @co.scan(code)}.last).to eql(3)
    end
  end

  describe "basket with FR1 AP1 FR1 CF1 items" do
    it "should apply buy one get one rule for FR1 item" do
      pending("Given test data has incorrect total.")
      %w(FR1 AP1 FR1 CF1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(22.25)
    end
  end

  describe "basket with FR1 items" do
    it "should apply buy one get one rule for FR1 item" do
      %w(FR1 FR1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(3.11)
    end

    it "should not apply buy one get one rule for single FR1 item" do
      %w(FR1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(3.11)
    end

  end

  describe "basket AP1 AP1 FR1 AP1 items" do
    it "should apply rule for more than or equal to 3 AP1 item" do
      %w(AP1 AP1 FR1 AP1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(16.61)
    end
  end

  describe "basket with AP1 FR1 AP1 FR1 AP1 items" do
    it "should apply multiple AP1 item discount for AP1 and buy one get one rule for FR1" do
      %w(AP1 FR1 AP1 FR1 AP1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(16.61)
    end
  end
end
