class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :email
      t.string :cedula
      t.string :player_id
      t.string :company
      t.string :site
      t.integer :integrator_id, null: false

      t.timestamps
    end
  end
end
