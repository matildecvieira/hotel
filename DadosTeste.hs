-- | Dados pequenos para demonstracao e testes (nomes ficticios).
module DadosTeste
  ( quartosExemplo
  , hospedesExemplo
  , reservasExemplo
  , servicosExemplo
  , hotelExemplo
  ) where

import Model

quartosExemplo :: [Quarto]
quartosExemplo =
  [ Quarto 1 101 Single   1  50
  , Quarto 2 102 Single   1  50
  , Quarto 3 103 Duplo    1  80
  , Quarto 4 201 Duplo    2  80
  , Quarto 5 202 Familiar 2 110
  , Quarto 6 301 Suite    3 150
  ]

hospedesExemplo :: [Hospede]
hospedesExemplo =
  [ Hospede 1 "Ana Costa"   "100000001" "ana@exemplo.pt"
  , Hospede 2 "Rui Santos"  "100000002" "rui@exemplo.pt"
  , Hospede 3 "Carla Mendes" "100000003" "carla@exemplo.pt"
  ]

reservasExemplo :: [Reserva]
reservasExemplo =
  [ Reserva 1 1 3 10 13 2 Confirmada
  , Reserva 2 2 6 12 19 2 CheckIn
  , Reserva 3 3 3 13 15 2 Pendente
  , Reserva 4 1 1 20 22 1 Cancelada
  ]

servicosExemplo :: [ServicoExtra]
servicosExemplo =
  [ ServicoExtra 1 1 "Pequeno-almoco" 24
  , ServicoExtra 2 2 "Spa"            60
  , ServicoExtra 3 2 "Jantar"         45
  ]

hotelExemplo :: Hotel
hotelExemplo = Hotel quartosExemplo hospedesExemplo reservasExemplo servicosExemplo
