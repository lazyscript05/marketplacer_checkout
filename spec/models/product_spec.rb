require 'rspec'
require_relative '../../app/models/product'

RSpec.describe Product do
  let(:uuid) { 1411 }
  let(:name) { "Jockey Wheels - Orange" }
  let(:price) { "15.39" }
  subject { described_class.new(uuid: uuid, name: name, price: price) }

  describe '#initialize' do
    it 'assigns the uuid, name, and price correctly' do
      expect(subject.uuid).to eq(uuid)
      expect(subject.name).to eq(name)
      expect(subject.price).to eq(15.39)
    end
  end

  describe '#to_s' do
    it 'returns a formatted string representation of the product' do
      expect(subject.to_s).to eq("#{name} - $15.39")
    end
  end
end
