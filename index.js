global.THREE = require('three');

import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
global.OrbitControls = OrbitControls;

var Main = require('./output/Main');

function main() {
    Main.main();
}

if (module.hot) {
    module.hot.accept(function() {
        console.log('Reloaded, running main again');
        main();
    });
}

console.log('Starting app');

main();
