# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

integrator = Integrator.create(
  name: 'Integrator Centro de Apuestas',
  phone: '+584141234567',
  address: 'Maracaibo',
  email: 'admin@centrodeapuestas.com',
  apikey: Random.hex(18), 
  status: true,
  setting_apis: {
    balance: {
      url: 'https://www.centrodeapuestas.com/external/api/v1/sales/player_balance?player_id=',
      mehtod: 'GET'
    },
    casher_transaction: {
      url: 'https://www.centrodeapuestas.com/external/api/v1/sales/player_operacion',
      method: 'POST',
      params: ['amount','type_transaction','description','reference','player_id','credit_type']
    }
  },
  product_settings: nil
)

user = User.create(
  username: 'ericksonmc',
  password: 'Erick2109',
  email: 'erick2109@gmail.com',
  role: 1
)

setup = LotterySetup.create(mmt: 10000, mpj:10000, jpt: 500, mt: 1000)