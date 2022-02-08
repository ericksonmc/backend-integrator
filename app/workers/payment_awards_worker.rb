class PaymentAwardsWorker
  include Sidekiq::Worker
  TYPE_TRANSACTION = { withdrawal: 0, payment: 1 }.freeze

  # ticket_pay: {ticket_id: 27, premio: 600000.0}

  def perform(ticket_pay)
    Rails.logger.info "Perform Paymen Award: #{ticket_pay}"
    @ticket_pay = ticket_pay
    @ticket = ticket(@ticket_pay['ticket_id'])

    return unless @ticket.present?

    @player = player(@ticket.player_id)

    params = {
      amount: @ticket_pay['premio'].to_f,
      type_transaccion: TYPE_TRANSACTION[:payment],
      description: 'Pago de premio',
      reference: @ticket_pay['ticket_id'],
      player_id: @player.player_id
    }

    transaction(params, TYPE_TRANSACTION[:payment])
    Rails.logger.info "#{@transaction[:status]} ==== #{@transaction[:data]}"
    if @transaction[:status] == 200
      @ticket.update(prize: @ticket_pay['premio'], payed: true, date_pay: Time.now.to_i)
    else
      @ticket.update(prize: @ticket_pay['premio'], payed: false, date_pay: Time.now.to_i)
    end
  end

  private

  def transaction(transaction, transaction_type)
    @transaction = IntegratorServices.new(@player, transaction, transaction_type).pay_award
  end

  def ticket(id)
    Ticket.find(id)
  end

  def player(player_id)
    Player.find(player_id)
  end
end
