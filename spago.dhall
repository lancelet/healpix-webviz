{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "canvas"
  , "console"
  , "debug"
  , "effect"
  , "math"
  , "psci-support"
  , "purescript-three"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
