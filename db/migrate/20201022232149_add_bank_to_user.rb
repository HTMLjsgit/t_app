class AddBankToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bank_name, :string
    add_column :users, :bank_branch_name, :string
    add_column :users, :bank_account_type, :string
    add_column :users, :bank_account_number, :string
    add_column :users, :bank_account_horseman_name_kana, :string
  end
end
