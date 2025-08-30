// Compiles a dart2wasm-generated main module from `source` which can then
// instantiatable via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm modules from `bytes` which is then
// instantiatable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export async function instantiate(modulePromise, importObjectPromise) {
  var moduleOrCompiledApp = await modulePromise;
  if (!(moduleOrCompiledApp instanceof CompiledApp)) {
    moduleOrCompiledApp = new CompiledApp(moduleOrCompiledApp);
  }
  const instantiatedApp = await moduleOrCompiledApp.instantiate(await importObjectPromise);
  return instantiatedApp.instantiatedModule;
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredWasm` is a JS function that takes a module name matching a
  //   wasm file produced by the dart2wasm compiler and returns the bytes to
  //   load the module. These bytes can be in either a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`.
  // `loadDynamicModule` is a JS function that takes two string names matching,
  //   in order, a wasm file produced by the dart2wasm compiler during dynamic
  //   module compilation and a corresponding js file produced by the same
  //   compilation. It should return a JS Array containing 2 elements. The first
  //   should be the bytes for the wasm module in a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`. The second
  //   should be the result of using the JS 'import' API on the js file path.
  async instantiate(additionalImports, {loadDeferredWasm, loadDynamicModule} = {}) {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + value;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {
            _3: (o, t) => typeof o === t,
      _4: (o, c) => o instanceof c,
      _7: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._7(f,arguments.length,x0) }),
      _8: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._8(f,arguments.length,x0,x1) }),
      _37: x0 => new Array(x0),
      _39: x0 => x0.length,
      _41: (x0,x1) => x0[x1],
      _42: (x0,x1,x2) => { x0[x1] = x2 },
      _43: x0 => new Promise(x0),
      _45: (x0,x1,x2) => new DataView(x0,x1,x2),
      _47: x0 => new Int8Array(x0),
      _48: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      _49: x0 => new Uint8Array(x0),
      _51: x0 => new Uint8ClampedArray(x0),
      _53: x0 => new Int16Array(x0),
      _55: x0 => new Uint16Array(x0),
      _57: x0 => new Int32Array(x0),
      _59: x0 => new Uint32Array(x0),
      _61: x0 => new Float32Array(x0),
      _63: x0 => new Float64Array(x0),
      _65: (x0,x1,x2) => x0.call(x1,x2),
      _70: (decoder, codeUnits) => decoder.decode(codeUnits),
      _71: () => new TextDecoder("utf-8", {fatal: true}),
      _72: () => new TextDecoder("utf-8", {fatal: false}),
      _73: (s) => +s,
      _74: x0 => new Uint8Array(x0),
      _75: (x0,x1,x2) => x0.set(x1,x2),
      _76: (x0,x1) => x0.transferFromImageBitmap(x1),
      _78: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._78(f,arguments.length,x0) }),
      _79: x0 => new window.FinalizationRegistry(x0),
      _80: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _81: (x0,x1) => x0.unregister(x1),
      _82: (x0,x1,x2) => x0.slice(x1,x2),
      _83: (x0,x1) => x0.decode(x1),
      _84: (x0,x1) => x0.segment(x1),
      _85: () => new TextDecoder(),
      _87: x0 => x0.click(),
      _88: x0 => x0.buffer,
      _89: x0 => x0.wasmMemory,
      _90: () => globalThis.window._flutter_skwasmInstance,
      _91: x0 => x0.rasterStartMilliseconds,
      _92: x0 => x0.rasterEndMilliseconds,
      _93: x0 => x0.imageBitmaps,
      _120: x0 => x0.remove(),
      _121: (x0,x1) => x0.append(x1),
      _122: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _123: (x0,x1) => x0.querySelector(x1),
      _125: (x0,x1) => x0.removeChild(x1),
      _203: x0 => x0.stopPropagation(),
      _204: x0 => x0.preventDefault(),
      _206: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _251: x0 => x0.unlock(),
      _252: x0 => x0.getReader(),
      _253: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _254: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _255: (x0,x1) => x0.item(x1),
      _256: x0 => x0.next(),
      _257: x0 => x0.now(),
      _258: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._258(f,arguments.length,x0) }),
      _259: (x0,x1) => x0.addListener(x1),
      _260: (x0,x1) => x0.removeListener(x1),
      _261: (x0,x1) => x0.matchMedia(x1),
      _262: (x0,x1) => x0.revokeObjectURL(x1),
      _263: x0 => x0.close(),
      _264: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      _265: x0 => new window.ImageDecoder(x0),
      _266: x0 => ({frameIndex: x0}),
      _267: (x0,x1) => x0.decode(x1),
      _268: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._268(f,arguments.length,x0) }),
      _269: (x0,x1) => x0.getModifierState(x1),
      _270: (x0,x1) => x0.removeProperty(x1),
      _271: (x0,x1) => x0.prepend(x1),
      _272: x0 => x0.disconnect(),
      _273: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._273(f,arguments.length,x0) }),
      _274: (x0,x1) => x0.getAttribute(x1),
      _275: (x0,x1) => x0.contains(x1),
      _276: x0 => x0.blur(),
      _277: x0 => x0.hasFocus(),
      _278: (x0,x1) => x0.hasAttribute(x1),
      _279: (x0,x1) => x0.getModifierState(x1),
      _280: (x0,x1) => x0.appendChild(x1),
      _281: (x0,x1) => x0.createTextNode(x1),
      _282: (x0,x1) => x0.removeAttribute(x1),
      _283: x0 => x0.getBoundingClientRect(),
      _284: (x0,x1) => x0.observe(x1),
      _285: x0 => x0.disconnect(),
      _286: (x0,x1) => x0.closest(x1),
      _696: () => globalThis.window.flutterConfiguration,
      _697: x0 => x0.assetBase,
      _703: x0 => x0.debugShowSemanticsNodes,
      _704: x0 => x0.hostElement,
      _705: x0 => x0.multiViewEnabled,
      _706: x0 => x0.nonce,
      _708: x0 => x0.fontFallbackBaseUrl,
      _712: x0 => x0.console,
      _713: x0 => x0.devicePixelRatio,
      _714: x0 => x0.document,
      _715: x0 => x0.history,
      _716: x0 => x0.innerHeight,
      _717: x0 => x0.innerWidth,
      _718: x0 => x0.location,
      _719: x0 => x0.navigator,
      _720: x0 => x0.visualViewport,
      _721: x0 => x0.performance,
      _723: x0 => x0.URL,
      _725: (x0,x1) => x0.getComputedStyle(x1),
      _726: x0 => x0.screen,
      _727: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._727(f,arguments.length,x0) }),
      _728: (x0,x1) => x0.requestAnimationFrame(x1),
      _733: (x0,x1) => x0.warn(x1),
      _736: x0 => globalThis.parseFloat(x0),
      _737: () => globalThis.window,
      _738: () => globalThis.Intl,
      _739: () => globalThis.Symbol,
      _740: (x0,x1,x2,x3,x4) => globalThis.createImageBitmap(x0,x1,x2,x3,x4),
      _742: x0 => x0.clipboard,
      _743: x0 => x0.maxTouchPoints,
      _744: x0 => x0.vendor,
      _745: x0 => x0.language,
      _746: x0 => x0.platform,
      _747: x0 => x0.userAgent,
      _748: (x0,x1) => x0.vibrate(x1),
      _749: x0 => x0.languages,
      _750: x0 => x0.documentElement,
      _751: (x0,x1) => x0.querySelector(x1),
      _754: (x0,x1) => x0.createElement(x1),
      _757: (x0,x1) => x0.createEvent(x1),
      _758: x0 => x0.activeElement,
      _761: x0 => x0.head,
      _762: x0 => x0.body,
      _764: (x0,x1) => { x0.title = x1 },
      _767: x0 => x0.visibilityState,
      _768: () => globalThis.document,
      _769: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._769(f,arguments.length,x0) }),
      _770: (x0,x1) => x0.dispatchEvent(x1),
      _778: x0 => x0.target,
      _780: x0 => x0.timeStamp,
      _781: x0 => x0.type,
      _783: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      _790: x0 => x0.firstChild,
      _794: x0 => x0.parentElement,
      _796: (x0,x1) => { x0.textContent = x1 },
      _797: x0 => x0.parentNode,
      _799: x0 => x0.isConnected,
      _803: x0 => x0.firstElementChild,
      _805: x0 => x0.nextElementSibling,
      _806: x0 => x0.clientHeight,
      _807: x0 => x0.clientWidth,
      _808: x0 => x0.offsetHeight,
      _809: x0 => x0.offsetWidth,
      _810: x0 => x0.id,
      _811: (x0,x1) => { x0.id = x1 },
      _814: (x0,x1) => { x0.spellcheck = x1 },
      _815: x0 => x0.tagName,
      _816: x0 => x0.style,
      _818: (x0,x1) => x0.querySelectorAll(x1),
      _819: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _820: x0 => x0.tabIndex,
      _821: (x0,x1) => { x0.tabIndex = x1 },
      _822: (x0,x1) => x0.focus(x1),
      _823: x0 => x0.scrollTop,
      _824: (x0,x1) => { x0.scrollTop = x1 },
      _825: x0 => x0.scrollLeft,
      _826: (x0,x1) => { x0.scrollLeft = x1 },
      _827: x0 => x0.classList,
      _829: (x0,x1) => { x0.className = x1 },
      _831: (x0,x1) => x0.getElementsByClassName(x1),
      _832: (x0,x1) => x0.attachShadow(x1),
      _835: x0 => x0.computedStyleMap(),
      _836: (x0,x1) => x0.get(x1),
      _842: (x0,x1) => x0.getPropertyValue(x1),
      _843: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      _844: x0 => x0.offsetLeft,
      _845: x0 => x0.offsetTop,
      _846: x0 => x0.offsetParent,
      _848: (x0,x1) => { x0.name = x1 },
      _849: x0 => x0.content,
      _850: (x0,x1) => { x0.content = x1 },
      _854: (x0,x1) => { x0.src = x1 },
      _855: x0 => x0.naturalWidth,
      _856: x0 => x0.naturalHeight,
      _860: (x0,x1) => { x0.crossOrigin = x1 },
      _862: (x0,x1) => { x0.decoding = x1 },
      _863: x0 => x0.decode(),
      _868: (x0,x1) => { x0.nonce = x1 },
      _873: (x0,x1) => { x0.width = x1 },
      _875: (x0,x1) => { x0.height = x1 },
      _878: (x0,x1) => x0.getContext(x1),
      _940: (x0,x1) => x0.fetch(x1),
      _941: x0 => x0.status,
      _943: x0 => x0.body,
      _944: x0 => x0.arrayBuffer(),
      _947: x0 => x0.read(),
      _948: x0 => x0.value,
      _949: x0 => x0.done,
      _951: x0 => x0.name,
      _952: x0 => x0.x,
      _953: x0 => x0.y,
      _956: x0 => x0.top,
      _957: x0 => x0.right,
      _958: x0 => x0.bottom,
      _959: x0 => x0.left,
      _971: x0 => x0.height,
      _972: x0 => x0.width,
      _973: x0 => x0.scale,
      _974: (x0,x1) => { x0.value = x1 },
      _977: (x0,x1) => { x0.placeholder = x1 },
      _979: (x0,x1) => { x0.name = x1 },
      _980: x0 => x0.selectionDirection,
      _981: x0 => x0.selectionStart,
      _982: x0 => x0.selectionEnd,
      _985: x0 => x0.value,
      _987: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _988: x0 => x0.readText(),
      _989: (x0,x1) => x0.writeText(x1),
      _991: x0 => x0.altKey,
      _992: x0 => x0.code,
      _993: x0 => x0.ctrlKey,
      _994: x0 => x0.key,
      _995: x0 => x0.keyCode,
      _996: x0 => x0.location,
      _997: x0 => x0.metaKey,
      _998: x0 => x0.repeat,
      _999: x0 => x0.shiftKey,
      _1000: x0 => x0.isComposing,
      _1002: x0 => x0.state,
      _1003: (x0,x1) => x0.go(x1),
      _1005: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      _1006: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _1007: x0 => x0.pathname,
      _1008: x0 => x0.search,
      _1009: x0 => x0.hash,
      _1013: x0 => x0.state,
      _1016: (x0,x1) => x0.createObjectURL(x1),
      _1018: x0 => new Blob(x0),
      _1020: x0 => new MutationObserver(x0),
      _1021: (x0,x1,x2) => x0.observe(x1,x2),
      _1022: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1022(f,arguments.length,x0,x1) }),
      _1025: x0 => x0.attributeName,
      _1026: x0 => x0.type,
      _1027: x0 => x0.matches,
      _1028: x0 => x0.matches,
      _1032: x0 => x0.relatedTarget,
      _1034: x0 => x0.clientX,
      _1035: x0 => x0.clientY,
      _1036: x0 => x0.offsetX,
      _1037: x0 => x0.offsetY,
      _1040: x0 => x0.button,
      _1041: x0 => x0.buttons,
      _1042: x0 => x0.ctrlKey,
      _1046: x0 => x0.pointerId,
      _1047: x0 => x0.pointerType,
      _1048: x0 => x0.pressure,
      _1049: x0 => x0.tiltX,
      _1050: x0 => x0.tiltY,
      _1051: x0 => x0.getCoalescedEvents(),
      _1054: x0 => x0.deltaX,
      _1055: x0 => x0.deltaY,
      _1056: x0 => x0.wheelDeltaX,
      _1057: x0 => x0.wheelDeltaY,
      _1058: x0 => x0.deltaMode,
      _1065: x0 => x0.changedTouches,
      _1068: x0 => x0.clientX,
      _1069: x0 => x0.clientY,
      _1072: x0 => x0.data,
      _1075: (x0,x1) => { x0.disabled = x1 },
      _1077: (x0,x1) => { x0.type = x1 },
      _1078: (x0,x1) => { x0.max = x1 },
      _1079: (x0,x1) => { x0.min = x1 },
      _1080: x0 => x0.value,
      _1081: (x0,x1) => { x0.value = x1 },
      _1082: x0 => x0.disabled,
      _1083: (x0,x1) => { x0.disabled = x1 },
      _1085: (x0,x1) => { x0.placeholder = x1 },
      _1087: (x0,x1) => { x0.name = x1 },
      _1089: (x0,x1) => { x0.autocomplete = x1 },
      _1090: x0 => x0.selectionDirection,
      _1092: x0 => x0.selectionStart,
      _1093: x0 => x0.selectionEnd,
      _1096: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1097: (x0,x1) => x0.add(x1),
      _1100: (x0,x1) => { x0.noValidate = x1 },
      _1101: (x0,x1) => { x0.method = x1 },
      _1102: (x0,x1) => { x0.action = x1 },
      _1128: x0 => x0.orientation,
      _1129: x0 => x0.width,
      _1130: x0 => x0.height,
      _1131: (x0,x1) => x0.lock(x1),
      _1150: x0 => new ResizeObserver(x0),
      _1153: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1153(f,arguments.length,x0,x1) }),
      _1161: x0 => x0.length,
      _1162: x0 => x0.iterator,
      _1163: x0 => x0.Segmenter,
      _1164: x0 => x0.v8BreakIterator,
      _1165: (x0,x1) => new Intl.Segmenter(x0,x1),
      _1166: x0 => x0.done,
      _1167: x0 => x0.value,
      _1168: x0 => x0.index,
      _1172: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      _1173: (x0,x1) => x0.adoptText(x1),
      _1174: x0 => x0.first(),
      _1175: x0 => x0.next(),
      _1176: x0 => x0.current(),
      _1182: x0 => x0.hostElement,
      _1183: x0 => x0.viewConstraints,
      _1186: x0 => x0.maxHeight,
      _1187: x0 => x0.maxWidth,
      _1188: x0 => x0.minHeight,
      _1189: x0 => x0.minWidth,
      _1190: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1190(f,arguments.length,x0) }),
      _1191: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1191(f,arguments.length,x0) }),
      _1192: (x0,x1) => ({addView: x0,removeView: x1}),
      _1193: x0 => x0.loader,
      _1194: () => globalThis._flutter,
      _1195: (x0,x1) => x0.didCreateEngineInitializer(x1),
      _1196: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1196(f,arguments.length,x0) }),
      _1197: f => finalizeWrapper(f, function() { return dartInstance.exports._1197(f,arguments.length) }),
      _1198: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      _1199: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1199(f,arguments.length,x0) }),
      _1200: x0 => ({runApp: x0}),
      _1201: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1201(f,arguments.length,x0,x1) }),
      _1202: x0 => x0.length,
      _1203: () => globalThis.window.ImageDecoder,
      _1204: x0 => x0.tracks,
      _1206: x0 => x0.completed,
      _1208: x0 => x0.image,
      _1214: x0 => x0.displayWidth,
      _1215: x0 => x0.displayHeight,
      _1216: x0 => x0.duration,
      _1219: x0 => x0.ready,
      _1220: x0 => x0.selectedTrack,
      _1221: x0 => x0.repetitionCount,
      _1222: x0 => x0.frameCount,
      _1283: x0 => x0.toArray(),
      _1284: x0 => x0.toUint8Array(),
      _1285: x0 => ({serverTimestamps: x0}),
      _1286: x0 => ({source: x0}),
      _1289: x0 => new firebase_firestore.FieldPath(x0),
      _1290: (x0,x1) => new firebase_firestore.FieldPath(x0,x1),
      _1291: (x0,x1,x2) => new firebase_firestore.FieldPath(x0,x1,x2),
      _1292: (x0,x1,x2,x3) => new firebase_firestore.FieldPath(x0,x1,x2,x3),
      _1293: (x0,x1,x2,x3,x4) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4),
      _1294: (x0,x1,x2,x3,x4,x5) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5),
      _1295: (x0,x1,x2,x3,x4,x5,x6) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6),
      _1296: (x0,x1,x2,x3,x4,x5,x6,x7) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7),
      _1297: (x0,x1,x2,x3,x4,x5,x6,x7,x8) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7,x8),
      _1298: (x0,x1,x2,x3,x4,x5,x6,x7,x8,x9) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7,x8,x9),
      _1299: () => globalThis.firebase_firestore.documentId(),
      _1300: (x0,x1) => new firebase_firestore.GeoPoint(x0,x1),
      _1301: x0 => globalThis.firebase_firestore.vector(x0),
      _1302: x0 => globalThis.firebase_firestore.Bytes.fromUint8Array(x0),
      _1304: (x0,x1) => globalThis.firebase_firestore.collection(x0,x1),
      _1306: (x0,x1) => globalThis.firebase_firestore.doc(x0,x1),
      _1309: x0 => x0.call(),
      _1338: x0 => globalThis.firebase_firestore.deleteDoc(x0),
      _1339: x0 => globalThis.firebase_firestore.getDoc(x0),
      _1340: x0 => globalThis.firebase_firestore.getDocFromServer(x0),
      _1341: x0 => globalThis.firebase_firestore.getDocFromCache(x0),
      _1342: (x0,x1) => ({includeMetadataChanges: x0,source: x1}),
      _1345: (x0,x1,x2,x3) => globalThis.firebase_firestore.onSnapshot(x0,x1,x2,x3),
      _1348: (x0,x1) => globalThis.firebase_firestore.setDoc(x0,x1),
      _1349: (x0,x1) => globalThis.firebase_firestore.query(x0,x1),
      _1353: x0 => globalThis.firebase_firestore.limit(x0),
      _1354: x0 => globalThis.firebase_firestore.limitToLast(x0),
      _1355: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1355(f,arguments.length,x0) }),
      _1356: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1356(f,arguments.length,x0) }),
      _1357: (x0,x1) => globalThis.firebase_firestore.orderBy(x0,x1),
      _1359: (x0,x1,x2) => globalThis.firebase_firestore.where(x0,x1,x2),
      _1365: (x0,x1) => x0.data(x1),
      _1369: x0 => x0.docChanges(),
      _1386: (x0,x1) => globalThis.firebase_firestore.getFirestore(x0,x1),
      _1388: x0 => globalThis.firebase_firestore.Timestamp.fromMillis(x0),
      _1389: f => finalizeWrapper(f, function() { return dartInstance.exports._1389(f,arguments.length) }),
      _1407: () => globalThis.firebase_firestore.or,
      _1408: () => globalThis.firebase_firestore.and,
      _1413: x0 => x0.path,
      _1416: () => globalThis.firebase_firestore.GeoPoint,
      _1417: x0 => x0.latitude,
      _1418: x0 => x0.longitude,
      _1420: () => globalThis.firebase_firestore.VectorValue,
      _1421: () => globalThis.firebase_firestore.Bytes,
      _1424: x0 => x0.type,
      _1426: x0 => x0.doc,
      _1428: x0 => x0.oldIndex,
      _1430: x0 => x0.newIndex,
      _1432: () => globalThis.firebase_firestore.DocumentReference,
      _1436: x0 => x0.path,
      _1445: x0 => x0.metadata,
      _1446: x0 => x0.ref,
      _1451: x0 => x0.docs,
      _1453: x0 => x0.metadata,
      _1457: () => globalThis.firebase_firestore.Timestamp,
      _1458: x0 => x0.seconds,
      _1459: x0 => x0.nanoseconds,
      _1495: x0 => x0.hasPendingWrites,
      _1497: x0 => x0.fromCache,
      _1504: x0 => x0.source,
      _1509: () => globalThis.firebase_firestore.startAfter,
      _1510: () => globalThis.firebase_firestore.startAt,
      _1511: () => globalThis.firebase_firestore.endBefore,
      _1512: () => globalThis.firebase_firestore.endAt,
      _1544: x0 => x0.toJSON(),
      _1545: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1545(f,arguments.length,x0) }),
      _1546: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1546(f,arguments.length,x0) }),
      _1547: (x0,x1,x2) => x0.onAuthStateChanged(x1,x2),
      _1548: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1548(f,arguments.length,x0) }),
      _1549: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1549(f,arguments.length,x0) }),
      _1550: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1550(f,arguments.length,x0) }),
      _1551: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1551(f,arguments.length,x0) }),
      _1552: (x0,x1,x2) => x0.onIdTokenChanged(x1,x2),
      _1566: (x0,x1,x2) => globalThis.firebase_auth.signInWithEmailAndPassword(x0,x1,x2),
      _1571: x0 => x0.signOut(),
      _1572: (x0,x1) => globalThis.firebase_auth.connectAuthEmulator(x0,x1),
      _1595: x0 => globalThis.firebase_auth.OAuthProvider.credentialFromResult(x0),
      _1610: x0 => globalThis.firebase_auth.getAdditionalUserInfo(x0),
      _1611: (x0,x1,x2) => ({errorMap: x0,persistence: x1,popupRedirectResolver: x2}),
      _1612: (x0,x1) => globalThis.firebase_auth.initializeAuth(x0,x1),
      _1618: x0 => globalThis.firebase_auth.OAuthProvider.credentialFromError(x0),
      _1633: () => globalThis.firebase_auth.debugErrorMap,
      _1636: () => globalThis.firebase_auth.browserSessionPersistence,
      _1638: () => globalThis.firebase_auth.browserLocalPersistence,
      _1640: () => globalThis.firebase_auth.indexedDBLocalPersistence,
      _1643: x0 => globalThis.firebase_auth.multiFactor(x0),
      _1644: (x0,x1) => globalThis.firebase_auth.getMultiFactorResolver(x0,x1),
      _1646: x0 => x0.currentUser,
      _1660: x0 => x0.displayName,
      _1661: x0 => x0.email,
      _1662: x0 => x0.phoneNumber,
      _1663: x0 => x0.photoURL,
      _1664: x0 => x0.providerId,
      _1665: x0 => x0.uid,
      _1666: x0 => x0.emailVerified,
      _1667: x0 => x0.isAnonymous,
      _1668: x0 => x0.providerData,
      _1669: x0 => x0.refreshToken,
      _1670: x0 => x0.tenantId,
      _1671: x0 => x0.metadata,
      _1673: x0 => x0.providerId,
      _1674: x0 => x0.signInMethod,
      _1675: x0 => x0.accessToken,
      _1676: x0 => x0.idToken,
      _1677: x0 => x0.secret,
      _1688: x0 => x0.creationTime,
      _1689: x0 => x0.lastSignInTime,
      _1694: x0 => x0.code,
      _1696: x0 => x0.message,
      _1708: x0 => x0.email,
      _1709: x0 => x0.phoneNumber,
      _1710: x0 => x0.tenantId,
      _1733: x0 => x0.user,
      _1736: x0 => x0.providerId,
      _1737: x0 => x0.profile,
      _1738: x0 => x0.username,
      _1739: x0 => x0.isNewUser,
      _1742: () => globalThis.firebase_auth.browserPopupRedirectResolver,
      _1747: x0 => x0.displayName,
      _1748: x0 => x0.enrollmentTime,
      _1749: x0 => x0.factorId,
      _1750: x0 => x0.uid,
      _1752: x0 => x0.hints,
      _1753: x0 => x0.session,
      _1755: x0 => x0.phoneNumber,
      _1767: (x0,x1) => x0.getItem(x1),
      _1772: x0 => x0.remove(),
      _1773: (x0,x1) => x0.createElement(x1),
      _1774: (x0,x1) => x0.appendChild(x1),
      _1777: (x0,x1,x2,x3,x4,x5,x6,x7) => ({apiKey: x0,authDomain: x1,databaseURL: x2,projectId: x3,storageBucket: x4,messagingSenderId: x5,measurementId: x6,appId: x7}),
      _1778: (x0,x1) => globalThis.firebase_core.initializeApp(x0,x1),
      _1779: x0 => globalThis.firebase_core.getApp(x0),
      _1780: () => globalThis.firebase_core.getApp(),
      _1782: () => globalThis.firebase_core.SDK_VERSION,
      _1788: x0 => x0.apiKey,
      _1790: x0 => x0.authDomain,
      _1792: x0 => x0.databaseURL,
      _1794: x0 => x0.projectId,
      _1796: x0 => x0.storageBucket,
      _1798: x0 => x0.messagingSenderId,
      _1800: x0 => x0.measurementId,
      _1802: x0 => x0.appId,
      _1804: x0 => x0.name,
      _1805: x0 => x0.options,
      _1806: (x0,x1) => x0.debug(x1),
      _1807: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1807(f,arguments.length,x0) }),
      _1808: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1808(f,arguments.length,x0,x1) }),
      _1809: (x0,x1) => ({createScript: x0,createScriptURL: x1}),
      _1810: (x0,x1,x2) => x0.createPolicy(x1,x2),
      _1811: (x0,x1) => x0.createScriptURL(x1),
      _1812: (x0,x1,x2) => x0.createScript(x1,x2),
      _1813: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1813(f,arguments.length,x0) }),
      _1814: () => globalThis.removeSplashFromWeb(),
      _1816: Date.now,
      _1818: s => new Date(s * 1000).getTimezoneOffset() * 60,
      _1819: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      _1820: () => {
        let stackString = new Error().stack.toString();
        let frames = stackString.split('\n');
        let drop = 2;
        if (frames[0] === 'Error') {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      _1821: () => typeof dartUseDateNowForTicks !== "undefined",
      _1822: () => 1000 * performance.now(),
      _1823: () => Date.now(),
      _1826: () => new WeakMap(),
      _1827: (map, o) => map.get(o),
      _1828: (map, o, v) => map.set(o, v),
      _1829: x0 => new WeakRef(x0),
      _1830: x0 => x0.deref(),
      _1837: () => globalThis.WeakRef,
      _1840: s => JSON.stringify(s),
      _1841: s => printToConsole(s),
      _1842: (o, p, r) => o.replaceAll(p, () => r),
      _1843: (o, p, r) => o.replace(p, () => r),
      _1844: Function.prototype.call.bind(String.prototype.toLowerCase),
      _1845: s => s.toUpperCase(),
      _1846: s => s.trim(),
      _1847: s => s.trimLeft(),
      _1848: s => s.trimRight(),
      _1849: (string, times) => string.repeat(times),
      _1850: Function.prototype.call.bind(String.prototype.indexOf),
      _1851: (s, p, i) => s.lastIndexOf(p, i),
      _1852: (string, token) => string.split(token),
      _1853: Object.is,
      _1854: o => o instanceof Array,
      _1855: (a, i) => a.push(i),
      _1859: a => a.pop(),
      _1860: (a, i) => a.splice(i, 1),
      _1861: (a, s) => a.join(s),
      _1862: (a, s, e) => a.slice(s, e),
      _1865: a => a.length,
      _1867: (a, i) => a[i],
      _1868: (a, i, v) => a[i] = v,
      _1870: o => {
        if (o instanceof ArrayBuffer) return 0;
        if (globalThis.SharedArrayBuffer !== undefined &&
            o instanceof SharedArrayBuffer) {
          return 1;
        }
        return 2;
      },
      _1871: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      _1873: o => o instanceof Uint8Array,
      _1874: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      _1875: o => o instanceof Int8Array,
      _1876: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      _1877: o => o instanceof Uint8ClampedArray,
      _1878: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      _1879: o => o instanceof Uint16Array,
      _1880: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      _1881: o => o instanceof Int16Array,
      _1882: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      _1883: o => o instanceof Uint32Array,
      _1884: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      _1885: o => o instanceof Int32Array,
      _1886: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      _1888: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      _1889: o => o instanceof Float32Array,
      _1890: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      _1891: o => o instanceof Float64Array,
      _1892: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      _1893: (t, s) => t.set(s),
      _1894: l => new DataView(new ArrayBuffer(l)),
      _1895: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      _1896: o => o.byteLength,
      _1897: o => o.buffer,
      _1898: o => o.byteOffset,
      _1899: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      _1900: (b, o) => new DataView(b, o),
      _1901: (b, o, l) => new DataView(b, o, l),
      _1902: Function.prototype.call.bind(DataView.prototype.getUint8),
      _1903: Function.prototype.call.bind(DataView.prototype.setUint8),
      _1904: Function.prototype.call.bind(DataView.prototype.getInt8),
      _1905: Function.prototype.call.bind(DataView.prototype.setInt8),
      _1906: Function.prototype.call.bind(DataView.prototype.getUint16),
      _1907: Function.prototype.call.bind(DataView.prototype.setUint16),
      _1908: Function.prototype.call.bind(DataView.prototype.getInt16),
      _1909: Function.prototype.call.bind(DataView.prototype.setInt16),
      _1910: Function.prototype.call.bind(DataView.prototype.getUint32),
      _1911: Function.prototype.call.bind(DataView.prototype.setUint32),
      _1912: Function.prototype.call.bind(DataView.prototype.getInt32),
      _1913: Function.prototype.call.bind(DataView.prototype.setInt32),
      _1916: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      _1917: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      _1918: Function.prototype.call.bind(DataView.prototype.getFloat32),
      _1919: Function.prototype.call.bind(DataView.prototype.setFloat32),
      _1920: Function.prototype.call.bind(DataView.prototype.getFloat64),
      _1921: Function.prototype.call.bind(DataView.prototype.setFloat64),
      _1922: x0 => ({type: x0}),
      _1923: (x0,x1) => new Blob(x0,x1),
      _1924: x0 => globalThis.URL.createObjectURL(x0),
      _1925: (x0,x1) => x0.append(x1),
      _1926: x0 => x0.click(),
      _1927: x0 => globalThis.URL.revokeObjectURL(x0),
      _1940: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      _1941: (handle) => clearTimeout(handle),
      _1942: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      _1943: (handle) => clearInterval(handle),
      _1944: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      _1945: () => Date.now(),
      _1950: o => Object.keys(o),
      _1951: (x0,x1,x2) => x0.transaction(x1,x2),
      _1952: (x0,x1) => x0.objectStore(x1),
      _1953: (x0,x1) => x0.getAllKeys(x1),
      _1954: (x0,x1) => x0.getAll(x1),
      _1956: (x0,x1) => x0.delete(x1),
      _1957: (x0,x1,x2) => x0.put(x1,x2),
      _1958: x0 => x0.clear(),
      _1959: x0 => x0.close(),
      _1961: (x0,x1,x2) => x0.open(x1,x2),
      _1962: (x0,x1) => x0.contains(x1),
      _1965: (x0,x1) => x0.createObjectStore(x1),
      _1966: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1966(f,arguments.length,x0) }),
      _1967: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1967(f,arguments.length,x0) }),
      _1976: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1976(f,arguments.length,x0) }),
      _1977: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1977(f,arguments.length,x0) }),
      _1978: x0 => x0.openCursor(),
      _1979: x0 => x0.continue(),
      _1980: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1980(f,arguments.length,x0) }),
      _1981: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1981(f,arguments.length,x0) }),
      _2009: x0 => x0.trustedTypes,
      _2010: (x0,x1) => { x0.text = x1 },
      _2021: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      _2022: (x0,x1) => x0.exec(x1),
      _2023: (x0,x1) => x0.test(x1),
      _2024: x0 => x0.pop(),
      _2026: o => o === undefined,
      _2028: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      _2030: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      _2031: o => o instanceof RegExp,
      _2032: (l, r) => l === r,
      _2033: o => o,
      _2034: o => o,
      _2035: o => o,
      _2036: b => !!b,
      _2037: o => o.length,
      _2039: (o, i) => o[i],
      _2040: f => f.dartFunction,
      _2041: () => ({}),
      _2042: () => [],
      _2044: () => globalThis,
      _2045: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      _2047: (o, p) => o[p],
      _2048: (o, p, v) => o[p] = v,
      _2049: (o, m, a) => o[m].apply(o, a),
      _2051: o => String(o),
      _2052: (p, s, f) => p.then(s, (e) => f(e, e === undefined)),
      _2053: o => {
        if (o === undefined) return 1;
        var type = typeof o;
        if (type === 'boolean') return 2;
        if (type === 'number') return 3;
        if (type === 'string') return 4;
        if (o instanceof Array) return 5;
        if (ArrayBuffer.isView(o)) {
          if (o instanceof Int8Array) return 6;
          if (o instanceof Uint8Array) return 7;
          if (o instanceof Uint8ClampedArray) return 8;
          if (o instanceof Int16Array) return 9;
          if (o instanceof Uint16Array) return 10;
          if (o instanceof Int32Array) return 11;
          if (o instanceof Uint32Array) return 12;
          if (o instanceof Float32Array) return 13;
          if (o instanceof Float64Array) return 14;
          if (o instanceof DataView) return 15;
        }
        if (o instanceof ArrayBuffer) return 16;
        // Feature check for `SharedArrayBuffer` before doing a type-check.
        if (globalThis.SharedArrayBuffer !== undefined &&
            o instanceof SharedArrayBuffer) {
            return 17;
        }
        return 18;
      },
      _2054: o => [o],
      _2055: (o0, o1) => [o0, o1],
      _2056: (o0, o1, o2) => [o0, o1, o2],
      _2057: (o0, o1, o2, o3) => [o0, o1, o2, o3],
      _2058: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2059: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2060: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI16ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2061: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI16ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2062: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2063: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2064: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2065: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2066: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2067: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2068: x0 => new ArrayBuffer(x0),
      _2069: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      _2071: x0 => x0.index,
      _2073: x0 => x0.flags,
      _2074: x0 => x0.multiline,
      _2075: x0 => x0.ignoreCase,
      _2076: x0 => x0.unicode,
      _2077: x0 => x0.dotAll,
      _2078: (x0,x1) => { x0.lastIndex = x1 },
      _2079: (o, p) => p in o,
      _2080: (o, p) => o[p],
      _2081: (o, p, v) => o[p] = v,
      _2082: (o, p) => delete o[p],
      _2083: x0 => x0.random(),
      _2084: (x0,x1) => x0.getRandomValues(x1),
      _2085: () => globalThis.crypto,
      _2086: () => globalThis.Math,
      _2087: Function.prototype.call.bind(Number.prototype.toString),
      _2088: Function.prototype.call.bind(BigInt.prototype.toString),
      _2089: Function.prototype.call.bind(Number.prototype.toString),
      _2090: (d, digits) => d.toFixed(digits),
      _2261: x0 => x0.style,
      _2620: (x0,x1) => { x0.download = x1 },
      _2645: (x0,x1) => { x0.href = x1 },
      _3500: (x0,x1) => { x0.type = x1 },
      _3508: (x0,x1) => { x0.crossOrigin = x1 },
      _3510: (x0,x1) => { x0.text = x1 },
      _3967: () => globalThis.window,
      _4007: x0 => x0.self,
      _4011: x0 => x0.location,
      _4287: x0 => x0.indexedDB,
      _4292: x0 => x0.trustedTypes,
      _4293: x0 => x0.sessionStorage,
      _4309: x0 => x0.hostname,
      _6534: x0 => x0.target,
      _6648: () => globalThis.document,
      _6729: x0 => x0.body,
      _6731: x0 => x0.head,
      _10576: x0 => x0.result,
      _10577: x0 => x0.error,
      _10582: (x0,x1) => { x0.onsuccess = x1 },
      _10584: (x0,x1) => { x0.onerror = x1 },
      _10588: (x0,x1) => { x0.onupgradeneeded = x1 },
      _10606: x0 => x0.version,
      _10607: x0 => x0.objectStoreNames,
      _10674: x0 => x0.key,
      _10677: x0 => x0.value,
      _11515: (x0,x1) => { x0.display = x1 },
      _13453: () => globalThis.console,
      _13481: x0 => x0.name,
      _13482: x0 => x0.message,
      _13483: x0 => x0.code,
      _13485: x0 => x0.customData,

    };

    const baseImports = {
      dart2wasm: dart2wasm,
      Math: Math,
      Date: Date,
      Object: Object,
      Array: Array,
      Reflect: Reflect,
      S: new Proxy({}, { get(_, prop) { return prop; } }),

    };

    const jsStringPolyfill = {
      "charCodeAt": (s, i) => s.charCodeAt(i),
      "compare": (s1, s2) => {
        if (s1 < s2) return -1;
        if (s1 > s2) return 1;
        return 0;
      },
      "concat": (s1, s2) => s1 + s2,
      "equals": (s1, s2) => s1 === s2,
      "fromCharCode": (i) => String.fromCharCode(i),
      "length": (s) => s.length,
      "substring": (s, a, b) => s.substring(a, b),
      "fromCharCodeArray": (a, start, end) => {
        if (end <= start) return '';

        const read = dartInstance.exports.$wasmI16ArrayGet;
        let result = '';
        let index = start;
        const chunkLength = Math.min(end - index, 500);
        let array = new Array(chunkLength);
        while (index < end) {
          const newChunkLength = Math.min(end - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(a, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
      "intoCharCodeArray": (s, a, start) => {
        if (s === '') return 0;

        const write = dartInstance.exports.$wasmI16ArraySet;
        for (var i = 0; i < s.length; ++i) {
          write(a, start++, s.charCodeAt(i));
        }
        return s.length;
      },
      "test": (s) => typeof s == "string",
    };


    

    dartInstance = await WebAssembly.instantiate(this.module, {
      ...baseImports,
      ...additionalImports,
      
      "wasm:js-string": jsStringPolyfill,
    });

    return new InstantiatedApp(this, dartInstance);
  }
}

class InstantiatedApp {
  constructor(compiledApp, instantiatedModule) {
    this.compiledApp = compiledApp;
    this.instantiatedModule = instantiatedModule;
  }

  // Call the main function with the given arguments.
  invokeMain(...args) {
    this.instantiatedModule.exports.$invokeMain(args);
  }
}
