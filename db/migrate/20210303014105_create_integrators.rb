class CreateIntegrators < ActiveRecord::Migration[6.0]
  def change
    create_table :integrators do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :email
      t.string :apikey
      t.boolean :status
      t.jsonb :product_settings
      t.jsonb :setting_apis

      t.timestamps
    end
  end
end
