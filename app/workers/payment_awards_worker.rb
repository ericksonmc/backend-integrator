class PaymentAwardsWorker
  include Sidekiq::Worker
  TYPE_TRANSACTION = {withdrawal: 0, payment: 1}

  # ticket_pay: {ticket_id: 881413, premio: 600000.0}
  def perform(ticket_pay)
    @ticket_pay = ticket_pay
    @ticket = ticket(@ticket_pay['ticket_id'])

    return unless @ticket.present?

    @player = player(@ticket.player_id)

    params = {
      amount: @ticket_pay['premio'],
      type_transaccion: TYPE_TRANSACTION[:payment],
      description: 'Pago de premio',
      reference: @ticket_pay['ticket_id'],
      player_id: @player.player_id
    }

    transaction(params, TYPE_TRANSACTION[:payment])
        
    if @transaction[:status] == 200
      @ticket.update(prize: @ticket_pay['premio'], payed: true, date_pay: Time.now)
    else
      @ticket.update(prize: @ticket_pay['premio'], payed: false, date_pay: Time.now)
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
