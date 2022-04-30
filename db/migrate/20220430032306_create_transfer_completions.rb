class CreateTransferCompletions < ActiveRecord::Migration[5.2]
  def change
    create_table :transfer_completions do |t|
      t.boolean :already_transfer, default: false, null: false
      t.references :user, foreign_key: true
      t.references :transfer_request, foreign_key: true

      t.timestamps
    end
  end
end
