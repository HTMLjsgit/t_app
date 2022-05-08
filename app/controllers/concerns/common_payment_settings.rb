module CommonPaymentSettings
  extend ActiveSupport::Concern

  def payment_setting_get
    @payment_setting = PaymentSetting.all.first
  end
end
