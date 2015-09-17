ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => "587",
  :domain               => "railsshoptest.com",
  :user_name            => "railsshoptest@gmail.com",
  :password             => "j11!<<=DD",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
