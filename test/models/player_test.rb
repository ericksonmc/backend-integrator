# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  email      :string
#  cedula     :string
#  player_id  :string
#  company    :string
#  site       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
