class RevertAwardsWorker
  include Sidekiq::Worker
  TYPE_TRANSACTION = {withdrawal: 0, payment: 1}

  # reward: {"id"=>55, "ticket_id"=>881415, "amount"=>600000.0, "status"=>"award", "award_id"=>38, "reaward"=>false}
  def perform(reward)
    @reward = AwardDetail.find(reward['id'])
    @ticket = ticket(@reward.ticket_id)

    return unless @ticket.present?

    @player = player(@ticket.player_id)

    @balance = request_balance

    if @balance.to_f > @reward.amount.to_f
      
      params = {
        amount: @reward.amount.to_f,
        type_transaccion: TYPE_TRANSACTION[:withdrawal],
        description: "Reverso de premio equivocado #{@ticket.number}",
        reference: @ticket.number,
        player_id: @player.player_id
      }
      transaction(params, TYPE_TRANSACTION[:payment])

      if @transaction[:status] == 200
        new_status_reward('revert')
      else
        new_status_reward('unrevert')
      end
    else
      new_status_reward('unrevert')
    end
  end

  private

  def new_status_reward(status)
    @reward.update(status: status)
  end

  def transaction(transaction, transaction_type)
    @transaction = IntegratorServices.new(@player, transaction, transaction_type).pay_award
  end

  def ticket(ticket_id)
    @ticket = Ticket.find_by(id: ticket_id)
  end

  def player(player_id)
    @player = Player.find(player_id)
  end

  def request_balance
    balance = IntegratorServices.new(@player).request_balance

    return balance[:data]['monto']
  end
end
