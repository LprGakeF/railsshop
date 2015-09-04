class CustomerMailer < ApplicationMailer
  default from: "railsshoptest@gmail.com"

  def test_email(customer, ordered_item)
    @customer = customer
    @ordered_item = ordered_item
    @url = 'https://test.com'
    mail(to: @customer.email, subject: 'Testmail')
  end

  def order_confirmation_email(customer, ordered_item)
    @customer = customer
    @ordered_item = ordered_item
    @url = 'https://test.com'
    mail(to: @customer.email, subject: 'Order confirmation')
  end

end
