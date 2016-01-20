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
      result = @rules.map do |rule_key,rule_value| 
        [basket_value, rule_value] if rule_key == basket_key
      end.compact.first
      quantity = result[0]
      price = @@item["#{basket_key}"][:price]
      @total = @total + eval("#{result[1]}")
    end
    @total
  end
end
