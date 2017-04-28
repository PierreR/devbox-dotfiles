let
  pkgs = import <nixpkgs> {};
  pinned = import ~/.config/nixpkgs/pin.nix;

  hpkgs = pinned.haskellPackages;
  protolude = hpkgs.protolude_git;
  ghc-env = hpkgs.ghcWithPackages (p: with p; [
      aeson
      ansi-wl-pprint
      array
      async
      attoparsec
      base
      base16-bytestring
      bytestring
      cassava
      case-insensitive
      configurator # postgrest
      containers
      cryptonite
      dhall
      deepseq
      directory
      either #postgrest
      exceptions
      filecache
      foldl
      formatting
      ghc-prim
      Glob
      hashable
      hasql
      hasql-pool
      hasql-transaction
      heredoc #postgrest
      http-api-data
      http-client
      hruby # language-puppet
      hslogger
      hspec
      HTTP
      http-types #postgrest
      intero
      interpolatedstring-perl6 # postgrest
      jwt # postgrest
      lens
      lens-aeson
      managed
      megaparsec
      memory
      microlens
      microlens-mtl
      mtl
      mtl-compat
      neat-interpolation
      operational
      optparse-applicative
      optparse-generic
      optional-args
      parallel-io
      parsec
      parsers
      pcre-utils
      process
      protolude_git
      Ranged-sets
      random
      raw-strings-qq
      regex-pcre-builtin
      regex-tdfa #postgrest
      safe
      scientific
      semigroups
      servant
      servant-client
      shake
      split
      stm
      strict-base-types
      swagger2
      text
      time
      transformers
      trifecta
      turtle
      unix
      unordered-containers
      vector
      wai
      wai-cors # postgrest
      wai-extra # postgrest
      wai-middleware-static # postgrest
      warp
      wreq
      wizards
      yaml
    ]);
in pkgs.buildEnv {
  name = "dev-ghc-env";
  paths = [
      ghc-env
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.stack
    ];
}
