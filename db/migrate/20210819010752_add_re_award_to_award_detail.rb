class AddReAwardToAwardDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :award_details, :reaward, :boolean, default: false
  end
end
