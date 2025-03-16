require 'rspec'
require_relative '../../app/models/cart'
require_relative '../../app/models/product'

RSpec.describe Cart do
  let(:product1) { Product.new(uuid: 1411, name: "Jockey Wheels - Orange", price: "15.39") }
  let(:product2) { Product.new(uuid: 23881, name: "Chain Ring 146mm", price: "65.95") }
  let(:product3) { Product.new(uuid: 13008, name: "Carbon Brake Pads", price: "92.00") }

  subject(:cart) { described_class.new }

  describe '#add_product' do
    it 'adds a product to the cart' do
      expect { cart.add_product(product1) }.to change { cart.items.size }.by(1)
    end
  end

  describe '#total' do
    it 'calculates the total price of items in the cart' do
      cart.add_product(product1)
      cart.add_product(product2)
      expected_total = product1.price + product2.price
      expect(cart.total).to eq(expected_total)
    end
  end

  describe 'discount and totals' do
    context 'when total is below discount threshold' do
      it 'applies no discount' do
        cart.add_product(product1)  # 15.39 < 20, so no discount
        expect(cart.discount).to eq(0)
        expect(cart.discount_amount).to eq(0.0)
        expect(cart.final_total).to eq(15.39)
      end
    end

    context 'when total is greater than $20 but not exceeding $50' do
      it 'applies a 10% discount' do
        # Create a product that will yield a total between 20 and 50
        product = Product.new(uuid: 9999, name: "Test Product", price: "25.00")
        cart.add_product(product)
        expect(cart.discount).to eq(10)
        discount_amount = (25.00 * 0.10).round(2)
        expect(cart.discount_amount).to eq(discount_amount)
        expect(cart.final_total).to eq((25.00 - discount_amount).round(2))
      end
    end

    context 'when total is greater than $50 but not exceeding $100' do
      it 'applies a 15% discount' do
        cart.add_product(product2)  # 65.95 > 50 so discount should be 15%
        expect(cart.discount).to eq(15)
        discount_amount = (65.95 * 0.15).round(2)
        expect(cart.discount_amount).to eq(discount_amount)
        expect(cart.final_total).to eq((65.95 - discount_amount).round(2))
      end
    end

    context 'when total is greater than $100' do
      it 'applies a 20% discount' do
        cart.add_product(product2) # 65.95
        cart.add_product(product3) # 92.00; total = 157.95 > 100
        expect(cart.discount).to eq(20)
        discount_amount = (157.95 * 0.20).round(2)
        expect(cart.discount_amount).to eq(discount_amount)
        expect(cart.final_total).to eq((157.95 - discount_amount).round(2))
      end
    end
  end

  describe '#summary' do
    it 'returns a summary string including products, subtotal, discount, and final total' do
      cart.add_product(product1)
      cart.add_product(product2)
      summary = cart.summary

      expect(summary).to include("🛒 Products in Your Shopping Cart:")
      expect(summary).to include("- #{product1.name}: $#{'%.2f' % product1.price}")
      expect(summary).to include("💰 Subtotal: $#{'%.2f' % cart.total}")

      if cart.discount > 0
        expect(summary).to include("🎯 Discount Applied: #{cart.discount}% off")
        expect(summary).to include("➖ Discount Amount: -$#{'%.2f' % cart.discount_amount}")
      else
        expect(summary).to include("❗ No discount applied")
      end

      expect(summary).to include("🟢 FINAL TOTAL: $#{'%.2f' % cart.final_total}")
    end
  end
end
