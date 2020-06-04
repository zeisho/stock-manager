class AddCategoryAndMakerToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :category, :string, default: "その他"
    add_column :stocks, :maker, :string, default: "その他"
  end
end
