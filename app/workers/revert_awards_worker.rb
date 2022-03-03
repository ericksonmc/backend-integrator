class RevertAwardsWorker
  include Sidekiq::Worker
  TYPE_TRANSACTION = { withdrawal: 0, payment: 1 }.freeze

  # reward: {"id"=>55, "ticket_id"=>881415, "amount"=>600000.0, "status"=>"award", "award_id"=>38, "reaward"=>false}
  def perform(reward)
	Rails.logger.info "Perform Revert Award #{reward}"
    @reward = AwardDetail.find(reward['id'])
    @ticket = ticket(@reward.ticket_id)

    return unless @ticket.present?

    @player = player(@ticket.player_id)

    @balance = request_balance
  
    params = {
      amount: @reward.amount.to_f,
      type_transaccion: TYPE_TRANSACTION[:withdrawal],
      description: "Reverso de premio equivocado #{@ticket.number}",
      reference: @ticket.number,
      player_id: @player.player_id
    }
    transaction = transaction(params, TYPE_TRANSACTION[:payment])
    new_status_reward('revert')
  rescue Exception => e
    new_status_reward('unrevert', message)
    return true
  end

  private

  def new_status_reward(status, response = nil)
    @reward.update(status: status, response: response)
  end

  def transaction(transaction, transaction_type)
    transaction = IntegratorServices.new(@player, transaction, transaction_type).pay_award
  rescue Exception => e
    body = JSON.parse(e)
    raise Exception.new body
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
