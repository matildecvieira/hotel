-- | Calculo de faturacao e ocupacao.
module Faturacao
  ( descontoPorNoites
  , custoEstadia
  , totalServicos
  , totalFatura
  , ocupados
  , taxaOcupacao
  , receitaPrevista
  ) where

import Model
import Quartos (contarQuartos, procurarQuarto)
import Reservas (ativa, noites)

-- | Desconto (fracao) conforme a duracao da estadia.
descontoPorNoites :: Int -> Double
descontoPorNoites n
  | n >= 7    = 0.10
  | n >= 3    = 0.05
  | otherwise = 0

-- | Custo do alojamento (com desconto por duracao).
custoEstadia :: Quarto -> Reserva -> Double
custoEstadia q r = base * (1 - descontoPorNoites n)
  where
    n    = noites r
    base = precoNoite q * fromIntegral n

-- | Soma dos servicos extra de uma reserva.
totalServicos :: Int -> [ServicoExtra] -> Double
totalServicos _ [] = 0
totalServicos rid (s:ss)
  | servicoReserva s == rid = custo s + resto
  | otherwise               = resto
  where resto = totalServicos rid ss

-- | Fatura final: alojamento + servicos extra.
totalFatura :: Quarto -> Reserva -> [ServicoExtra] -> Double
totalFatura q r ss = custoEstadia q r + totalServicos (reservaId r) ss

-- | Numero de quartos ocupados num dado dia (cada reserva ocupa um quarto).
ocupados :: Dia -> [Reserva] -> Int
ocupados _ [] = 0
ocupados d (r:rs)
  | ativa r && entrada r <= d && d < saida r = 1 + resto
  | otherwise                                = resto
  where resto = ocupados d rs

-- | Taxa de ocupacao (0 a 1) num dado dia.
taxaOcupacao :: Dia -> [Quarto] -> [Reserva] -> Double
taxaOcupacao _ [] _ = 0
taxaOcupacao d qs rs =
  fromIntegral (ocupados d rs) / fromIntegral (contarQuartos qs)

-- | Receita prevista de alojamento (todas as reservas nao canceladas).
receitaPrevista :: [Quarto] -> [Reserva] -> Double
receitaPrevista _ [] = 0
receitaPrevista qs (r:rs) =
  case procurarQuarto (reservaQuarto r) qs of
    Just q | estado r /= Cancelada -> custoEstadia q r + resto
    _                              -> resto
  where resto = receitaPrevista qs rs
