module Main (main) where

import DadosTeste
import Faturacao
import Model
import Quartos
import Reservas

main :: IO ()
main = do
  let h = hotelExemplo
  putStrLn "=== Gestao de Hotel - demonstracao Fase 1 ==="
  putStrLn ("Quartos: " ++ show (contarQuartos (quartos h)))
  putStrLn ("Preco medio/noite: " ++ show (precoMedio (quartos h)))
  putStrLn ("Quartos livres dias 12-14: "
            ++ show (map numero (quartosLivres 12 14 (quartos h) (reservas h))))
  putStrLn ("Taxa de ocupacao no dia 12: " ++ show (taxaOcupacao 12 (quartos h) (reservas h)))
  putStrLn ("Receita prevista: " ++ show (receitaPrevista (quartos h) (reservas h)))
  case (procurarQuarto 6 (quartos h), reservas h) of
    (Just q, _ : r2 : _) ->
      putStrLn ("Fatura da reserva 2: " ++ show (totalFatura q r2 (servicos h)))
    _ -> putStrLn "Dados em falta."
