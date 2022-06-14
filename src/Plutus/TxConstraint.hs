{-# LANGUAGE TemplateHaskell #-}

module Plutus.TxConstraint where

import           GHC.Generics
import           PlutusLedgerApi.V1
import qualified PlutusTx
import           PlutusTx.Lift      as Lift
import qualified PlutusTx.Prelude   as PlutusTx

newtype PubKey = PubKey {getPubKey :: LedgerBytes}
  deriving stock (Eq, Ord, Generic)
  deriving newtype (PlutusTx.Eq, PlutusTx.Ord, PlutusTx.ToData, PlutusTx.FromData, PlutusTx.UnsafeFromData)

makeLift ''PubKey

newtype PaymentPubKey = PaymentPubKey {unPaymentPubKey :: PubKey}
  deriving stock (Eq, Ord, Generic)
  deriving newtype (PlutusTx.Eq, PlutusTx.Ord, PlutusTx.ToData, PlutusTx.FromData, PlutusTx.UnsafeFromData)

makeLift ''PaymentPubKey

newtype PaymentPubKeyHash = PaymentPubKeyHash {unPaymentPubKeyHash :: PubKeyHash}
  deriving stock (Eq, Ord, Generic)
  deriving newtype (PlutusTx.Eq, PlutusTx.Ord, PlutusTx.ToData, PlutusTx.FromData, PlutusTx.UnsafeFromData)

makeLift ''PaymentPubKeyHash

newtype StakePubKey = StakePubKey {unStakePubKey :: PubKey}
  deriving stock (Eq, Ord, Generic)
  deriving newtype (PlutusTx.Eq, PlutusTx.Ord, PlutusTx.ToData, PlutusTx.FromData, PlutusTx.UnsafeFromData)

makeLift ''StakePubKey

newtype StakePubKeyHash = StakePubKeyHash {unStakePubKeyHash :: PubKeyHash}
  deriving stock (Eq, Ord, Generic)
  deriving newtype (PlutusTx.Eq, PlutusTx.Ord, PlutusTx.ToData, PlutusTx.FromData, PlutusTx.UnsafeFromData)

makeLift ''StakePubKeyHash

data TxConstraint
  = MustIncludeDatum Datum
  | MustValidateIn POSIXTimeRange
  | MustBeSignedBy PaymentPubKeyHash
  | MustSpendAtLeast Value
  | MustProduceAtLeast Value
  | MustSpendPubKeyOutput TxOutRef
  | MustSpendScriptOutput TxOutRef Redeemer
  | MustMintValue MintingPolicyHash Redeemer TokenName Integer
  | MustPayToPubKeyAddress
      PaymentPubKeyHash
      (Maybe StakePubKeyHash)
      (Maybe Datum)
      Value
  | MustPayToScript ValidatorHash Datum Value
  | MustHashDatum DatumHash Datum
  | MustSatisfyAnyOf [[TxConstraint]]
