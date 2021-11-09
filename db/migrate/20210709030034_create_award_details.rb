class CreateAwardDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :award_details do |t|
      t.integer :ticket_id
      t.float :amount
      t.integer :status, default: 0, null: false
      t.references :award
      t.timestamps
    end
  end
end
