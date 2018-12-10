require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @category = Category.new
  end

  describe 'Validation' do

    it "is  valid with a name, price and quantity that belong to a category" do
      a_product = @category.products.new(name: "prd1", price: 100, quantity: 10)
      expect(a_product).to be_valid
    end

    it "is not valid without a name" do
      a_product = @category.products.new(price: 100, quantity: 10)
      expect(a_product).to_not be_valid
    end

    it "is not valid without a price" do
      a_product = @category.products.new(name: "prd1", quantity: 10)
      expect(a_product).to_not be_valid
    end

    it "is not valid without quantity" do
      a_product = @category.products.new(name: "prd1", price: 100)
      expect(a_product).to_not be_valid
    end

    it "is not valid without a category" do
      a_product = Product.new(name: "prd1", price: 100, quantity: 10)
      expect(a_product).to_not be_valid
    end

  end
end
