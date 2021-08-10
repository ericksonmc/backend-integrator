User.create!([
  {username: "ericksonmc", password_digest: "$2a$12$gFGr4F2iCuTn5K2jRT0UUul2/K03rrnfuHUKAzDVCn1IgUa2Smkg.", email: "erick2109@gmail.com", role: 1}
])
LotterySetup.create!([
  {mmt: 10000.0, mpj: 10000.0, jpt: 500.0, mt: 1000.0}
])
Player.create!([
  {email: "erick2109@gmail.com", cedula: "20236734", player_id: "360", company: "dataweb ca", site: "www.centrodeapuestas.com", integrator_id: 1, username: nil, password: nil, token: nil},
  {email: "erick2109@gmail.com", cedula: nil, player_id: "1", company: "CaribeApuestas CA", site: "www.caribeapuestas.com", integrator_id: 2, username: "ericksonmc", password: "Erick2109", token: nil},
  {email: "ericksonmcc@gmail.com", cedula: nil, player_id: "2", company: "CaribeApuestas CA", site: "www.caribeapuestas.com", integrator_id: 2, username: "ericksonmcc", password: "Erick2109", token: nil},
  {email: "ericksonmcc@gmail.com", cedula: nil, player_id: "2", company: "CaribeApuestas CA", site: "www.caribeapuestas.com", integrator_id: 6, username: "ericksonmcc", password: "Erick2109", token: nil},
  {email: "userwebtest@gmail.com", cedula: nil, player_id: nil, company: "CaribeApuestas CA", site: "www.caribeapuestas.com", integrator_id: 2, username: "userwebtest", password: "0000", token: nil}
])

caribeapuestassettings = {
  "balance": {
    "url": "https://ca02-vm03.sagcit.com/GCIT.Api/api/CaribeApuestas/saldo?player_id=",
    "mehtod": "GET"
  },
  "casher_transaction": {
    "url": "https://ca02-vm03.sagcit.com/GCIT.Api/api/CaribeApuestas/transaccion",
    "method": "POST",
    "params": [
      "amount",
      "type_transaction",
      "description",
      "reference",
      "player_id",
      "credit_type"
    ]
  }
}
Integrator.create!([
  {name: "Integrator Centro de Apuestas", phone: "+584141234567", address: "Maracaibo", email: "admin@centrodeapuestas.com", apikey: "a50f74ffe424c2f652e10e42112602ee5546", status: true, product_settings: nil, setting_apis: {"balance"=>{"url"=>"https://www.centrodeapuestas.com/external/api/v1/sales/player_balance?player_id=", "mehtod"=>"GET"}, "casher_transaction"=>{"url"=>"https://www.centrodeapuestas.com/external/api/v1/sales/player_operacion", "method"=>"POST", "params"=>["amount", "type_transaction", "description", "reference", "player_id", "credit_type"]}}},
  {name: "Caribe Apuestas", phone: "+5804126453792", address: "Margarita", email: "admin@caribeapuestas.com", apikey: "e641acd1cf5a122bdefbc4969fbac6000904ac978496f3f254bc42a2e12b9b8d", status: true, product_settings: nil, setting_apis: caribeapuestassettings }
])

Product.create([
  {
    name: "Triple Caracas",
    rules: "http://www.triplecaracas.com/assets/REGLAMENTOWEB.pdf",
    type_product: 1,
    url: 'http://www.triplecaracas.com/'
  },{
    name: "Triple Caliente",
    rules: "http://triplecaliente.com.ve/images/ReglamentodeJuegoTripleCaliente.pdf",
    type_product: 1,
    url: 'http://triplecaliente.com.ve'
  },{
    name: "Triple Zulia",
    rules: "http://resultadostriplezulia.com/images/ReglamentodeJuegoTripleZulia_23-10-2015.pdf",
    type_product: 1,
    url: 'http://resultadostriplezulia.com'
  },{
    name: "Zamorano",
    rules: "http://triplezamorano.com/images/Reglamento_TripleZamorano_23-10-2015.pdf",
    type_product: 1,
    url: 'http://triplezamorano.com/'
  },{
    name: "Jungla Millonaria",
    rules: "http://junglamillonaria.com/images/Reglamento_Jungla_Millonaria.pdf",
    type_product: 0,
    url: 'http://junglamillonaria.com/'
  },{
    name: "La Granjita",
    rules: "https://iframe.centrodeapuestas.com/rules-la-granjita.pdf",
    type_product: 0,
    url: 'https://lagranjitaonline.com/'
  },{
    name: 'La granjita internacional',
    rules: '',
    type_product: 0,
    url: 'https://www.instagram.com/lagranjitainternacional'
  },{
    name: 'Ruleta activa',
    rules: '',
    type_product: 0,
  },{
    name: 'La Ricachona',
    rules: '',
    type_product: 1,
    url: 'https://www.instagram.com/laricachonavzla/'
  }])