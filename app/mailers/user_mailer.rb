class UserMailer < ApplicationMailer

  def order_receipt(order)
    @order = order
    @url  = 'http://example.com/login'
    mail(to: @order.email, subject: "Jungle: Order receipt#: #{order.id})")
  end

end
