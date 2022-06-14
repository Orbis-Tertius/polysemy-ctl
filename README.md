# polysemy-ctl

`polysemy-ctl` is a pure haskell version of
[cardano-transaction-library](https://github.com/Plutonomicon/cardano-transaction-lib).
This provides a way to construct transactions off-chain.

## Differences with plutus-apps

* `polysemy-ctl` is pure library code, and does not provide a rest server, openapi schemas
or contract instances.

## Differences with ctl

* `polysemy-ctl` is pure haskell, where as CTL is purescript.
