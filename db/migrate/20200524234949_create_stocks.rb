class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.text :name
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :stocks, [:user_id, :created_at]
  end
end
