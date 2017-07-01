let
  pkgs = import <nixpkgs> {};
  pinned = import ~/.config/nixpkgs/pin.nix;

  hpkgs = pinned.haskellPackages;
  protolude = hpkgs.protolude_git;
  ghc-env = hpkgs.ghcWithPackages (p: with p; [
      aeson
      ansi-wl-pprint
      array
      ascii-progress
      async
      attoparsec
      base
      base16-bytestring
      brick
      bytestring
      cassava
      case-insensitive
      configurator # postgrest
      concurrent-output
      containers
      cryptonite
      dhall
      deepseq
      directory
      either #postgrest
      exceptions
      filecache
      fsnotify
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
      hspec-megaparsec
      HTTP
      http-types #postgrest
      HUnit
      intero
      interpolatedstring-perl6 # postgrest
      jwt # postgrest
      lens
      lens_
      lens-aeson
      managed
      megaparsec
      memory
      microlens
      microlens-mtl
      mtl
      mtl-compat
      monad-logger
      neat-interpolation
      operational
      optparse-applicative
      optparse-generic
      optional-args
      parallel-io
      parsec
      parsers
      pcre-utils
      postgrest
      process
      protolude
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
      stm-containers
      strict-base-types
      swagger2
      temporary
      text
      time
      transformers
      trifecta
      turtle
      unix
      unordered-containers
      vault
      vector
      vty
      wai
      wai-cors # postgrest
      wai-extra # postgrest
      wai-middleware-static # postgrest
      wai-websockets
      warp
      websockets
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
