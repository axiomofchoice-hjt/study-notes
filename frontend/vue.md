# vue

- [1. 安装](#1-安装)
- [2. 运行](#2-运行)
- [3. 单文件组件](#3-单文件组件)
- [4. .html 文件基本构成](#4-html-文件基本构成)
- [5. 响应式](#5-响应式)
- [6. 组件](#6-组件)
- [7. 生命周期钩子](#7-生命周期钩子)
- [8. 插值](#8-插值)
- [9. 指令 Attribute](#9-指令-attribute)
- [10. v-事件](#10-v-事件)
- [11. 计算属性](#11-计算属性)
- [12. 监视属性](#12-监视属性)
- [13. 绑定样式](#13-绑定样式)
- [14. vue 表单](#14-vue-表单)
- [15. 自定义指令](#15-自定义指令)
- [16. ref](#16-ref)
- [17. props 配置](#17-props-配置)
- [18. 混合 mixin](#18-混合-mixin)
- [19. 自定义插件](#19-自定义插件)
- [20. css scoped](#20-css-scoped)
- [21. vue-axios](#21-vue-axios)
- [22. vue-router](#22-vue-router)
- [23. vuex store](#23-vuex-store)

## 1. 安装

```bash
sudo npm i vue-cli -g
vue init webpack projectName
cd projectName
npm run dev
```

## 2. 运行

- 游览器运行 `.html` 文件，加载 `<script src="https://unpkg.com/vue@next"></script>`，js 代码里 `Vue.createApp(object).mount("#id")`。

## 3. 单文件组件

- `<template>` 表示 html 代码。
  - 里面只能有一个节点（一般是 div）。
  - `{{ xxx }}` 绑定变量。
  - 有时候用 `"xxx"` 绑定，就很奇怪。（看了一下，应该是所有 `v-` 指令的值都是绑定变量或函数）
- `<style>` 表示 css 代码。
- `<script>` 表示 js 代码。
  - 一般包含 `export default` 后接一个对象。
  - data 方法返回一个对象，表示 html 变量绑定。
  - methods 属性是一个对象，表示用到的函数。
  - mount 方法估计是预处理（？）。

App.vue 里：

```vue
<template>
  <div v-bind:title="message" v-on:click="click">
    {{ message }}
  </div>
</template>
<script>
import c1 from "./c1.vue"; // 引入 c1.vue 文件（单文件组件）
export default {
  data() {
    return {
      message: 123,
    };
  },
  components: {
    c1: c1,
  },
  methods: {
    click() {
      this.message = this.message * 2;
    },
  },
  mounted() {
    setInterval(() => {
      this.message++;
    }, 1000);
  },
};
</script>
```

main.js 里：

```js
import Vue from "vue" // 引入 Vue
import App from "./App.vue"; // 引入组件
Vue.config.productionTip = false; // 关闭生产提示
new Vue({
  render: h => h(App),
}).$mount('#app')
```

index.html 里：

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <!-- IE 配置 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 移动端配置 -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <!-- 配置页签图标 -->
    <link rel="icon" href="<%= BASE_URL %>favicon.ico">
    <!-- 标题 -->
    <title>default</title>
  </head>
  <body>
    <div id="app"></div>
  </body>
</html>

```

- `vue serve App.vue`，对一个组件进行测试。这个操作不需要 `Vue.createApp`。

## 4. .html 文件基本构成

- 注意加载 Vue 的元素的指令 (v-bind 等) 是无效的，要加载到高一级的 div 上。

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>title</title>
  <script src="https://unpkg.com/vue@next"></script>
</head>
<body>
  <div id="app">
    <div v-bind:title="message" v-on:click="click">
      {{ message }}
    </div>
  </div>
  <script>
    const app = {
      data() {
        return {
          message: 123,
        };
      },
      methods: {
        click() {
          this.message = this.message * 2;
        },
      },
      mounted() {
        setInterval(() => {
          this.message++;
        }, 1000);
      },
    };
    Vue.createApp(app).mount('#app');
  </script>
</body>
</html>
```

## 5. 响应式

- 初始化时，所有对象内的元素都是响应式的。
- 数组内的元素不是响应式的，赋值的方式 `arr[0] = 233` 不会触发动作（可以写成 `arr.splice(0, 1) = 233`，也可以写 `Vue.set(vm.arr, 0, 233)`），但是数组的一些函数会触发：
  - push, pop, shift, unshift
  - splice
  - sort, reverse

## 6. 组件

- 用 `Vue.createApp(配置选项).mount("#id")` 来将 Vue 应用挂载到某 id 的元素上。一个应用只能挂到一个元素上。
- createApp 返回 Vue 应用（变量名用 app），mount 返回根组件（变量名用 vm）。
- component 自定义组件：

```js
const app = Vue.createApp({});
app.component("name", {
  data() {
    return { /* ... */ };
  },
  template: "<div>233</div>",
});
const vm = app.mount("#id");
// 在 id 元素内可以使用 <name></name> 来使用该组件。
```

- data（和 methods, props, computed, inject, setup）的内容通过组件实例暴露，即 `vm.xxx`。
  - 允许添加新的变量，但是不会被跟踪。
  - 避免用 `$` 或 `_` 开头的变量名。

vue2 写法（？）

```js
const c1 = Vue.extend({ // 创建组件
  template:`
    <div>
    </div>
  `,
  data() {
    return {
      /* ... */
    };
  },
})
new Vue({
  el: "#root",
  components: { // 注册组件
    c1: c1;
  }
})
```

Vue.extend 返回一个名为 VueComponent 的构造函数。

## 7. 生命周期钩子

- 直接在配置里写 mounted 等函数。
- created 函数在一个实例被创建后执行。
- mounted 函数在挂载完后执行。
- 每次 data 变更后执行 updated。（？）
- 析构时执行 unmounted。（？）
- 不要把箭头函数赋值给生命周期钩子，因为箭头函数没有 this 的定义。
- 挂载流程：beforeCreate → 创建 data、methods → created → 模板替换 → beforeMount → 挂载 → mounted
- 更新流程：数据更新 → beforeUpdate → 页面更新 → updated
- 销毁流程：`v-if v-for` 更新 → beforeDestroy → 销毁 → destroyed

## 8. 插值

- `<span>{{ msg }}</span>` 进行文本插值。
- `<span v-once>{{ msg }}</span>` 一次性插值（不动态更新）。

## 9. 指令 Attribute

- `v-` 开头的是 Vue 提供的特殊指令。
- `<div v-bind:href="var">` 将属性绑定为变量。如果变量是 null 或 undefined 则不绑定。
- 动态参数：`<div v-bind:[var]="var">` 属性参数甚至也可以绑定为变量。动态参数如果为 null 则不绑定。HTML 文件中使用模板要主义动态参数名会被强制转为小写。
- `<div v-bind:title="var">` 鼠标悬停一会后显示的提示信息。
- `<button v-on:click="func">` 单击事件。（函数定义在 methods 里）
- `<input v-model="var" />` 把 input.value 内容和变量同步。（双向绑定）
- 类似 `v-bind:href` 可缩写为 `:href`。
- 类似 `v-on:click` 可缩写为 `@click`。

条件和循环语句

- 用 `<template v-if="...">` 来复合代码。
- `<div v-if="var">` 如果 var 为 true 则插入元素，否则销毁（可动态更新）。还可用 `v-else` 和 `v-else-if`。
- `<div v-show="var">` 类似 v-if，但是通过修改 display 来控制元素的显示和隐藏。
- v-for，实现 for 模板（可动态更新）。
  - 数组可以用 `v-for="(i, index) in arr" v-bind:key="index"`，第二个参数是下标。key 必须互不相同。（用下标作为 key 会出问题，具体未知）
  - 对象可以用 `v-for="(val, key) in obj" v-bind:key="key"`。
  - 可以遍历指定次数 `v-for="(a, index) in 5" v-bind:key="index"`，a 是 1..5，index 是 0..4。

```vue
<template>
  <div id="list-rendering">
    <ol>
      <li v-for="(i, id) in todos" v-bind:key="id">
        {{ i.text }}
      </li>
    </ol>
  </div>
</template>
<script>
export default {
  data() {
    return {
      todos: [
        { text: "Learn JavaScript" },
        { text: "Learn Vue" },
        { text: "Build something awesome" },
      ],
    };
  },
};
</script>
```

一些奇怪的东西

- `v-text="xx"` 类似插值，和里面写 `{{ xx }}` 一样。
- `v-html="xx"` 类似插值，并且插的是 html。不负责进一步 Vue 解析（应该）。
- `v-cloak`，在 vue 没加载的适合作为属性出现，在 vue 加载完后删除。可以在 style 里写 `[v-cloak] { display: none; }`，所有有 v-cloak 属性的标签在加载前都不出现。
- `v-once` 该节点一次性渲染。
- `v-pre` 该节点不渲染。（包括这个节点的属性）

## 10. v-事件

- `<button v-on:click="flag = !flag">` 允许写一些简单的语句。相当于 `func() { this.flag = !this.flag; }`。
- `<button v-on:click="func">`，可以让 func 接收鼠标事件 `func(event) { }`。
- `<button v-on:click="func(a, b, c, $event)">`，允许传递其他参数，并在 `$event` 位置接受鼠标函数，`func(a, b, c, event) { }`。
- 事件修饰符：`<button v-on:click.prevent="func">`
  - prevent：阻止默认事件。
  - sop：阻止事件冒泡。（一个元素的事件会传给父亲，称为冒泡）。
  - once：事件只触发一次。
  - passive：默认行为和事件函数同时进行。（不加的话事件函数先执行）
  - capture, self：...
- `@keyup` 键盘抬起，`@keydown` 键盘按下。键盘事件的属性 `event.keyCode`（无括号）表示按键代码（已废除）。
- `@keyup.enter` 回车抬起。类似还有 delete（包括 backspace 和 delete）, esc, space, tab, up, down, left, right 等等（event.key 查看它们的按键名）。其中 tab, ctrl, alt, shift, meta（就是 win 键）最好用 keydown（除非检测组合键）。如果是 `PageUp` 要写成 `@keyup.page-up`。
- `@keyup.ctrl.shift.a` 这样可以检测组合键。

## 11. 计算属性

- 写进 methods 里的函数如果被模板调用，任一 data 更新后会再调用一遍该函数。开销较大。
- 写进 computed 里的函数，只会在启动时和依赖改变时调用。（缓存机制）模板的计算属性里不要用小括号。

## 12. 监视属性

- 数据改变时调用函数。

```js
({
  watch: {
    flag: { // 监视 flag
      immediate: true, // 启动时执行，默认 false
      handler(newValue, oldValue) { } // 监视函数
    }
    'obj.a': { } // 监视对象内的元素
  }
})
```

如果要监视对象里的所有元素，要用深度检测

```js
({
  watch: {
    obj: { // 监视 obj
      deep: true, // 深度检测，默认 false
      handler(newValue, oldValue) { } // 监视函数
    }
  }
})
```

无 immediate, deep 配置，可以简写

```js
({
  watch: {
    flag(newValue, oldValue) { }
  }
})
```

## 13. 绑定样式

- `<div class="a" v-bind:class="b">`，最终样式会合并为 `"a" data.b`
- 多个动态样式：
  - 用数组 `v-bind:class="arr"`，`arr = ["a", "b", "c"]`。
  - 用对象 `v-bind:class="obj"`，`obj = { "a": true, "b": true, "c": false }`，true 表示应用，false 表示不应用。
- 元素内样式：`<div v-bind:style="obj">`，`obj = { fontSize: 40 + "px" }`。如果多个对象可以用数组来合并，`<div v-bind:style="[obj1, obj2]">`。

## 14. vue 表单

- 文本 input text、密码框 input password、多行文本 textarea 直接用 v-model 收集。
- 下拉框 select、单选框 input radio，写清楚 value 后，每个都写 v-model 绑定到初始为 null（不确定）的变量，该变量会同步选中的 value。
- 复选框 inpuy checkbox，写清楚 value 后，绑定到一个初始为空的数组，数组会放所有选中的 value。也可以绑定到 boolean 上，如果只有一个选项的话。
- `type="number` 只输入数字。（但是会允许小数点和 e）

一些修饰

- `v-model.number="xx"` 绑定到 number 类型上。
- `v-model.lazy="xx"`，在失去焦点的时候才更新变量。
- `v-model.trim="xx"`，去掉字符串两端的空格。

提交表单：`<form @submit.prevent="func">`，methods 里写 `func() { /*JSON.stringify(this.formInfo);*/ }`

- **过滤器**

- `{{ xxx | func }}`，通过过滤器后显示，即 `func(xxx)`。
- 在配置里写 `filters: { func(value) { return ...; } }`。
- 貌似 vue3 弃用了。

## 15. 自定义指令

- 配置里写 `directives: { func(element, binding) { } }`，就能用 `v-func="var"` 指令了。
- element 是真实 DOM 元素。
- binding 是一个对象，binding.value 拿到 var 的值。
- func 函数里的 this 不是 Vue，是 window。
- 函数名要写连接符
- 在 bind、update 时调用 func 函数。
- 详细写法：

```js
({
  directives: {
    bind(element, binding) { } // 元素于指令绑定时
    inserted(element, binding) { } // 元素被插入页面时
    update(element, binding) { } // 模版被重新解析时
  }
})
```

## 16. ref

- `<div ref="r1"></div>`。
- `this.$refs.r1` 拿到真实元素。如果该元素是自定义组件，拿到的是 VueComponent。
- 可以取代 document.getElementById。

## 17. props 配置

子组件 .vue 内：

```js
export default { // 写法 1
  props: ["xx", "yy"],
};
export default { // 写法 2
  props: {
    xx: Number,
    yy: String,
  },
};
export default { // 写法 3
  props: {
    xx: {
      type: Number, // 类型
      required: true, // 是否是必须的
    },
    yy: {
      type: String,
      default: "0", // 不填的默认值
    },
  },
};
```

- 使用时：`<tag v-bind:xx="12" yy="34"></tag>`
- 收到的数据直接用 this.xx, this.yy 暴露。不在 _data 里。
- 只读，不要修改 props 的内容。
- props 先于 data 初始化，可以传给 data。
- 变量名不能为 key, ref 等。

## 18. 混合 mixin

在 xxx.js 里：

```js
export const mixName = {
  data() { return { }; },
  methods: { },
};
```

在 .vue 文件里：

```js
import {mixName} from "./xxx.js"
export default {
  mixin: [mixName],
};
```

- mixName 里的所有内容都与后者进行合并。
- 有冲突的话以后者为准。
- 生命周期钩子则都执行。

## 19. 自定义插件

在 plugin.js 里：

```js
export default {
  install(Vue) { // 必须有
    Vue.directive("x", { }); // 全局指令
    Vue.mixin({ }); // 全局混入
    Vue.prototype.func = () => {}; // 全局函数
  },
};
```

main.js 里：

```js
import plugin from "./plugin.js";
Vue.use(plugin); // 装插件
```

## 20. css scoped

`<style scoped>` 局部 css，只对这个文件有效。

## 21. vue-axios

- `npm i axios`

```js
import axios from "axios";
axios
  .get("/index", {
    params: { // 参数
      ID: 12345,
    },
  })
  .then(response => {
    // 成功的处理
  })
  .catch(error => {
    // 失败的处理
  })
  .finally(() => {
    // 无论成功或失败
  });
```

- `response.data` 读取内容。
- response

## 22. vue-router

- 项目目录下 `npm i vue-router`
- `views` 文件夹里放路由组件。

src/router/index.js：

```js
import VueRouter from 'vue-router';
import Home from '../views/Home.vue'; // 引入组件
import About from '../views/About.vue'; // 引入组件
export default new VueRouter({
  routes: [
    { path: "/home", component: Home },
    {
      path: "/about",
      components: { // 命名视图，注意 s，用 <router-view name="b"> 展示，不写 name 就是 default
        default: About,
        b: Bro,
      },
      children: [ // 嵌套路由，在组件里写 <router-view></router-view>
        { path: '', component: ..., },
      ],
    },
    { path: '/a', redirect: '/b' }, // 重定向，/a => /b
  ],
});
```

```js
import VueRouter from 'vue-router';
import router from './router';

Vue.use(VueRouter); // 应用插件

new Vue({
  el: "#app",
  render: h => h(App),
  router: router,
});
```

- active-class 被激活时的样式。
- to 路径名。

```html
<!-- 导航栏 -->
<router-link active-class="active" to="/home">Home</router-link>
<router-link active-class="active" to="/about">About</router-link>
<!-- 展示区 -->
<router-view></router-view>
<!-- 缓存路由 -->
<keep-alive include="Home">
  <router-view></router-view>
</keep-alive>
```

- `this.$router.push(location)`，也可以实现路由跳转。

监视 route.params 变化：（导航守卫等方法不可行）

```js
watch: {
  $route(newValue, oldValue) { }
}
```

## 23. vuex store

store.js 里：

```js
import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    value = 1;
  },
  getters: {
    value(state) {
      return state.value
    }
  },
  mutations: {
    setValue(state, value) {
      state.value = value;
    }
  }
})
```

别的 vue 文件中：

```js
export default {
  store,
  data() { ... }
}
```

可以用 `this.$store.getters.value` 得到值

可以用 `this.$store.commit("setValue", 2)` 修改值
