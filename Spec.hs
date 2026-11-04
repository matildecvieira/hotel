module Main (main) where

import System.Exit (exitFailure, exitSuccess)

import DadosTeste
import Faturacao
import Model
import Quartos
import Reservas

quase :: Double -> Double -> Bool
quase a b = abs (a - b) < 0.001

r1, r2, r3, r4 :: Reserva
r1 = reservasExemplo !! 0
r2 = reservasExemplo !! 1
r3 = reservasExemplo !! 2
r4 = reservasExemplo !! 3

quarto3, quarto6 :: Quarto
quarto3 = quartosExemplo !! 2
quarto6 = quartosExemplo !! 5

testes :: [(String, Bool)]
testes =
  [ ("capacidade Suite = 3", capacidade Suite == 3)
  , ("procurarQuarto existente", fmap numero (procurarQuarto 6 quartosExemplo) == Just 301)
  , ("procurarQuarto inexistente", procurarQuarto 99 quartosExemplo == Nothing)
  , ("quartosDoTipo Duplo", length (quartosDoTipo Duplo quartosExemplo) == 2)
  , ("contarQuartos", contarQuartos quartosExemplo == 6)
  , ("precoMedio", maybe False (quase (520 / 6)) (precoMedio quartosExemplo))
  , ("precoMedio lista vazia", precoMedio [] == Nothing)
  , ("noites r1", noites r1 == 3)
  , ("noites r2", noites r2 == 7)
  , ("ativa Cancelada", not (ativa r4))
  , ("ativa Confirmada", ativa r1)
  , ("sobrepoe: saida = entrada nao sobrepoe", not (sobrepoe 13 15 r1))
  , ("sobrepoe: intervalo cruzado", sobrepoe 12 14 r1)
  , ("quartoLivre ocupado", not (quartoLivre 3 12 14 reservasExemplo))
  , ("quartoLivre com reserva cancelada", quartoLivre 1 20 22 reservasExemplo)
  , ("quartoLivre no dia da saida", quartoLivre 3 13 15 [r1, r2])
  , ("quartosLivres 12-14", length (quartosLivres 12 14 quartosExemplo reservasExemplo) == 4)
  , ("reservasDoHospede 1", length (reservasDoHospede 1 reservasExemplo) == 2)
  , ("proximoEstado Pendente", proximoEstado Pendente == Just Confirmada)
  , ("proximoEstado CheckOut", proximoEstado CheckOut == Nothing)
  , ("cancelar Confirmada", fmap estado (cancelar r1) == Just Cancelada)
  , ("cancelar CheckIn falha", cancelar r2 == Nothing)
  , ("desconto 2 noites", quase (descontoPorNoites 2) 0)
  , ("desconto 3 noites", quase (descontoPorNoites 3) 0.05)
  , ("desconto 7 noites", quase (descontoPorNoites 7) 0.10)
  , ("custoEstadia r1", quase (custoEstadia quarto3 r1) 228)
  , ("custoEstadia r2", quase (custoEstadia quarto6 r2) 945)
  , ("totalServicos reserva 2", quase (totalServicos 2 servicosExemplo) 105)
  , ("totalServicos sem servicos", quase (totalServicos 4 servicosExemplo) 0)
  , ("totalFatura r2", quase (totalFatura quarto6 r2 servicosExemplo) 1050)
  , ("ocupados dia 12", ocupados 12 reservasExemplo == 2)
  , ("taxaOcupacao dia 12", quase (taxaOcupacao 12 quartosExemplo reservasExemplo) (2 / 6))
  , ("taxaOcupacao sem quartos", quase (taxaOcupacao 12 [] reservasExemplo) 0)
  , ("receitaPrevista", quase (receitaPrevista quartosExemplo reservasExemplo) 1333)
  , ("reserva r3 pendente", estado r3 == Pendente)
  ]

main :: IO ()
main = do
  let falhas = [nome | (nome, ok) <- testes, not ok]
  mapM_ (\(nome, ok) -> putStrLn ((if ok then "[ok]   " else "[FAIL] ") ++ nome)) testes
  if null falhas
    then putStrLn "Todos os testes passaram." >> exitSuccess
    else putStrLn ("Falharam: " ++ show (length falhas)) >> exitFailure
