# == Schema Information
#
# Table name: award_details
#
#  id         :bigint           not null, primary key
#  ticket_id  :integer
#  amount     :float
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class AwardDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
