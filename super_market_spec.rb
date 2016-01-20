require_relative 'lib/checkout.rb'
require_relative 'lib/item.rb'
describe 'SuperMarket' do
  before do
    rules = { "FR1" => "(quantity/2)*price+(quantity%2)*price",
          "AP1" => "quantity >= 3 ? 4.5 * quantity : price * quantity",
          "CF1" => "quantity * price" }
    @co = Checkout.new(rules)
  end

  describe "basket 1" do
    it "should apply buy one get one rule for FR1 item" do
      pending("Given test data has incorrect total.")
      %w(FR1 AP1 FR1 CF1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(22.25)
    end
  end

  describe "basket 2" do
    it "should apply buy one get one rule for FR1 item" do
      %w(FR1 FR1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(3.11)
    end
  end

  describe "basket 3" do
    it "should apply rule for more than or equal to 3 AP1 item" do
      %w(AP1 AP1 FR1 AP1).each {|code| @co.scan(code)}
      expect(@co.total).to eql(16.61)
    end
  end  
end
