# Gestão de Hotel — Programação Funcional (Haskell)

Projeto semestral em grupo (Matilde, Sofia e André). Este repositório contém a **Fase 1**: modelação e núcleo funcional.

## Descrição

Sistema de gestão de um hotel: quartos, hóspedes, reservas e serviços extra. O núcleo é feito de funções puras (disponibilidade de quartos, estado das reservas, faturação, taxa de ocupação).

## Estrutura

```
hotel/
├── README.md
├── cabal.project
├── hotel.cabal
├── src/
│   ├── Model.hs        -- tipos: Quarto, Hospede, Reserva, ServicoExtra, Hotel
│   ├── Quartos.hs      -- funções sobre quartos
│   ├── Reservas.hs     -- regras das reservas e disponibilidade
│   ├── Faturacao.hs    -- custos, descontos, ocupação, receita
│   └── DadosTeste.hs   -- dados de demonstração
├── app/Main.hs         -- demonstração
├── test/Spec.hs        -- testes
└── docs/
```

## Modelo de domínio

- `TipoQuarto` (Single, Duplo, Familiar, Suite) e `EstadoReserva` (Pendente, Confirmada, CheckIn, CheckOut, Cancelada) — tipos algébricos.
- Records: `Hospede`, `Quarto`, `Reserva`, `ServicoExtra`, `Hotel`.
- Relações: `Reserva` refere `Hospede` e `Quarto` por id; `ServicoExtra` refere `Reserva`.
- As datas são números de dia (`type Dia = Int`); uma reserva ocupa `[entrada, saida)`.

## Compilar e executar

Requer GHC e Cabal

```
cabal build
cabal run hotel
cabal test
```

## Recursão

`procurarQuarto`, `quartosDoTipo`, `contarQuartos`, `quartoLivre`, `quartosLivres`, `totalServicos`, `ocupados`, `receitaPrevista` são definidas recursivamente (sem `map`/`filter`/folds, que ficam para a Fase 2).

## Fases

Fase 1: modelo, estrutura, funções puras e recursivas, dados de teste.
