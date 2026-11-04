# Divisão do trabalho (Fase 1)

Cada elemento do grupo envia os seus ficheiros para o repositório do github, para o histórico Git mostrar o contributo de cada uma (a Fase 1 inclui o histórico Git do grupo).

## Quem fica com o quê

| Pessoa | Ficheiros |
| **Matilde** | `hotel.cabal`, `cabal.project`, `.gitignore`, `src/Model.hs`, `src/Reservas.hs`, `src/Faturacao.hs`, `app/Main.hs`, `README.md` |
| **Sofia** | `src/Quartos.hs`, `src/DadosTeste.hs` |
| **André** | `test/Spec.hs`, `docs/DIVISAO.md` |

## Como enviar (pelo site do GitHub)

1. Abrir o repositório e clicar em **Add file → Upload files**.
2. Arrastar o ficheiro (ou a pasta) a enviar.
3. Escrever a mensagem do commit e clicar em **Commit changes**.
4. Fazer um commit por ficheiro.

Os ficheiros dentro de pastas (`src/`, `app/`, `test/`, `docs/`) podem ser enviados arrastando a pasta com o ficheiro lá dentro.


## Antes de entregar 

- Confirmar no GitHub que todos os ficheiros e as três contas aparecem em **Commits** e **Contributors**.
- Com o GHC instalado: `cabal build`, `cabal run hotel` e `cabal test`.
- Todas devem saber explicar o código completo, não só a sua parte.
