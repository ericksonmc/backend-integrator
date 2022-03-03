class AddLegalNameToIntegrator < ActiveRecord::Migration[6.0]
  def change
    add_column :integrators, :legal_name, :string
    add_column :integrators, :dni, :string
  end
end
