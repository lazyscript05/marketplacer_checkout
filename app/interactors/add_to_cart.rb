require 'interactor'

class AddToCart
  include Interactor

  def call
    product = context.product
    cart = context.cart

    if product
      cart.add_product(product)
      context.message = "#{product.name} has been added to your cart."
    else
      context.fail!(message: "Product not found.")
    end
  end
end