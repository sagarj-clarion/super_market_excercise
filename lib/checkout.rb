require_relative 'item'
class Checkout < Item
  def initialize(rules = [])
    @rules = rules
    @basket = {}
    @total = 0
    Item.declare_item("FR1", "Tea", 3.11)
    Item.declare_item("AP1", "Apple", 5)
    Item.declare_item("CF1", "Coffee", 11.23)
  end
  
  def scan item
    @basket["#{item}"] = @basket["#{item}"] ? @basket["#{item}"] + 1 : 1    
  end
  
  def total
    @basket.map do |basket_key,basket_value|
      result = @rules.select{|rule_key,rule_value| rule_key == basket_key}["#{basket_key}"]
      quantity = basket_value
      price = @@item["#{basket_key}"][:price]
      if result.nil?
        @total = @total + quantity * price
      else
        @total = @total + eval("#{result}")
      end
    end
    @total
  end
end
