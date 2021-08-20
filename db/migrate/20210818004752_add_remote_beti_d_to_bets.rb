class AddRemoteBetiDToBets < ActiveRecord::Migration[6.0]
  def change
    add_column :bets, :remote_bet_id, :integer
  end
end
