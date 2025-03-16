class DiscountApplier
  def self.calculate_discount(total)
    if total > 100
      20
    elsif total > 50
      15
    elsif total > 20
      10
    else
      0
    end
  end
end
