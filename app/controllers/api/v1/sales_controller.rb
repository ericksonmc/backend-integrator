class Api::V1::SalesController < ApplicationController
  before_action :authorized
  before_action :balance_player

  def create
    if player_has_balance
      ticket = sale_ticket(sales_params.to_h)
      render json: ticket
    else
      render json: {message: "Saldo insuficiente"}, status: 400 and return
    end
    
  end

  private

  def ticket
    @ticket ||= Ticket.create!({
                                number: add_plays[:data]['0']["number"],
                                confirm: add_plays[:data]['0']["confirm"],
                                total_amount: add_plays[:data]['0']["total_amount"],
                                cant_bets: add_plays[:data]['0']["cant_bets"],
                                remote_user_id: add_plays[:data]['0']["user_id"],
                                ticket_status_id: add_plays[:data]['0']["ticket_status_id"],
                                prize: add_plays[:data]['0']["prize"],
                                payed: add_plays[:data]['0']["payed"],
                                remote_center_id: add_plays[:data]['0']["center_id"],
                                remote_agency_id: add_plays[:data]['0']["agency_id"],
                                remote_group_id: add_plays[:data]['0']["group_id"],
                                remote_master_center_id: add_plays[:data]['0']["master_center_id"],
                                date_pay: add_plays[:data]['0']["date_pay"],
                                security: add_plays[:data]['0']["security"],
                                player_id: current_player.id,
                                ticket_string: generate_ticket_string
                               })
    send_transaction(@ticket)
    generate_bets
  end

  def generate_bets
    text_sql = ''
    add_plays[:data]['0']['bets'].each do |bet|
      text_sql << "(
        #{bet['id']},
      '#{@ticket.id}',
      #{bet['amount']},
      #{bet['prize'].to_f},
      #{bet['payed']},
      #{bet['bet_statu_id']},
      #{bet['lotery_id']},
      '#{bet['number']}',
      '#{current_player.id}',
      now(),
      now()
      ),"
    end
    sql = 'insert into bets (remote_bet_id, ticket_id,amount,prize,played,bet_statu_id,lotery_id,number,player_id,created_at,updated_at) values ' + text_sql[0...-1]
    ActiveRecord::Base.connection.execute(sql.squish)
  end

  def generate_ticket_string
    texto = ''
    texto += 'CARIBEAPUESTAS' + 10.chr
    texto += 'RIF: J-409540634' + 10.chr
    texto += "Ticket: ##{add_plays[:data]['0']['number']}" + 10.chr
    texto += "Serial/S: #{add_plays[:data]['0']['confirm']}" + 10.chr
    texto += "Fecha/Hora: #{Time.new.strftime('%d/%m/%Y %H:%M')}" + 10.chr
    texto += '--------------------------------' + 10.chr
    texto += agroup_bets(add_plays[:data]['0']['bets'])
    texto += '--------------------------------' + 10.chr
    texto += "Jugadas: #{add_plays[:data]['0']['cant_bets']}" + 10.chr
    texto += "Total: #{add_plays[:data]['0']['total_amount'].to_f.round(2)}" + 10.chr

    texto
  end

  def player_has_balance
    puts @balance[:data]
    @balance[:data]["saldo_actual"].to_f > params[:monto_total].to_f
  end

  def balance_player
    @balance ||= IntegratorServices.new.get_balance(current_player)
  end
  [{"c"=>"110", "j"=>[{"i"=>1, "n"=>"01", "m"=>"50000"}]}]
  def sales_params
    params.permit(
      :monto_total,
      :ced,
      :nom,
      :fec,
      :compress,
      :app,
      :ani,
      :tip,
      :cod,
      :ani_tipo,
      :producto_id,
      :beneficiencia,
      :cda,
      :cajero_id,
      jug: [:c,j:[:i,:n,:m]]
    )
  end
end