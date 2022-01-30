if Rails.env == "development" || Rails.env == "test"
  Rails.configuration.stripe = {
    :public_key => ENV['STRIPE_PUBLIC_KEY_TEST'],
    :secret_key => ENV['STRIPE_SECRET_KEY_TEST']
  }
end
if Rails.env == "production"
  Rails.configuration.stripe = {
    :public_key => ENV['STRIPE_PUBLIC_KEY_PRODUCTON'],
    :secret_key => ENV['STRIPE_SECRET_KEY_PRODUCTION']
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]

