"use strict";

const meshline = require('three.meshline');

exports.create_ = () =>
    new meshline.MeshLine();

exports.setGeometry = meshlineInstance => geometry => () =>
    meshlineInstance.setGeometry(geometry);

exports.createMaterial = params => () =>
    new meshline.MeshLineMaterial(params);
