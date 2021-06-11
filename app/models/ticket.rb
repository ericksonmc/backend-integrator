# == Schema Information
#
# Table name: tickets
#
#  id                      :bigint           not null, primary key
#  number                  :integer
#  confirm                 :integer
#  total_amount            :float
#  cant_bets               :integer
#  remote_user_id          :integer
#  ticket_status_id        :integer
#  prize                   :float
#  payed                   :boolean
#  remote_center_id        :integer
#  remote_agency_id        :integer
#  remote_group_id         :integer
#  remote_master_center_id :integer
#  date_pay                :integer
#  security                :string
#  player_id               :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Ticket < ApplicationRecord
  belongs_to :player
end
