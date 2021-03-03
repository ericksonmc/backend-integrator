# == Schema Information
#
# Table name: integrators
#
#  id               :bigint           not null, primary key
#  name             :string
#  phone            :string
#  address          :string
#  email            :string
#  apikey           :string
#  status           :boolean
#  product_settings :jsonb
#  setting_apis     :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'test_helper'

class IntegratorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
