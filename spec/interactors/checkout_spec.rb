require 'rspec'
require_relative '../../app/interactors/checkout'
require_relative '../../app/models/cart'
require_relative '../../app/models/product'

RSpec.describe Checkout do
  let(:cart) { Cart.new }
  let(:product) { Product.new(uuid: 1411, name: "Jockey Wheels - Orange", price: "15.39") }

  it 'fails when the cart is empty' do
    result = Checkout.call(cart: cart)
    expect(result.success?).to be false
    expect(result.message).to eq("Your cart is empty. Please add products before checking out.")
  end

  it 'succeeds when there are items in the cart' do
    cart.add_product(product)
    result = Checkout.call(cart: cart)
    expect(result.success?).to be true
    expect(result.message).to eq("Thank you for your purchase!")
    expect(result.summary).to include("🛒 Products in Your Shopping Cart:")
  end
end