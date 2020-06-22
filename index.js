global.THREE = require('three');

global.MeshLine = require('three.meshline');

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
