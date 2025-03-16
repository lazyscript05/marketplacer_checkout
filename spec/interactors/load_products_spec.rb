require 'rspec'
require_relative '../../app/interactors/load_products'
require_relative '../../app/models/product'

RSpec.describe LoadProducts do
  describe '.call' do
    it 'loads products successfully' do
      result = LoadProducts.call
      expect(result.success?).to be true
      expect(result.products).to be_an(Array)
      expect(result.products.size).to be > 0
    end
  end
end