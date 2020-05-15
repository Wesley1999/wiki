module.exports = {
    title: '王少刚的Wiki', // 显示在左上角的网页名称以及首页在浏览器标签显示的title名称
    plugins: [
        'autobar',
    ],
    description: '本网站正在开发中', // meta 中的描述文字，用于SEO
    // 注入到当前页面的 HTML <head> 中的标签
    
    markdown: {
        extendMarkdown: md => {
            md.set({
                html: true
            })
            md.use(require('markdown-it-katex'))
        }
    },
    head: [
        ['link', { rel: 'icon', href: '/egg.png' }],  //浏览器的标签栏的网页图标
    ],
    markdown: {
        /*lineNumbers: true*/
    },
    serviceWorker: true,
    themeConfig: {    
        logo: '/egg.png',
        lastUpdated: 'lastUpdate', // string | boolean
        nav: [
            { text: '首页', link: '/' },
            {
                text: '分类',
                ariaLabel: '分类',
                items: [
                    { text: '分类1', link: '/pages/folder1/test1.md' },
                    { text: '分类2', link: '/pages/folder2/test4.md' },
                ]
            },
            { text: 'Blog', link: 'https://www.wangshaogang.com' },
            { text: 'Github', link: 'https://github.com/wesley1999' },
        ],
    }
}
