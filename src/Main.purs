module Main where

import Prelude

import Data.Array ((..))
import Data.Int (toNumber)
import Data.Maybe (Maybe(Just))
import Effect (Effect)
import Effect.Console (log)
import Math (sin, cos, pi)
import Partial.Unsafe as Unsafe

import Graphics.Canvas as Canvas
import Graphics.Canvas (CanvasElement, Context2D)

import Graphics.Three.Camera (class Camera)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.Math.Vector (Vector3)
import Graphics.Three.Math.Vector as Vector
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Renderer (Renderer)
import Graphics.Three.Renderer as Renderer
import Graphics.Three.Scene (Scene)
import Graphics.Three.Scene as Scene

import Web.DOM.Element (Element)
import Web.DOM.Element as Element
import Web.DOM.NonElementParentNode as NonElementParentNode
import Web.HTML as HTML
import Web.HTML.HTMLDocument (HTMLDocument)
import Web.HTML.HTMLDocument as HTMLDocument
import Web.HTML.Window (Window)
import Web.HTML.Window as Window

import MeshLine as MeshLine
import OrbitControls as OrbitControls

main :: Effect Unit
main = void $ Unsafe.unsafePartial do
  log "Starting main"

  window :: Window <- HTML.window
  document :: HTMLDocument <- Window.document window
  Just (canvasElement :: Element) <-
    NonElementParentNode.getElementById
      "exteriorSphere"
      (HTMLDocument.toNonElementParentNode document)

  Just (canvas :: CanvasElement) <-
    Canvas.getCanvasElementById "exteriorSpherePane"
  context2D :: Context2D <- Canvas.getContext2D canvas

  canvasClientWidth <- Element.clientWidth canvasElement
  canvasClientHeight <- Element.clientHeight canvasElement
  let aspect = canvasClientWidth / canvasClientHeight

  renderer <- Renderer.createWebGL {antialias: true, canvas: canvasElement, alpha: true}
  -- Renderer.setSize renderer 400.0 400.0
  scene <- Scene.create
  camera <- Camera.createPerspective 75.0 aspect 0.1 10.0
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
  meshLineMat <- MeshLine.createMaterial
    { color: 0x000000
    , lineWidth: 3
    , sizeAttenuation: false
    , resolution: MeshLine.createVec2 canvasClientWidth canvasClientHeight
    }
  lineMesh <- Object3D.createMesh meshLine meshLineMat
  Scene.addObject scene lineMesh

  -- dashed circle
  dashLineMat <- MeshLine.createMaterial
    { color: 0x000000
    , lineWidth: 3
    , sizeAttenuation: false
    , dashArray: 0.015
    , transparent: true
    , depthFunc: 6 -- THREE.GreaterEqualDepth
    , resolution: MeshLine.createVec2 canvasClientWidth canvasClientHeight
    }
  dashLineMesh <- Object3D.createMesh meshLine dashLineMat
  Scene.addObject scene dashLineMesh

  Object3D.setPosition camera 0.0 0.0 2.0
  OrbitControls.update controls

  render window context2D renderer scene camera

  log "finished main"

render ::
  forall cam. Camera cam =>
  Window ->
  Context2D ->
  Renderer ->
  Scene ->
  cam ->
  Effect Unit
render window context2D renderer scene camera = do
  Renderer.render renderer scene camera
  Canvas.clearRect context2D { x: 10.0, y: 10.0, width: 800.0, height: 800.0 }
  Canvas.setFillStyle context2D "rgba(0, 0, 200, 0.2)"
  Canvas.fillRect context2D { x: 10.0, y: 10.0, width: 400.0, height: 400.0 }
  Canvas.setFillStyle context2D "rgba(0, 0, 0, 1)"
  Canvas.setFont context2D "30px sans-serif"
  Canvas.fillText context2D "OVERLAY!" 200.0 350.0
  void $ Window.requestAnimationFrame
    (render window context2D renderer scene camera)
    window
