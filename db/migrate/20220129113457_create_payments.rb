class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    #支払い履歴の情報テーブル
    create_table :payments do |t|
      t.text :description
      t.string :currency, default: "jpy"
      t.string :customer_id
      t.time :payment_data
      t.string :uuid
      t.string :charge_id
      t.bigint :stripe_commission
      t.bigint :stripe_amount_after_subtract_commision
      t.string :receipt_url
      t.string :receive_id
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
