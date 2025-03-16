require 'rspec'
require_relative '../../app/services/discount_applier'

RSpec.describe DiscountApplier do
  describe '.calculate_discount' do
    it 'returns 0 for totals <= $20' do
      expect(DiscountApplier.calculate_discount(20)).to eq(0)
      expect(DiscountApplier.calculate_discount(10)).to eq(0)
    end

    it 'returns 10 for totals > $20 and <= $50' do
      expect(DiscountApplier.calculate_discount(25)).to eq(10)
      expect(DiscountApplier.calculate_discount(50)).to eq(10)
    end

    it 'returns 15 for totals > $50 and <= $100' do
      expect(DiscountApplier.calculate_discount(51)).to eq(15)
      expect(DiscountApplier.calculate_discount(100)).to eq(15)
    end

    it 'returns 20 for totals > $100' do
      expect(DiscountApplier.calculate_discount(100.01)).to eq(20)
      expect(DiscountApplier.calculate_discount(150)).to eq(20)
    end
  end
end
