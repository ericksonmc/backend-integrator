class AddUsernameToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :username, :string
    add_column :players, :password, :string
    add_column :players, :token, :string
  end
end
