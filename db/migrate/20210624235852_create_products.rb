class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :rules
      t.string :url
      t.integer :type_product
      t.timestamps
    end
  end
end
