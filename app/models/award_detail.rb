# == Schema Information
#
# Table name: award_details
#
#  id         :bigint           not null, primary key
#  ticket_id  :integer
#  amount     :float
#  status     :integer          default("award"), not null
#  award_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  reaward    :boolean          default(FALSE)
#  bet_id     :integer
#
class AwardDetail < ApplicationRecord
  enum status: { award: 0, pay: 1, revert: 2, pending_revert: 3, unrevert: 4 }
end
