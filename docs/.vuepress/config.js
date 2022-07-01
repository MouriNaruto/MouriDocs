module.exports = {
  locales: {
    '/en-US/': {
      lang: 'en-US',
      title: 'Mouri Docs',
      description: 'Technical documentation website created by Kenji Mouri'
    },
    '/zh-Hans/': {
      lang: 'zh-Hans',
      title: 'Mouri Docs',
      description: '由毛利创建的技术文档站点'
    }
  },
  themeConfig: {
    locales: {
      '/en-US/': {
        selectText: 'Languages',
        label: 'English',
        ariaLabel: 'Languages',
        editLinkText: 'Edit this page on GitHub',
        serviceWorker: {
          updatePopup: {
            message: "New content is available.",
            buttonText: "Refresh"
          }
        },
        lastUpdated: 'Last Updated',
        nav: [
          { text: "Home", link: '/en-US/'}
        ]
      },
      '/zh-Hans/': {
        selectText: '选择语言',
        label: '简体中文',
        editLinkText: '在 GitHub 上编辑此页',
        serviceWorker: {
          updatePopup: {
            message: "发现新内容可用.",
            buttonText: "刷新"
          }
        },
        lastUpdated: '最后更新时间',
        nav: [
          { text: "首页", link: '/zh-Hans/'}
        ]
      }     
    }
  }
}

