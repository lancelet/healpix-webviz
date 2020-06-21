module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import Graphics.Three.Renderer

main :: Effect Unit
main = do
  log "Starting main"

  renderer <- createWebGL {antialias: true}

  log "finished main"
