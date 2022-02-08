class AddusersToIntegrators < ActiveRecord::Migration[6.0]
  def change
    add_column :integrators, :users, :jsonb, default: {}
  end
end
