# Web

- [1. TypeScript](#1-typescript)
  - [1.1. 类型声明](#11-类型声明)
  - [1.2. 类](#12-类)
- [2. node-webkit](#2-node-webkit)
- [3. uni-app](#3-uni-app)
- [4. express](#4-express)
- [5. parcel](#5-parcel)

## 1. TypeScript

### 1.1. 类型声明

- any：任意类型
- number：数字（好像就一浮点型）
- string：字符串
- boolean：布尔
- `number[]`：数组
- `[number, number, ...]`：元组
- enum：枚举
- void：函数无返回值
- null：缺失
- undefined：未定义
- never：从不出现的值
- `number | number | ...`：多种值的 Union
- `{ a: number, b: number, ... }`：对象
- 函数类型好像是 `(x: number, y: number, ...) => number`

变量声明 `var x: string = "abc";`，若无初始值，其值为 `undefined`。若不声明类型，将会自动推断。

类型断言：`<number> value`

类型判断：`value instanceof type`

函数声明 `function f(x: number): number { ... }`

可选参数 `function f(x: number, y?: number)`，其中 y 是可选参数。

类型别名 `type name = number`

可以声明多个同名不同参的函数，但是实现只能写一个

接口：略

### 1.2. 类

```TS
class ClassName {
  private a: number; // 默认 public
  static b: number; // 用 ClassName.b 访问
  constructor() { this.a = 1; }
}
```

## 2. node-webkit

将 web 打包成桌面程序。

## 3. uni-app

将 vue 项目打包成微信小程序

创建项目步骤

- `vue create -p dcloudio/uni-preset-vue name` 在当前目录下建立 name 文件夹作为项目文件夹，生成项目。
- 选择默认模板
- `cd name`，`npm run serve`（生成网页）
- 删除 .git 文件夹

`npm run dev:mp-weixin` 生成 `/dist/dev/mp-weixin`，用微信开发工具打开即可。

## 4. express

`npm init`

`npm install express --save`

在 index.js 里：

```js
const Express = require('express');

const server = Express();

server.use('', Express.static('./'));

server.listen(8089, function () {
    console.log('listening on port 8089');
});
```

在 package.json 里：

```json
{
  "scripts": {
    "serve": "node index.js"
  }
}
```

这样就可以实现本地服务器了

## 5. parcel

`npm install --save parcel-bundler`

假设入口为 src/index.html，配置运行命令：

```json
"scripts": {
  "serve": "parcel src/index.html",
  "build": "parcel build src/index.html"
},
```

index.html 里引入 js 代码需要：

```html
<script src="./js/main.js" type="module"></script>
```

这样就可以模块化编程了
