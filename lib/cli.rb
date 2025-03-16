require_relative '../app/services/product_loader'
require_relative '../app/models/cart'

class CLI
  def initialize
    @products = ProductLoader.load_products
    @cart = Cart.new
  end

  def run
    loop do
      display_menu
      choice = gets.chomp.strip
      case choice
      when '1' then list_products
      when '2' then add_to_cart
      when '3' then view_cart
      when '4' then checkout
      when '5' then exit_program
      else
        puts '❗ Invalid option. Please try again.'
      end
    end
  end

  private

  def display_menu
    puts "\n--- 🛒 Marketplacer Checkout ---"
    puts '1. 📋 List Products'
    puts '2. ➕ Add Product to Cart'
    puts '3. 🧾 View Cart'
    puts '4. 💳 Checkout'
    puts '5. 🚪 Exit'
    print '➡️ Enter your choice: '
  end

  def list_products
    puts "\n📦 Available Products:"
    if @products.empty?
      puts "⚠️ No products available at the moment."
    else
      @products.each do |product|
        puts "- #{product.uuid}: #{product}"
      end
    end
  end

  def add_to_cart
    print "\n🔍 Enter the product UUID to add to your cart: "
    input = gets.chomp.strip
    product = @products.find { |p| p.uuid.to_s == input }

    if product
      @cart.add_product(product)
      puts "✅ #{product.name} has been added to your cart."
    else
      puts "❌ Product with UUID '#{input}' not found. Please try again."
    end
  end

  def view_cart
    puts "\n🧾 Your Cart:"
    if @cart.items.empty?
      puts "🫙 Your cart is empty. Add some products to get started!"
    else
      puts @cart.summary
    end
  end

  def checkout
    if @cart.items.empty?
      puts "\n⚠️ Your cart is empty. Please add products before checking out."
    else
      puts "\n💳 --- Checkout ---"
      puts @cart.summary
      puts "\n🎉 Thank you for your purchase!"
      exit_program
    end
  end

  def exit_program
    puts "\n👋 Exiting. Have a wonderful day!"
    exit
  end
end