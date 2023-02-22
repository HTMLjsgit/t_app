class CreateUserReports < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reports do |t|
      t.references :report, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
