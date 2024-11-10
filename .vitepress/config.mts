import { defineConfig, DefaultTheme } from 'vitepress';
import getArticles from './articles.mts';
import getSidebar from './sidebar.mjs';

let articles = getArticles('src');
const sidebar = getSidebar(articles);

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "个人笔记",
  description: "Study Notes",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
    ],

    sidebar,

    socialLinks: [
      { icon: 'github', link: 'https://github.com/axiomofchoice-hjt/study-notes' }
    ],
    search: {
      provider: 'local'
    },
    footer: {
      message: 'Released under the <a href="https://github.com/axiomofchoice-hjt/study-notes/blob/main/LICENSE">MIT License</a>.',
      copyright: 'Copyright © 2022-present <a href="https://github.com/axiomofchoice-hjt">Axiomofchoice-hjt</a>'
    },
    editLink: {
      pattern: 'https://github.com/axiomofchoice-hjt/study-notes/edit/main/src/:path'
    }
  },
  vite: {
    plugins: [
    ]
  },
  markdown: {
    lineNumbers: true,
    math: true
  },
  cleanUrls: true,
  srcDir: 'src',
});
