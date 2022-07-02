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
    "revision": "0917d9fdf56d7f2a97db29e71729919e"
  },
  {
    "url": "assets/css/0.styles.c982227a.css",
    "revision": "07e15cac59293af8e70c9bb84005296f"
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
    "url": "assets/js/10.194ceb8e.js",
    "revision": "ac167efe96ecdf9991afa4b224b2ef99"
  },
  {
    "url": "assets/js/2.3e2410e6.js",
    "revision": "786775d1575f54f075ea820c9535688f"
  },
  {
    "url": "assets/js/3.d98a46ee.js",
    "revision": "73c6b4ecc61720a11b26182e65930f6f"
  },
  {
    "url": "assets/js/4.7de3137a.js",
    "revision": "c71eedcb486815548f2d05bb45ad2f45"
  },
  {
    "url": "assets/js/5.cea51467.js",
    "revision": "a06121431bb501cfd8bacf30e9e34ec8"
  },
  {
    "url": "assets/js/6.adfa6c21.js",
    "revision": "bb40124638b910771ab4e0db9effae09"
  },
  {
    "url": "assets/js/7.0e5cfdf5.js",
    "revision": "11742414d7a5e90c063d706923208e92"
  },
  {
    "url": "assets/js/8.683ae29d.js",
    "revision": "5e4459b22f3446fcdeb65ff2e58aee38"
  },
  {
    "url": "assets/js/9.f81c6923.js",
    "revision": "b757109612744eadeb73c2d91dc8eeff"
  },
  {
    "url": "assets/js/app.5c29de78.js",
    "revision": "20bf4406f6fd2a783dd77c89ebd7047f"
  },
  {
    "url": "en-US/index.html",
    "revision": "26e0547c4623475227bc6e1a7abac2a4"
  },
  {
    "url": "index.html",
    "revision": "b87c9140f47a61e067e72b413bdac27d"
  },
  {
    "url": "zh-Hans/index.html",
    "revision": "4793ddc93f792fb287dbf86085318074"
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
