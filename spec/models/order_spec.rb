require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.create(name: "test")
      @product1 = @category.products.create!(
        name: "test1",
        price: 100,
        quantity: 10
      )
      @product2 = @category.products.create!(
        name: "test2",
        price: 200,
        quantity: 5
      )
      # Setup at least one product that will NOT be in the order
      @product3 = @category.products.create!(
        name: "test3",
        price: 20,
        quantity: 100
      )
    end

    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(total_cents: 20000, stripe_charge_id: "1234", email: "test@123.com")
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price_cents,
        total_price: @product1.price_cents
      )
      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product1.price_cents,
        total_price: @product1.price_cents
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(9)
      expect(@product2.quantity).to eq(4)
    end

    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      expect(@product3.quantity).to eq(100)
    end

  end
end
