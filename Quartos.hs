-- | Operacoes sobre quartos (funcoes puras e recursivas).
module Quartos
  ( capacidade
  , procurarQuarto
  , quartosDoTipo
  , contarQuartos
  , somaPrecos
  , precoMedio
  ) where

import Model

-- | Numero maximo de pessoas por tipo de quarto.
capacidade :: TipoQuarto -> Int
capacidade Single   = 1
capacidade Duplo    = 2
capacidade Suite    = 3
capacidade Familiar = 4

-- | Procura um quarto pelo identificador.
procurarQuarto :: Int -> [Quarto] -> Maybe Quarto
procurarQuarto _ [] = Nothing
procurarQuarto n (q:qs)
  | quartoId q == n = Just q
  | otherwise       = procurarQuarto n qs

-- | Quartos de um determinado tipo.
quartosDoTipo :: TipoQuarto -> [Quarto] -> [Quarto]
quartosDoTipo _ [] = []
quartosDoTipo t (q:qs)
  | tipo q == t = q : resto
  | otherwise   = resto
  where resto = quartosDoTipo t qs

-- | Numero de quartos.
contarQuartos :: [Quarto] -> Int
contarQuartos []     = 0
contarQuartos (_:qs) = 1 + contarQuartos qs

-- | Soma dos precos por noite.
somaPrecos :: [Quarto] -> Double
somaPrecos []     = 0
somaPrecos (q:qs) = precoNoite q + somaPrecos qs

-- | Preco medio por noite; 'Nothing' se nao ha quartos.
precoMedio :: [Quarto] -> Maybe Double
precoMedio [] = Nothing
precoMedio qs = Just (somaPrecos qs / fromIntegral (contarQuartos qs))
