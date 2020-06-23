"use strict";

const three = require('three');

const meshline = require('threejs-meshline');

exports.create_ = () =>
    new meshline.MeshLine();

exports.setGeometry = meshlineInstance => geometry => () =>
    meshlineInstance.setGeometry(geometry);

exports.createMaterial = params => () =>
    new meshline.MeshLineMaterial(params);

exports.createVec2 = x => y =>
    new three.Vector2(x, y);
