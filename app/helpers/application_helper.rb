module ApplicationHelper
  include AuthorizedHelper
  include SorteosHelper
  require 'redis'

  def base_url
    ENV['iframe_url']
  end

  def auth_token(key)
    @redis = Redis.new
    @redis.get(token_key(key))
  end

  def set_auth_token(key, token)
    @redis = Redis.new
    @redis.set(token_key(key), token)
    @redis.expireat(token_key(key), Time.now.end_of_day.to_i)
  end

  def token_key(key)
    return 'VES_token' if key.nil?

    "#{key}_token"
  end

  def get_animalitos(sorteos, lotery_id, numero)
    sorteo_animal = sorteos.select { |sorteo| sorteo['id'] == lotery_id }&.last

    return numero if sorteo_animal['type'] != 'ANIMAL'
    numero_parsed = numero.to_s.length == 1 ? "0#{numero}" : numero.to_s
    return "#{numero}-#{animalitos[numero_parsed][0..2]}"
  end

  def animalitos
    {
      '01' => 'Carnero',
      '02' => 'Toro',
      '03' => 'Ciempies',
      '04' => 'Alacran',
      '05' => 'Leon',
      '06' => 'Rana',
      '07' => 'Perico',
      '08' => 'Raton',
      '09' => 'Aguila',
      '10' => 'Tigre',
      '11' => 'Gato',
      '12' => 'Caballo',
      '13' => 'Mono',
      '14' => 'Paloma',
      '15' => 'Zorro',
      '16' => 'Oso',
      '17' => 'Pavo',
      '18' => 'Burro',
      '19' => 'Chivo',
      '20' => 'Cochino',
      '21' => 'Gallo',
      '22' => 'Camello',
      '23' => 'Zebra',
      '24' => 'Iguana',
      '25' => 'Gallina',
      '26' => 'Vaca',
      '27' => 'Perro',
      '28' => 'Zamuro',
      '29' => 'Elefante',
      '30' => 'Caiman',
      '31' => 'Lapa',
      '32' => 'Ardilla',
      '33' => 'pescado',
      '34' => 'Venado',
      '35' => 'Jirafa',
      '36' => 'Culebra',
      '00' => 'Ballena',
      '0' => 'Delfin',
    }
  end
end
