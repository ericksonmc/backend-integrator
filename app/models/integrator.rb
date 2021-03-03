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
class Integrator < ApplicationRecord
  validates_uniqueness_of :apikey, on: :create, message: "must be unique"

  
end
