class CreateAwards < ActiveRecord::Migration[6.0]
  def change
    create_table :awards do |t|
      t.string :number
      t.integer :draw_id
      t.jsonb :info_re_award
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
