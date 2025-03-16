require 'rspec'
require_relative '../../app/interactors/add_to_cart'
require_relative '../../app/models/cart'
require_relative '../../app/models/product'

RSpec.describe AddToCart do
  let(:cart) { Cart.new }
  let(:product) { Product.new(uuid: 1411, name: "Jockey Wheels - Orange", price: "15.39") }

  it 'adds a product to the cart' do
    result = AddToCart.call(product: product, cart: cart)
    expect(result.success?).to be true
    expect(result.message).to eq("Jockey Wheels - Orange has been added to your cart.")
    expect(cart.items).to include(product)
  end

  it 'fails when product is not found' do
    result = AddToCart.call(product: nil, cart: cart)
    expect(result.success?).to be false
    expect(result.message).to eq("Product not found.")
  end
end