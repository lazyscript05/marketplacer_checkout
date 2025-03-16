# **Marketplacer Checkout CLI Application**

## **Prerequisites**

[![Ruby Style Guide](https://img.shields.io/badge/Ruby-3.4.2-red)](https://www.ruby-lang.org/en/news/2025/02/14/ruby-3-4-2-released/)
[![Ruby Style Guide](https://img.shields.io/badge/Rspec-3.13-brightgreen)](https://rubygems.org/gems/rspec/versions/3.13.0)

This is a Ruby-based CLI application built as a coding challenge for Marketplacer. It simulates a checkout system for an online marketplace. The application loads a list of products from a JSON file, allows users to add products to a shopping cart, applies promotional discounts based on the subtotal, and calculates the final total.

---

## **Features**

✅ **Product Loading:** Reads product details from a `products.json` file.  
✅ **Shopping Cart:** Users can add products to a cart and view a list of items.  
✅ **Discounts:** Automatically applies promotional discounts based on the following thresholds:
- 10% off for totals greater than **$20**
- 15% off for totals greater than **$50**
- 20% off for totals greater than **$100**  
  ✅ **CLI Interface:** A command-line interface guides the user through listing products, adding items to the cart, and checking out.  
  ✅ **Testing:** Comprehensive RSpec tests ensure the functionality of each component.

---

## **Requirements**

- **Ruby:** Ensure you have Ruby installed (the Gemfile specifies Ruby 3.4.2).
- **Bundler:** Install Bundler if you haven't already:

```bash
gem install bundler
```

---

## **Setup & Installation**

### **1. Clone the Repository**
```bash
git clone https://github.com/lazyscript05/marketplacer_checkout.git
cd marketplacer_checkout
```

### **2. Install Dependencies**
Run the following command to install the required gems:
```bash
bundle install
```

### **3. Verify File Structure**
Ensure the repository contains the following structure:

```
marketplacer_checkout/
├── app/
│   ├── models/
│   │   ├── product.rb
│   │   └── cart.rb
│   ├── services/
│   │   ├── product_loader.rb
│   │   └── discount_applier.rb
│   ├── interactors/
│   │   ├── load_products.rb
│   │   ├── add_to_cart.rb
│   │   └── checkout.rb
├── data/
│   └── products.json
├── lib/
│   └── cli.rb
├── spec/
│   ├── models/
│   │   ├── product_spec.rb
│   │   └── cart_spec.rb
│   ├── services/
│   │   ├── product_loader_spec.rb
│   │   └── discount_applier_spec.rb
│   └── interactors/
│       ├── load_products_spec.rb
│       ├── add_to_cart_spec.rb
│       └── checkout_spec.rb
├── Gemfile
├── README.md
└── main.rb
```

---

## **Running the Application**
To start the CLI application, run the following command from the project root:

```bash
ruby main.rb
```

The application presents a menu with options to:
1. **List products**
2. **Add a product to the cart**
3. **View your cart**
4. **Checkout**
5. **Exit the application**

If you attempt to checkout with an empty cart, the application will notify you and return to the main menu.

---

## **Running the Tests**
This project uses RSpec for testing. To run the test suite, execute:

```bash
bundle exec rspec --format documentation
```

This command will run all tests and display detailed output about each example and its pass/fail status.

---

## **Project Structure & Design Decisions**

### **Project Structure**
- **`app/models`**: Contains core classes like `Product` and `Cart`.
- **`app/services`**: Includes business logic classes such as `ProductLoader` for loading products from JSON and `DiscountApplier` for calculating discounts.
- **`app/interactors`**: Contains interactor classes for handling business logic actions.
- **`data`**: Contains the `products.json` file with product data.
- **`lib`**: Houses the CLI interface (`cli.rb`) for user interaction.
- **`spec`**: Holds RSpec tests for models, services, and interactors.
- **`main.rb`**: The main entry point that bootstraps the CLI application.

### **Design Decisions**
- **Separation of Concerns:** Code is organized into models (data representation), services (business logic), interactors (action handling), and a CLI (user interface) to ensure modularity.
- **Testability:** The project includes a robust test suite using RSpec, which not only verifies the functionality of each component but also demonstrates a commitment to quality-first engineering practices.
- **Extensibility:** The architecture is designed to be extended. For example, adding new discount rules or integrating a web-based interface can be done with minimal adjustments.
- **User Feedback:** The CLI provides clear instructions and error messages, such as preventing checkout with an empty cart.  