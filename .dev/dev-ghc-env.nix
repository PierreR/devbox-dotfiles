let
  pkgs = import <nixpkgs> {};
  pinned = import .config/nixpkgs/pin.nix;

  hpkgs = pinned.haskellPackages;
  dhall = hpkgs.dhall_git;
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
      case-insensitive
      containers
      cryptonite
      dhall
      deepseq
      directory
      either
      exceptions
      filecache
      foldl
      formatting
      ghc-prim
      Glob
      hashable
      http-api-data
      http-client
      hruby
      hslogger
      hspec
      intero
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
      random
      raw-strings-qq
      regex-pcre-builtin
      scientific
      semigroups
      servant
      servant-client
      shake
      split
      stm
      strict-base-types
      text
      time
      transformers
      turtle
      unix
      unordered-containers
      vector
      yaml
      trifecta
    ]);
in pkgs.buildEnv {
  name = "dev-ghc-env";
  paths = [
      ghc-env
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.stack
    ];
}
