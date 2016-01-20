class Item
  @@item = {}
  def self.declare_item(code, name, price)
    @@item[code] = {:name => name, :price => price }
  end
end
