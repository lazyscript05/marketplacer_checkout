require 'interactor'

class Checkout
  include Interactor

  def call
    cart = context.cart

    if cart.items.empty?
      context.fail!(message: "Your cart is empty. Please add products before checking out.")
    else
      context.summary = cart.summary
      context.message = "Thank you for your purchase!"
    end
  end
end