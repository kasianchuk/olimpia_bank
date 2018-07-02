ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  authentication: :plain,
  user_name: ENV['EMAIL_ADDRESS'],
  password: ENV['EMAIL_PASSWORD'],
  enable_starttls_auto: true
}
