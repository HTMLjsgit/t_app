class CreateRealReports < ActiveRecord::Migration[5.2]
  def change
    create_table :real_reports do |t|
      t.text :body
      t.references :real, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
