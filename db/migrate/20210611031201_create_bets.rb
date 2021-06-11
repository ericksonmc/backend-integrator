class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.references :ticket, null: false, foreign_key: true
      t.float :amount
      t.float :prize
      t.boolean :played
      t.integer :bet_statu_id
      t.integer :lotery_id
      t.string :number
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
