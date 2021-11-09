# == Schema Information
#
# Table name: awards
#
#  id            :bigint           not null, primary key
#  number        :string
#  draw_id       :integer
#  info_re_award :jsonb
#  status        :integer          default("created"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Award < ApplicationRecord
  has_many :award_details, dependent: :destroy
  enum status: { created: 0, award: 1, updated: 2, re_award: 3 }
end
