# == Schema Information
#
# Table name: bets
#
#  id           :bigint           not null, primary key
#  ticket_id    :bigint           not null
#  amount       :float
#  prize        :float
#  played       :boolean
#  bet_statu_id :integer
#  lotery_id    :integer
#  number       :string
#  player_id    :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Bet < ApplicationRecord
  belongs_to :ticket
  belongs_to :player
end
