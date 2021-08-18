class PaymentAwardsWorker
  include Sidekiq::Worker

  def perform(ticket_pay)
    # ticket_pay: {ticket_id: 881413, premio: 600000.0}
    @ticket_pay = ticket_pay

    params = {
      amount: @ticket_pay[:premio],
      type_transaccion: 1,
      description: 'Pago de premio',
      reference: @ticket_pay[:ticket_id],
      player_id: player_id.player_id
    }
    transaction(player, params, 1)
    
    unless @transaction[:status] == 200
      raise StandardError.new "No se puedo pagar el siguiente premio: #{@ticket_pay} - #{player.to_i}"
    end
  end

  private

  def transaction(player, transaction, transaction_type)
    @transaction = IntegratorServices.new(player, transaction, transaction_type).pay_award
  end

  def ticket
    @ticket ||= Ticket.find(@ticket_pay[:ticket_id])
  end

  def player
    @player ||= Player.find(ticket.player_id)
  end
end
