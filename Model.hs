-- | Modelo de dominio do sistema de gestao de hotel.
module Model
  ( Dia
  , TipoQuarto(..)
  , EstadoReserva(..)
  , Hospede(..)
  , Quarto(..)
  , Reserva(..)
  , ServicoExtra(..)
  , Hotel(..)
  ) where

-- | Uma data e representada pelo numero do dia (ex.: dia 1, dia 2, ...).
-- Simplifica o calculo de noites; pode evoluir para um tipo de data real.
type Dia = Int

-- | Tipos de quarto disponiveis.
data TipoQuarto = Single | Duplo | Familiar | Suite
  deriving (Show, Eq, Ord, Enum, Bounded)

-- | Ciclo de vida de uma reserva.
data EstadoReserva = Pendente | Confirmada | CheckIn | CheckOut | Cancelada
  deriving (Show, Eq, Ord, Enum, Bounded)

-- | Hospede do hotel.
data Hospede = Hospede
  { hospedeId   :: Int
  , nomeHospede :: String
  , nifHospede  :: String
  , contacto    :: String
  } deriving (Show, Eq)

-- | Quarto do hotel.
data Quarto = Quarto
  { quartoId   :: Int
  , numero     :: Int
  , tipo       :: TipoQuarto
  , andar      :: Int
  , precoNoite :: Double
  } deriving (Show, Eq)

-- | Reserva: liga um hospede a um quarto num intervalo [entrada, saida).
-- O dia de saida nao conta como noite ocupada.
data Reserva = Reserva
  { reservaId      :: Int
  , reservaHospede :: Int      -- ^ referencia a 'hospedeId'
  , reservaQuarto  :: Int      -- ^ referencia a 'quartoId'
  , entrada        :: Dia
  , saida          :: Dia
  , pessoas        :: Int
  , estado         :: EstadoReserva
  } deriving (Show, Eq)

-- | Servico extra consumido durante uma reserva (spa, jantar, ...).
data ServicoExtra = ServicoExtra
  { servicoId      :: Int
  , servicoReserva :: Int      -- ^ referencia a 'reservaId'
  , descricao      :: String
  , custo          :: Double
  } deriving (Show, Eq)

-- | Estado global do hotel.
data Hotel = Hotel
  { quartos  :: [Quarto]
  , hospedes :: [Hospede]
  , reservas :: [Reserva]
  , servicos :: [ServicoExtra]
  } deriving (Show, Eq)
