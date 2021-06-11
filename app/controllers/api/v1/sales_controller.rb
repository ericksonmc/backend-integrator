class Api::V1::SalesController < ApplicationController

  def create
    begin
      if player_has_balance
        if valid_plays?
          if valid_add_plays?
            if ticket
              render json: generar_ticket
            else
              render json: { message: 'Ocurrio un error al guardar la jugada', error: '-04' }, status: 400 and return
            end
          else
            render json: { message: 'Ocurrio un error al registrar la jugada', error: '-03'}, status: 400 and return
          end
        else #si las jugadas no tienen limite
          render json: { data: plays_validates[:data]['0'], message: 'Algunas jugadas requieren atencion', error: '-02' }, status: 400 and return
        end
      else
        render json: { message: 'Recargue saldo para continuar', error: '-01' }, status: 400 and return
      end
    rescue Exception => e
      render json: { message: 'Ocurrio un error, intente de nuevo mas tarde' }, status: 400 and return
    end
  end

  
  private

  def generar_ticket
    texto = ""
    texto += "CARIBEAPUESTAS" + 10.chr
    texto += "RIF: J-409540634" + 10.chr
    texto += "Ticket: ##{ticket.id}" + 10.chr
    texto += "Serial/S: #{ticket.security}" + 10.chr
    texto += "Fecha/Hora: #{Time.new.strftime("%d/%m/%Y %H:%M")}" + 10.chr
    texto += "--------------------------------" + 10.chr
    texto += "Jugadas Aqui"
    texto += "--------------------------------" + 10.chr
    texto += "Jugadas: #{ticket.cant_bets} + Total: #{ticket.total_amount.to_f.round(2)}" + 10.chr

    texto
  end

  def generate_bets
    begin
      text_sql = ""

      add_plays[0]["bets"].each do |bet|
        text_sql << "(
        '#{ticket.id}',
        '#{bet["amount"]}',
        '#{bet["prize"]}',
        '#{bet["played"]}',
        '#{bet["bet_statu_id"]}',
        '#{bet["lotery_id"]}',
        '#{bet["number"]}',
        '#{current_player.id}')"
      end

      ActiveRecord::Base.connection.execute("
        insert into bets (id,ticket_id,amount,prize,played,bet_statu_id,lotery_id,number,player_id) values
        " + text_sql[0...-1])
    rescue Exception => e
      render json: { message: e.message }, status: 400 and return
    end
  end

  def ticket
    @ticket ||= Ticket.create(
      number: add_plays[0]["number"],
      confirm: add_plays[0]["confirm"],
      total_amount: add_plays[0]["total_amount"],
      cant_bets: add_plays[0]["cant_bets"],
      remote_user_id: add_plays[0]["user_id"],
      ticket_status_id: add_plays[0]["ticket_status_id"],
      prize: add_plays[0]["prize"],
      payed: add_plays[0]["payed"],
      remote_center_id: add_plays[0]["center_id"],
      remote_agency_id: add_plays[0]["agency_id"],
      remote_group_id: add_plays[0]["group_id"],
      remote_master_center_id: add_plays[0]["master_center_id"],
      date_pay: add_plays[0]["date_pay"],
      security: add_plays[0]["security"],
      player_id: add_plays[0]["player_id"]
    )
    generate_bets
  end

  def sale_ticket(data)
    @ticket ||= BackofficeServices.new.send_plays(data)
  end

  def player_has_balance
    balance_player[:data]["saldo_actual"].to_f > total_amount
  end

  def balance_player
    @balance_player ||= IntegratorServices.new(current_player).get_balance
  end

  def sales_params
    params[:plays].map { |p| p.permit(:number, :lotery_id, :amount)}
  end

  def total_amount
    sales_params.reduce(0) {|memo, data| memo += data[:amount].to_f}
  end

  def plays_validates
    @plays_validates ||= BackofficeServices.new(current_player, sales_params).validate_plays
  end

  def add_plays
    data = {
      cant_bets: sales_params.length,
      total_ammount: total_amount,
      security: 2021050220111514,
      bets: JSON.parse(sales_params.to_json)
    }
    @add_plays ||= BackofficeServices.new(current_player, data).add_plays
  end

  def valid_add_plays?
    add_plays
    # true
  end

  def valid_plays?
    plays_validates[:data]['0']['msj'] == "OK"
    # return true
  end
    
end