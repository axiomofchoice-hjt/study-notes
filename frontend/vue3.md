# vue3

- [1. Hello](#1-hello)
- [2. vscode 配置](#2-vscode-配置)
- [3. 最小 vue 项目](#3-最小-vue-项目)
- [4. 插值](#4-插值)
- [5. 属性绑定 v-bind](#5-属性绑定-v-bind)
- [6. 指令 v-if v-for](#6-指令-v-if-v-for)
- [7. 状态 reactive ref](#7-状态-reactive-ref)
- [8. 计算属性 computed](#8-计算属性-computed)
- [9. 事件 v-on](#9-事件-v-on)
- [10. 双向绑定 v-model](#10-双向绑定-v-model)
- [11. 生命周期钩子](#11-生命周期钩子)
- [12. 侦测器 watch](#12-侦测器-watch)
- [13. 模板引用](#13-模板引用)
- [14. 父传子通讯 props](#14-父传子通讯-props)
- [15. 子传父通讯 emit](#15-子传父通讯-emit)
- [16. 插槽 slot](#16-插槽-slot)
- [17. 动画](#17-动画)

## 1. Hello

安装 node & npm

```sh
sudo apt update
sudo apt install nodejs npm
sudo npm config set registry https://registry.npmmirror.com/
sudo npm install n -g
sudo n stable
sudo npm install -g npm
// 重启终端
```

新建项目并运行

```sh
npm init vue@latest
cd $project
npm install
npm run dev
```

npm install 太卡，可以执行

```sh
npm cache clean -f
rm node_modules package-lock.json -rf
npm install --registry=https://registry.npmmirror.com/
```

需要内网测试，修改 package.json > scripts > dev 为 `"vite --host"`

## 2. vscode 配置

插件 Vue Language Features (Volar)

打开 env.d.ts 添加如下代码（加入对 vue 的识别）

```ts
declare module "*.vue" {
  import type { DefineComponent } from "vue";
  const vueComponent: DefineComponent<{}, {}, any>;
  export default vueComponent;
}
```

## 3. 最小 vue 项目

其他文件删除，只剩下 4 个文件

main.ts

```ts
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';

const app = createApp(App);

app.use(router);

app.mount('#app');
```

App.vue

```vue
<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router';
</script>

<template>
  <RouterView />
</template>
```

views/HomeView.vue

```vue
<template>
  <div>
    233
  </div>
</template>
```

router/index.ts

```ts
import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '../views/HomeView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    }
  ]
});

export default router;
```

## 4. 插值

- 文本插值 `<div>{{ msg }}</div>`
- HTML 插值 `<div v-html="msg"></div>`，小心 XSS 漏洞

## 5. 属性绑定 v-bind

- `<div v-bind:id="id"></div>`
  - 简写 `<div :id="id"></div>`
  - 使用对象 `<div v-bind="{ id: id }"></div>`

class

- 使用对象 `<div :class="{ active: isActive }"></div>"`，通过 bool 变量来打开或关闭
- 使用列表 `<div :class="[active]"></div>`

style

- 使用对象 `<div :style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>`
- 使用数组 `<div :style="[style1, style2]></div>"`，合并多个对象

## 6. 指令 v-if v-for

- if 指令 `<p v-if="seen">Now you see me</p>`
  - 后面可选 `<p v-else-if="seen2">...</p>`
  - 后面可选 `<p v-else="seen2">...</p>`
- v-show，控制的是 display 属性
- v-for 指令 `<li v-for="item in items" :key="item.id"></li>`
  - `<li v-for="(item, index) in items" :key="index"></li>`
  - 遍历对象：`(value, key)`
- 不要同时用 v-if 和 v-for

## 7. 状态 reactive ref

reactive 响应式对象

```vue
<script setup lang="ts">
import { reactive } from 'vue';

const state = reactive({ count: 0 });
</script>

<template>
  <div>
    <button @click="state.count++">{{ state.count }}</button>
  </div>
</template>
```

ref 响应式对象，用 `.value` 得到或修改值

```vue
<script setup lang="ts">
import { ref } from 'vue';

const count = ref(0);
</script>

<template>
  <div>
    <button @click="count++">{{ count }}</button>
  </div>
</template>
```

- 状态改变后 DOM 更新的钩子 `nextTick`
- `reactive` 可以生成响应式对象

## 8. 计算属性 computed

```vue
<script setup lang="ts">
import { ref, computed } from 'vue';

const count = ref(0);
const isZero = computed(() => (count.value == 0));
</script>

<template>
  <div>
    <button @click="count++">{{ isZero }}</button>
  </div>
</template>
```

- 可写计算属性：需要写 getter 和 setter，应避免使用

## 9. 事件 v-on

`<a v-on:click="func"> ... </a>`

- 简写 `<a @click="func"> ... </a>`
- 省略参数会传入事件处理器，也可用 `$event` 显式指定
- 修饰符 `<form @submit.prevent="onSubmit">...</form>`
  - 按键修饰符 `@keyup.enter="func"`

## 10. 双向绑定 v-model

`<input v-model="text" />`

## 11. 生命周期钩子

```vue
<script setup>
import { onMounted } from 'vue';

onMounted(() => {
  console.log(`the component is now mounted.`);
});
</script>
```

- beforeCreate
- created
- beforeMount
- mounted
- beforeUnmount
- unmounted

## 12. 侦测器 watch

```vue
<script setup>
import { ref, watch } from 'vue'
const value = ref('')
watch(value, (newValue, oldValue) => {})
</script>
```

- `watch(v, $callback)`
- `watch(() => v, $callback)` 用函数（计算属性？）来侦测
- `watch([v1, v2], $callback)` 侦测多个数据

## 13. 模板引用

```vue
<script setup>
import { ref, onMounted } from 'vue'
// 必须和模板里的 ref 同名
const input = ref(null)
onMounted(() => {
  input.value.focus()
})
</script>
<template>
  <input ref="input" />
</template>
```

- v-for 中的模板引用
- 用 defineExpose 来暴露组件的数据，实现跨组件通讯？

## 14. 父传子通讯 props

使用 defineProps

## 15. 子传父通讯 emit

使用 $emit

## 16. 插槽 slot

父组件可以定义内容 `<child>...</child>`，子组件用 `<slot />` 可以获取

## 17. 动画

gsap
