module OrbitControls where

import Prelude

import Effect (Effect)

import Graphics.Three.Camera (class Camera)

import Web.DOM (Element)

foreign import data OrbitControls :: Type

foreign import _create :: forall cam. cam -> Element -> Effect OrbitControls

create ::
  forall cam. Camera cam =>
  cam ->
  Element ->
  Effect OrbitControls
create = _create

foreign import update :: OrbitControls -> Effect Unit

foreign import setZoomEnabled :: OrbitControls -> Boolean -> Effect Unit

foreign import setPanEnabled :: OrbitControls -> Boolean -> Effect Unit
