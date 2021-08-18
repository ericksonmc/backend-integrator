class PaymentAwardsWorker
  include Sidekiq::Worker

  def perform(ticket_pay)
    # ticket_pay: {ticket_id: 881413, premio: 600000.0}
    @ticket_pay = ticket_pay
    @ticket = ticket(@ticket_pay['ticket_id'])
    @player = player(@ticket.player_id)
    params = {
      amount: @ticket_pay['premio'],
      type_transaccion: 1,
      description: 'Pago de premio',
      reference: @ticket_pay['ticket_id'],
      player_id: @player.player_id
    }

    transaction(params, 1)
        
    unless @transaction[:status] == 200
      raise StandardError.new "No se puedo pagar el siguiente premio: #{@ticket_pay} - #{player.to_i}"
    end
  end

  private

  def transaction(transaction, transaction_type)
    @transaction = IntegratorServices.new(@player, transaction, transaction_type).pay_award
  end

  def ticket(ticket_id)
    @ticket = Ticket.find_by(number: ticket_id)
  end

  def player(player_id)
    @player = Player.find(player_id)
  end
end
