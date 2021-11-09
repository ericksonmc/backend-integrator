# == Schema Information
#
# Table name: awards
#
#  id            :bigint           not null, primary key
#  number        :string
#  draw_id       :integer
#  info_re_award :jsonb
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class AwardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
