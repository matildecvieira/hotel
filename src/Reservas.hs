-- | Regras essenciais das reservas (funcoes puras e recursivas).
module Reservas
  ( noites
  , ativa
  , sobrepoe
  , quartoLivre
  , quartosLivres
  , reservasDoHospede
  , proximoEstado
  , cancelar
  ) where

import Model

-- | Numero de noites de uma reserva.
noites :: Reserva -> Int
noites r = saida r - entrada r

-- | Uma reserva esta ativa se nao foi cancelada nem terminou.
ativa :: Reserva -> Bool
ativa r = case estado r of
  Cancelada -> False
  CheckOut  -> False
  _         -> True

-- | A reserva sobrepoe-se ao intervalo [e, s)?
-- O dia de saida de uma reserva pode ser o dia de entrada de outra.
sobrepoe :: Dia -> Dia -> Reserva -> Bool
sobrepoe e s r = e < saida r && entrada r < s

-- | Um quarto esta livre no intervalo [e, s) se nenhuma reserva ativa
-- desse quarto se sobrepoe a esse intervalo.
quartoLivre :: Int -> Dia -> Dia -> [Reserva] -> Bool
quartoLivre _ _ _ [] = True
quartoLivre q e s (r:rs)
  | reservaQuarto r == q && ativa r && sobrepoe e s r = False
  | otherwise = quartoLivre q e s rs

-- | Quartos livres no intervalo [e, s).
quartosLivres :: Dia -> Dia -> [Quarto] -> [Reserva] -> [Quarto]
quartosLivres _ _ [] _ = []
quartosLivres e s (q:qs) rs
  | quartoLivre (quartoId q) e s rs = q : resto
  | otherwise                       = resto
  where resto = quartosLivres e s qs rs

-- | Reservas de um hospede.
reservasDoHospede :: Int -> [Reserva] -> [Reserva]
reservasDoHospede _ [] = []
reservasDoHospede h (r:rs)
  | reservaHospede r == h = r : resto
  | otherwise             = resto
  where resto = reservasDoHospede h rs

-- | Proximo estado do ciclo de vida; 'Nothing' se nao ha transicao.
proximoEstado :: EstadoReserva -> Maybe EstadoReserva
proximoEstado Pendente   = Just Confirmada
proximoEstado Confirmada = Just CheckIn
proximoEstado CheckIn    = Just CheckOut
proximoEstado CheckOut   = Nothing
proximoEstado Cancelada  = Nothing

-- | So se pode cancelar uma reserva Pendente ou Confirmada.
cancelar :: Reserva -> Maybe Reserva
cancelar r = case estado r of
  Pendente   -> Just (r { estado = Cancelada })
  Confirmada -> Just (r { estado = Cancelada })
  _          -> Nothing
