module Main where

import Prelude

import Data.Maybe (Maybe(Just))
import Effect (Effect)
import Effect.Console (log)
import Partial.Unsafe as Unsafe

import Graphics.Three.Camera (class Camera)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Renderer (Renderer)
import Graphics.Three.Renderer as Renderer
import Graphics.Three.Scene (Scene)
import Graphics.Three.Scene as Scene
import Graphics.Three.Util as ThreeUtil

import Web.DOM (Element)
import Web.DOM.NonElementParentNode as NonElementParentNode
import Web.HTML as HTML
import Web.HTML.HTMLDocument as HTMLDocument
import Web.HTML.Window (Window)
import Web.HTML.Window as Window

main :: Effect Unit
main = void $ Unsafe.unsafePartial do
  log "Starting main"

  window <- HTML.window
  document <- Window.document window
  Just canvasElement <-
    NonElementParentNode.getElementById
      "exteriorSphere"
      (HTMLDocument.toNonElementParentNode document)

  let aspect = 1.0

  renderer <- Renderer.createWebGL {antialias: true, canvas: canvasElement, alpha: true}
  Renderer.setSize renderer 400.0 400.0
  scene <- Scene.create
  camera <- Camera.createPerspective 75.0 aspect 0.1 1000.0
  controls <- newOrbitControls camera canvasElement

  geometry <- Geometry.createBox 1.0 1.0 1.0
  material <- Material.createMeshBasic {color: 0x00ff00}
  cube <- Object3D.createMesh geometry material
  Scene.addObject scene cube

  Object3D.setPosition camera 0.0 0.0 2.0
  orbitControlsUpdate controls

  render window renderer scene camera

  log "finished main"

render ::
  forall cam. Camera cam =>
  Window ->
  Renderer ->
  Scene ->
  cam ->
  Effect Unit
render window renderer scene camera = do
  Renderer.render renderer scene camera
  void $ Window.requestAnimationFrame
    (render window renderer scene camera)
    window

foreign import data OrbitControls :: Type

newOrbitControls ::
  forall cam. Camera cam
  => cam
  -> Element
  -> Effect OrbitControls
newOrbitControls =
  ThreeUtil.ffi
    ["camera", "domElement", ""]
    "new OrbitControls(camera, domElement)"

orbitControlsUpdate :: OrbitControls -> Effect Unit
orbitControlsUpdate oc =
  ThreeUtil.fpi
    ["orbitControls", ""]
    "orbitControls.update()"
