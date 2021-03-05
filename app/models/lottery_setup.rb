# == Schema Information
#
# Table name: lottery_setups
#
#  id         :bigint           not null, primary key
#  mmt        :float
#  mpj        :float
#  jpt        :float
#  mt         :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LotterySetup < ApplicationRecord
  #mmt: Monto minimo por ticket, mpj: Monto por jugada, jpt: jugadas por ticket, mt: multiplo del monto
  
end
