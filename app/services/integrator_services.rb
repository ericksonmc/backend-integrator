class IntegratorServices
  include ApplicationHelper
  require 'httparty'

  def initialize(player, transaction = nil, transaction_type = nil)
    @player = player
    @transaction = transaction
    @transaction_type = transaction_type
    @integrator = Integrator.find(@player.integrator_id)
    @options = {
      headers: {
        'Content-Type' => 'application/json'
      }
    }
  end

  def request_balance
    url = "#{@integrator.setting_apis['balance']['url']}#{@player.player_id}"
    response = HTTParty.get(url, @options)
    get_response(response)
  end

  def make_transaction
    params = {
      amount: @transaction.total_amount,
      type_transaccion: @transaction_type,
      description: @transaction.ticket_string,
      reference: @transaction.id,
      player_id: @player.player_id
    }
    @options.merge!({ body: params.to_json })
    response = HTTParty.post(@integrator.setting_apis['casher_transaction']['url'], @options)
    get_response(response)
  end

  def pay_award
    @options.merge!({ body: @transaction.to_json })
    response = HTTParty.post(@integrator.setting_apis['casher_transaction']['url'], @options)
    get_response(response)
  end

  private

  def get_response(request)
    raise Exception.new request.body if request.code == 400
    {
      data: JSON.parse(request.body),
      headers: request.headers,
      status: request.code
    }
  end
end
