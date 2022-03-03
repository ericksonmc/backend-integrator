class ChangeConfirmColumnFromTickets < ActiveRecord::Migration[6.0]
  def change
    change_column :tickets, :confirm, :string
  end
end
