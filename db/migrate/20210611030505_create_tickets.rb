class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :number
      t.integer :confirm
      t.float :total_amount
      t.integer :cant_bets
      t.integer :remote_user_id
      t.integer :ticket_status_id
      t.float :prize
      t.boolean :payed
      t.integer :remote_center_id
      t.integer :remote_agency_id
      t.integer :remote_group_id
      t.integer :remote_master_center_id
      t.integer :date_pay
      t.string :security
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
