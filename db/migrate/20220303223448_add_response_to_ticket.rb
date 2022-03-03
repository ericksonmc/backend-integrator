class AddResponseToTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :response, :jsonb
  end
end
