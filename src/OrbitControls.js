"use strict";

const moco = require('three/examples/jsm/controls/OrbitControls');

exports._create = camera => domElement => () =>
    new moco.OrbitControls(camera, domElement);

exports.update = orbitControls => () =>
    orbitControls.update();

exports.setZoomEnabled = orbitControls => enabled => () =>
    orbitControls.enableZoom = enabled;

exports.setPanEnabled = orbitControls => enabled => () =>
    orbitControls.enablePan = enabled;
