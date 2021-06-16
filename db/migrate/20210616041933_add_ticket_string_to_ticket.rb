class AddTicketStringToTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :ticket_string, :string
  end
end
