class CreateLotterySetups < ActiveRecord::Migration[6.0]
  def change
    create_table :lottery_setups do |t|
      t.float :mmt
      t.float :mpj
      t.float :jpt
      t.float :mt

      t.timestamps
    end
  end
end
