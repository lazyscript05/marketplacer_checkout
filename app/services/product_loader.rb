require 'json'
require_relative '../models/product'

class ProductLoader
  def self.load_products(file_path = 'data/products.json')
    file = File.read(file_path)
    json_data = JSON.parse(file)
    json_data.map do |product_hash|
      Product.new(
        uuid: product_hash['uuid'],
        name: product_hash['name'],
        price: product_hash['price']
      )
    end
  rescue StandardError => e
    puts "Error loading products: #{e.message}"
    []
  end
end
