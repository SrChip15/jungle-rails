class Order < ActiveRecord::Base

  after_create :update_product_quantity

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  def update_product_quantity
    @items = self.line_items
    @items.each do |item|
      new_quantity = item.product.quantity - item.quantity
      item.product.update(quantity: new_quantity)
    end
  end
end
