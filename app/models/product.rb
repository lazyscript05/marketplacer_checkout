class Product
  attr_reader :uuid, :name, :price

  def initialize(uuid:, name:, price:)
    @uuid = uuid
    @name = name
    @price = price.to_f
  end

  def to_s
    "#{name} - $#{'%.2f' % price}"
  end
end