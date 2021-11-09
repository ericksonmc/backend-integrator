class AddCurrencyToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :currency, :string
  end
end
