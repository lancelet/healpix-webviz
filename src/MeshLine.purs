module MeshLine where

import Prelude (Unit, bind, discard, pure)

import Effect (Effect)

import Graphics.Three.Geometry (Geometry)
import Graphics.Three.Material (class Material)
import Graphics.Three.Object3D (class Renderable)
import Graphics.Three.Math.Vector (Vector2)

foreign import data MeshLine :: Type
foreign import data MeshLineMaterial :: Type

instance renderableMeshLine :: Renderable MeshLine
instance materalMeshLine :: Material MeshLineMaterial

foreign import create_ :: Effect MeshLine

foreign import setGeometry :: MeshLine -> Geometry -> Effect Unit

create :: Geometry -> Effect MeshLine
create geometry = do
  meshlineInstance <- create_
  setGeometry meshlineInstance geometry
  pure meshlineInstance

foreign import createMaterial :: forall opt. {|opt} -> Effect MeshLineMaterial

foreign import createVec2 :: Number -> Number -> Vector2
