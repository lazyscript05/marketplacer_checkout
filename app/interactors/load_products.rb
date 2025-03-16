require 'interactor'
require_relative '../services/product_loader'

class LoadProducts
  include Interactor

  def call
    context.products = ProductLoader.load_products
  end
end