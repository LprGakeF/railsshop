class CustomerMailer < ApplicationMailer
  default from: "railsshoptest@gmail.com"

  def order_confirmation_email(customer, ordered_item)
    @customer = customer
    @ordered_item = ordered_item
    mail(to: @customer.email, subject: 'Order confirmation')
  end

  def shipping_email(customer, ordered_item)
    @customer = customer
    @ordered_item = ordered_item
    mail(to: @customer.email, subject: 'Order has been shipped')
  end

  def payment_email(customer, ordered_item)
    @customer = customer
    @ordered_item = ordered_item
    mail(to: @customer.email, subject: 'We have received your payment')
  end


end
