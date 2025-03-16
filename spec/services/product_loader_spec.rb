require 'rspec'
require 'tempfile'
require_relative '../../app/services/product_loader'
require_relative '../../app/models/product'
require 'json'

RSpec.describe ProductLoader do
  let(:sample_products) do
    [
      { "uuid" => 1411, "name" => "Jockey Wheels - Orange", "price" => "15.39" },
      { "uuid" => 23881, "name" => "Chain Ring 146mm", "price" => "65.95" }
    ]
  end

  describe '.load_products' do
    it 'loads products from a valid JSON file' do
      Tempfile.create(['products', '.json']) do |tempfile|
        tempfile.write(sample_products.to_json)
        tempfile.rewind
        products = ProductLoader.load_products(tempfile.path)
        expect(products).to be_an(Array)
        expect(products.size).to eq(2)
        expect(products.first).to be_a(Product)
        expect(products.first.uuid).to eq(1411)
        expect(products.first.name).to eq("Jockey Wheels - Orange")
        expect(products.first.price).to eq(15.39)
      end
    end

    it 'returns an empty array and prints an error message when file is missing' do
      expect {
        products = ProductLoader.load_products("nonexistent_file.json")
        expect(products).to eq([])
      }.to output(/Error loading products/).to_stdout
    end
  end
end
