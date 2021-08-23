class AddBetIdToAwardDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :award_details, :bet_id, :integer
  end
end
