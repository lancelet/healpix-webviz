parcelRequire=function(e,r,t,n){var i,o="function"==typeof parcelRequire&&parcelRequire,u="function"==typeof require&&require;function f(t,n){if(!r[t]){if(!e[t]){var i="function"==typeof parcelRequire&&parcelRequire;if(!n&&i)return i(t,!0);if(o)return o(t,!0);if(u&&"string"==typeof t)return u(t);var c=new Error("Cannot find module '"+t+"'");throw c.code="MODULE_NOT_FOUND",c}p.resolve=function(r){return e[t][1][r]||r},p.cache={};var l=r[t]=new f.Module(t);e[t][0].call(l.exports,p,l,l.exports,this)}return r[t].exports;function p(e){return f(p.resolve(e))}}f.isParcelRequire=!0,f.Module=function(e){this.id=e,this.bundle=f,this.exports={}},f.modules=e,f.cache=r,f.parent=o,f.register=function(r,t){e[r]=[function(e,r){r.exports=t},{}]};for(var c=0;c<t.length;c++)try{f(t[c])}catch(e){i||(i=e)}if(t.length){var l=f(t[t.length-1]);"object"==typeof exports&&"undefined"!=typeof module?module.exports=l:"function"==typeof define&&define.amd?define(function(){return l}):n&&(this[n]=l)}if(parcelRequire=f,i)throw i;return f}({"ty16":[function(require,module,exports) {
"use strict";exports.log=function(n){return function(){return console.log(n),{}}},exports.warn=function(n){return function(){return console.warn(n),{}}},exports.error=function(n){return function(){return console.error(n),{}}},exports.info=function(n){return function(){return console.info(n),{}}},exports.time=function(n){return function(){return console.time(n),{}}},exports.timeLog=function(n){return function(){return console.timeLog(n),{}}},exports.timeEnd=function(n){return function(){return console.timeEnd(n),{}}},exports.clear=function(){return console.clear(),{}};
},{}],"qgjE":[function(require,module,exports) {
"use strict";exports.showIntImpl=function(r){return r.toString()},exports.showNumberImpl=function(r){var t=r.toString();return isNaN(t+".0")?t:t+".0"},exports.showCharImpl=function(r){var t=r.charCodeAt(0);if(t<32||127===t){switch(r){case"":return"'\\a'";case"\b":return"'\\b'";case"\f":return"'\\f'";case"\n":return"'\\n'";case"\r":return"'\\r'";case"\t":return"'\\t'";case"\v":return"'\\v'"}return"'\\"+t.toString(10)+"'"}return"'"===r||"\\"===r?"'\\"+r+"'":"'"+r+"'"},exports.showStringImpl=function(r){var t=r.length;return'"'+r.replace(/[\0-\x1F\x7F"\\]/g,function(n,e){switch(n){case'"':case"\\":return"\\"+n;case"":return"\\a";case"\b":return"\\b";case"\f":return"\\f";case"\n":return"\\n";case"\r":return"\\r";case"\t":return"\\t";case"\v":return"\\v"}var u=e+1,c=u<t&&r[u]>="0"&&r[u]<="9"?"\\&":"";return"\\"+n.charCodeAt(0).toString(10)+c})+'"'},exports.showArrayImpl=function(r){return function(t){for(var n=[],e=0,u=t.length;e<u;e++)n[e]=r(t[e]);return"["+n.join(",")+"]"}},exports.cons=function(r){return function(t){return[r].concat(t)}},exports.join=function(r){return function(t){return t.join(r)}};
},{}],"AvJb":[function(require,module,exports) {
"use strict";exports.unsafeCoerce=function(e){return e};
},{}],"oJQL":[function(require,module,exports) {
"use strict";var e=require("./foreign.js"),n=function(){function e(){}return e.value=new e,e}(),r=function(e){this.reflectSymbol=e},t=function(r){return function(t){return e.unsafeCoerce(function(e){return t(e)})({reflectSymbol:function(e){return r}})(n.value)}},u=function(e){return e.reflectSymbol};module.exports={IsSymbol:r,reflectSymbol:u,reifySymbol:t,SProxy:n};
},{"./foreign.js":"AvJb"}],"CHMS":[function(require,module,exports) {
"use strict";exports.unsafeHas=function(n){return function(r){return{}.hasOwnProperty.call(r,n)}},exports.unsafeGet=function(n){return function(r){return r[n]}},exports.unsafeSet=function(n){return function(r){return function(t){var e={};for(var u in t)({}).hasOwnProperty.call(t,u)&&(e[u]=t[u]);return e[n]=r,e}}},exports.unsafeDelete=function(n){return function(r){var t={};for(var e in r)e!==n&&{}.hasOwnProperty.call(r,e)&&(t[e]=r[e]);return t}};
},{}],"KG04":[function(require,module,exports) {
"use strict";var e=require("./foreign.js");module.exports={unsafeHas:e.unsafeHas,unsafeGet:e.unsafeGet,unsafeSet:e.unsafeSet,unsafeDelete:e.unsafeDelete};
},{"./foreign.js":"CHMS"}],"XaXP":[function(require,module,exports) {
"use strict";var e=function(){function e(){}return e.value=new e,e}();module.exports={RLProxy:e};
},{}],"mFY7":[function(require,module,exports) {
"use strict";var n=require("./foreign.js"),e=require("../Data.Symbol/index.js"),r=require("../Record.Unsafe/index.js"),o=require("../Type.Data.RowList/index.js"),t=function(n){this.showRecordFields=n},u=function(n){this.show=n},i=new u(n.showStringImpl),s=new t(function(n){return function(n){return[]}}),w=function(n){return n.showRecordFields},c=function(e){return function(e){return new u(function(r){var t=w(e)(o.RLProxy.value)(r);return 0===t.length?"{}":n.join(" ")(["{",n.join(", ")(t),"}"])})}},h=new u(n.showNumberImpl),l=new u(n.showIntImpl),a=new u(n.showCharImpl),f=new u(function(n){if(n)return"true";if(!n)return"false";throw new Error("Failed pattern match at Data.Show (line 20, column 1 - line 22, column 23): "+[n.constructor.name])}),d=function(n){return n.show},m=function(e){return new u(n.showArrayImpl(d(e)))},R=function(u){return function(i){return function(s){return new t(function(t){return function(t){var c=w(i)(o.RLProxy.value)(t),h=e.reflectSymbol(u)(e.SProxy.value),l=r.unsafeGet(h)(t);return n.cons(n.join(": ")([h,d(s)(l)]))(c)}})}}};module.exports={Show:u,show:d,ShowRecordFields:t,showRecordFields:w,showBoolean:f,showInt:l,showNumber:h,showChar:a,showString:i,showArray:m,showRecord:c,showRecordFieldsNil:s,showRecordFieldsCons:R};
},{"./foreign.js":"qgjE","../Data.Symbol/index.js":"oJQL","../Record.Unsafe/index.js":"KG04","../Type.Data.RowList/index.js":"XaXP"}],"bpjQ":[function(require,module,exports) {
"use strict";var r=require("./foreign.js"),n=require("../Data.Show/index.js"),o=function(o){return function(e){return r.warn(n.show(o)(e))}},e=function(o){return function(e){return r.log(n.show(o)(e))}},t=function(o){return function(e){return r.info(n.show(o)(e))}},i=function(o){return function(e){return r.error(n.show(o)(e))}};module.exports={logShow:e,warnShow:o,errorShow:i,infoShow:t,log:r.log,warn:r.warn,error:r.error,info:r.info,time:r.time,timeLog:r.timeLog,timeEnd:r.timeEnd,clear:r.clear};
},{"./foreign.js":"ty16","../Data.Show/index.js":"mFY7"}],"MrQo":[function(require,module,exports) {
"use strict";var e=require("../Effect.Console/index.js"),o=e.log("🍝");module.exports={main:o};
},{"../Effect.Console/index.js":"bpjQ"}],"Focm":[function(require,module,exports) {
var n=require("./output/Main");function o(){n.main()}module.hot&&module.hot.accept(function(){console.log("Reloaded, running main again"),o()}),console.log("Starting app"),o();
},{"./output/Main":"MrQo"}]},{},["Focm"], null)
//# sourceMappingURL=/healpix-webviz.08fdf6f3.js.map