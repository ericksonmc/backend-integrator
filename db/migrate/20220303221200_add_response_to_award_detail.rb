class AddResponseToAwardDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :award_details, :response, :jsonb, default: nil
  end
end
