# == Schema Information
#
# Table name: bets
#
#  id           :bigint           not null, primary key
#  ticket_id    :bigint           not null
#  amount       :float
#  prize        :float
#  playerd      :boolean
#  bet_statu_id :integer
#  lotery_id    :integer
#  number       :string
#  player_id    :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class BetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
