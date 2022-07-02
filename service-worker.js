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
    "revision": "3a77171dbe6054ee454adc1e5e5a1df1"
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
    "url": "assets/js/10.89599bff.js",
    "revision": "688ba8e1558e53171e375daa37643495"
  },
  {
    "url": "assets/js/11.27ed3507.js",
    "revision": "80c9a029039b7b3d24964cd7dbd873e3"
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
    "url": "assets/js/4.85e9ba69.js",
    "revision": "935be39c4f4e93f264106307affdf1dd"
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
    "url": "assets/js/app.97c408ce.js",
    "revision": "b3ad18e7ce1081c66cb692bdfb8c92d5"
  },
  {
    "url": "en-US/index.html",
    "revision": "a220ce0602cfe94b4d4b61c79763fb60"
  },
  {
    "url": "index.html",
    "revision": "b87c9140f47a61e067e72b413bdac27d"
  },
  {
    "url": "zh-Hans/index.html",
    "revision": "36b28d29967d3a834958eb719a7eb806"
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
