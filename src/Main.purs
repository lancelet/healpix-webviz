module Main where

import Prelude

import Data.Array ((..))
import Data.Int (toNumber)
import Data.Maybe (Maybe(Just))
import Effect (Effect)
import Effect.Console (log)
import Math (sin, cos, pi)
import Partial.Unsafe as Unsafe

import Graphics.Three.Camera (class Camera)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.Math.Vector as Vector
import Graphics.Three.Math.Vector (Vector3)
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Renderer (Renderer)
import Graphics.Three.Renderer as Renderer
import Graphics.Three.Scene (Scene)
import Graphics.Three.Scene as Scene

import Web.DOM.NonElementParentNode as NonElementParentNode
import Web.HTML as HTML
import Web.HTML.HTMLDocument as HTMLDocument
import Web.HTML.Window (Window)
import Web.HTML.Window as Window

import MeshLine as MeshLine
import OrbitControls as OrbitControls

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
  controls <- OrbitControls.create camera canvasElement
  OrbitControls.setZoomEnabled controls false
  OrbitControls.setPanEnabled controls false

  -- add a cube to the scene
  geometry <- Geometry.createBox 1.0 1.0 1.0
  material <- Material.createMeshBasic {color: 0x00ff00}
  cube <- Object3D.createMesh geometry material
  Scene.addObject scene cube

  -- add a meshline to the scene
  let verts :: Array Vector3
      verts = do
        let radius = 1.0
            nverts = 128
        i <- 0 .. nverts
        let theta = (toNumber i) * 2.0 * pi / (toNumber nverts)
            x = radius * cos theta
            y = radius * sin theta
        pure $ Vector.createVec3 x y 0.0

  -- solid circle
  lineGeom <- Geometry.create verts
  meshLineA <- MeshLine.create lineGeom
  meshLine <- Object3D.getGeometry meshLineA
  meshLineMat <- MeshLine.createMaterial {color: 0x000000, lineWidth: 0.003, sizeAttenuation: false}
  lineMesh <- Object3D.createMesh meshLine meshLineMat
  Scene.addObject scene lineMesh

  -- dashed circle
  dashLineMat <- MeshLine.createMaterial
    { color: 0x000000
    , lineWidth: 0.003
    , sizeAttenuation: false
    , dashArray: 0.015
    , transparent: true
    , depthFunc: 6 -- THREE.GreaterEqualDepth
    }
  dashLineMesh <- Object3D.createMesh meshLine dashLineMat
  Scene.addObject scene dashLineMesh

  Object3D.setPosition camera 0.0 0.0 2.0
  OrbitControls.update controls

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
