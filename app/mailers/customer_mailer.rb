class CustomerMailer < ApplicationMailer
  default from: "from@example.com"

  def test_email(customer)
    @customer = customer
    @url = 'https://test.com'
    mail(to: @customer.email, subject: 'Testmail')
  end

end
