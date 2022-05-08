class CreatePaymentSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_settings do |t|
      t.float :seller_post_commision #Post販売者負担手数料
      t.float :buyer_post_commision #Post購入者負担手数料
      t.float :stripe_commission #Stripe手数料
      t.float :consumption_tax #消費税
      t.timestamps
    end
  end
end
