User.create!([
  {username: "ericksonmc", password_digest: "$2a$12$gFGr4F2iCuTn5K2jRT0UUul2/K03rrnfuHUKAzDVCn1IgUa2Smkg.", email: "erick2109@gmail.com", role: 1}
])
LotterySetup.create!([
  {mmt: 10000.0, mpj: 10000.0, jpt: 500.0, mt: 1000.0}
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
sella_tu_parley = {
  "balance": {
    "url": "https://bor.sellatuparley.com/api_caribeapuesta/balance?player_id=",
    "mehtod": "GET"
  },
  "casher_transaction": {
    "url": "https://bor.sellatuparley.com/api_caribeapuesta/transaction",
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
usersIntegrator2 = {
  VES: { username: 'SELLATUPARLEYBS', password: '123456' },
  USD: { username: 'SELLATUPARLEYDOLAR', password: '123456' }
}

usersIntegrator1 = {
  VES: { username: 'userwebtest', password: '0000' },
  USD: { username: 'TESTPROD', password: '123456' }
}
Integrator.create!([
  {name: "Caribe Apuestas", phone: "+5804126453792", address: "Margarita", email: "admin@caribeapuestas.com", apikey: "e641acd1cf5a122bdefbc4969fbac6000904ac978496f3f254bc42a2e12b9b8d", status: true, product_settings: nil, setting_apis: caribeapuestassettings, users: usersIntegrator2 }
  {name: "Sella tu parley", phone: "+5804120000000", address: "Caracas", email: "admin@sellatuparley.com", apikey: "b85210f9357b93f55fb73911ceb67254eba2279797d1ebde154e90da6c8d2985", status: true, product_settings: nil, setting_apis: sella_tu_parley, users: usersIntegrator2 }
])
