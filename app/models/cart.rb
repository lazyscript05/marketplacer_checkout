require_relative '../services/discount_applier'

class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_product(product)
    @items << product
  end

  def total
    @items.sum(&:price)
  end

  def discount
    DiscountApplier.calculate_discount(total)
  end

  def discount_amount
    (total * (discount / 100.0)).round(2)
  end

  def final_total
    (total - discount_amount).round(2)
  end

  def summary
    summary_lines = []
    summary_lines << "🛒 Products in Your Shopping Cart:"
    @items.each do |product|
      summary_lines << "- #{product.name}: $#{'%.2f' % product.price}"
    end

    summary_lines << "\n💰 Subtotal: $#{'%.2f' % total}"

    if discount > 0
      summary_lines << "🎯 Discount Applied: #{discount}% off (Threshold: #{discount_threshold_text})"
      summary_lines << "➖ Discount Amount: -$#{'%.2f' % discount_amount}"
    else
      summary_lines << "❗ No discount applied. Spend more to unlock discounts!"
    end

    summary_lines << "\n🟢 FINAL TOTAL: $#{'%.2f' % final_total}"
    summary_lines.join("\n")
  end

  private

  def discount_threshold_text
    if total > 100
      '$100'
    elsif total > 50
      '$50'
    elsif total > 20
      '$20'
    else
      ''
    end
  end
end