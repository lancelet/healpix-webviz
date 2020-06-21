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
import Graphics.Three.Geometry (Geometry)
import Graphics.Three.Material as Material
import Graphics.Three.Math.Vector as Vector
import Graphics.Three.Math.Vector (Vector3)
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

  -- add a cube to the scene
  geometry <- Geometry.createBox 1.0 1.0 1.0
  material <- Material.createMeshBasic {color: 0x00ff00}
  cube <- Object3D.createMesh geometry material
  Scene.addObject scene cube

  -- add a meshline to the scene
  let verts :: Array Vector3
      verts = do
        let radius = 1.0
            nverts = 64
        i <- 0 .. nverts
        let theta = (toNumber i) * 2.0 * pi / (toNumber nverts)
            x = radius * cos theta
            y = radius * sin theta
        pure $ Vector.createVec3 x y 0.0
  lineGeom <- Geometry.create verts
  meshLineA <- createMeshLine lineGeom
  meshLine <- Object3D.getGeometry meshLineA
  meshLineMat <- createMeshLineMaterial {color: 0x000000, lineWidth: 0.01, sizeAttenuation: false}
  lineMesh <- Object3D.createMesh meshLine meshLineMat
  Scene.addObject scene lineMesh

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

------------------------
-- Orbit Controls FFI --
------------------------

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

------------------
-- MeshLine FFI --
------------------

foreign import data MeshLine :: Type
foreign import data MeshLineMaterial :: Type

newMeshLine :: Effect MeshLine
newMeshLine = ThreeUtil.ffi [""] "new MeshLine.MeshLine()"

setMeshLineGeometry :: MeshLine -> Geometry -> Effect Unit
setMeshLineGeometry =
  ThreeUtil.fpi
    ["meshline", "geom", ""]
    "meshline.setGeometry(geom)"

createMeshLine :: Geometry -> Effect MeshLine
createMeshLine geom = do
  meshline <- newMeshLine
  setMeshLineGeometry meshline geom
  pure meshline

createMeshLineMaterial :: forall opt. {|opt} -> Effect MeshLineMaterial
createMeshLineMaterial =
  ThreeUtil.ffi ["param", ""] "new MeshLine.MeshLineMaterial(param)"

instance materalMeshLine :: Material.Material MeshLineMaterial
instance renderableMeshLine :: Object3D.Renderable MeshLine
