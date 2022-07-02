/**
 * Welcome to your Workbox-powered service worker!
 *
 * You'll need to register this file in your web app and you should
 * disable HTTP caching for this file too.
 * See https://goo.gl/nhQhGp
 *
 * The rest of the code is auto-generated. Please don't update this file
 * directly; instead, make changes to your Workbox build configuration
 * and re-run your build process.
 * See https://goo.gl/2aRDsh
 */

importScripts("https://storage.googleapis.com/workbox-cdn/releases/4.3.1/workbox-sw.js");

self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

/**
 * The workboxSW.precacheAndRoute() method efficiently caches and responds to
 * requests for URLs in the manifest.
 * See https://goo.gl/S9QRab
 */
self.__precacheManifest = [
  {
    "url": "404.html",
    "revision": "b3d4ba39ec1da9d57e012009e2a3e00a"
  },
  {
    "url": "assets/css/0.styles.9d71db5e.css",
    "revision": "a551b2e1eaeca3b987e319edfcbd6cae"
  },
  {
    "url": "assets/icons/android-chrome-192x192.png",
    "revision": "9586de3fba3b67549b56160bb21f3ac2"
  },
  {
    "url": "assets/icons/android-chrome-512x512.png",
    "revision": "896336f89c893e247dc2ae421520150e"
  },
  {
    "url": "assets/icons/apple-touch-icon.png",
    "revision": "742255c7473b4ead234a38fc13e1c26d"
  },
  {
    "url": "assets/icons/mstile-150x150.png",
    "revision": "5ddbd8acd85e97146292ee27a7283b1a"
  },
  {
    "url": "assets/icons/safari-pinned-tab.svg",
    "revision": "933934248bca72a2b89f31f1c57985cc"
  },
  {
    "url": "assets/img/search.83621669.svg",
    "revision": "83621669651b9a3d4bf64d1a670ad856"
  },
  {
    "url": "assets/js/10.0147aafc.js",
    "revision": "6fd7087a1d613d00085abe27500f940e"
  },
  {
    "url": "assets/js/11.08445215.js",
    "revision": "d1cce8856ff12f739f28bd45a4694c92"
  },
  {
    "url": "assets/js/12.7dfbb945.js",
    "revision": "9f03bb3500759573ec9432b8b091713f"
  },
  {
    "url": "assets/js/2.f618bcda.js",
    "revision": "0c99cb2712460f1612874350af33bca1"
  },
  {
    "url": "assets/js/3.1166f530.js",
    "revision": "d3ec3bb6197987d3badffcb243e8c4fa"
  },
  {
    "url": "assets/js/4.d5bb7542.js",
    "revision": "1d36c7e15e4af4519fa69650d945641b"
  },
  {
    "url": "assets/js/5.6a6fee47.js",
    "revision": "2b33b07ee2d58f7afea559654205181e"
  },
  {
    "url": "assets/js/6.6ea32cbb.js",
    "revision": "4cc0f4eac025d476f36f773fbfad2a64"
  },
  {
    "url": "assets/js/7.0af1bfd3.js",
    "revision": "a6f493e8134963eb996db8df3bd90ca1"
  },
  {
    "url": "assets/js/8.5ddae48c.js",
    "revision": "e4179afb1fcca60979d590eb56bde449"
  },
  {
    "url": "assets/js/9.c7ed5dd3.js",
    "revision": "2f79839e4375ad7914a4707b42a9ea3c"
  },
  {
    "url": "assets/js/app.85ddc428.js",
    "revision": "f4053040db73d8cdec3268d1812ac6fe"
  },
  {
    "url": "en-US/index.html",
    "revision": "0d1c3b5a646e2f830b7250185684515c"
  },
  {
    "url": "index.html",
    "revision": "b87c9140f47a61e067e72b413bdac27d"
  },
  {
    "url": "zh-Hans/docs/index.html",
    "revision": "f096b8cf81a314320c9c9246690dcb3b"
  },
  {
    "url": "zh-Hans/index.html",
    "revision": "1f5841340b426e7a2077fa9ea6934bc1"
  }
].concat(self.__precacheManifest || []);
workbox.precaching.precacheAndRoute(self.__precacheManifest, {});
addEventListener('message', event => {
  const replyPort = event.ports[0]
  const message = event.data
  if (replyPort && message && message.type === 'skip-waiting') {
    event.waitUntil(
      self.skipWaiting().then(
        () => replyPort.postMessage({ error: null }),
        error => replyPort.postMessage({ error })
      )
    )
  }
})
