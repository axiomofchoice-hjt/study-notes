# react

- [1. 安装](#1-安装)
- [2. Hello](#2-hello)
- [3. vscode 配置](#3-vscode-配置)
- [4. JSX 语法](#4-jsx-语法)
  - [4.1. 插值](#41-插值)
  - [4.2. label for](#42-label-for)
  - [4.3. class](#43-class)
  - [4.4. style](#44-style)
  - [4.5. for](#45-for)
- [5. 样式](#5-样式)
- [6. 钩子](#6-钩子)
- [7. useState](#7-usestate)
- [8. useEffect](#8-useeffect)
- [9. 父子组件通讯](#9-父子组件通讯)
- [10. 跨级组件通讯](#10-跨级组件通讯)
- [11. 双向绑定](#11-双向绑定)
- [12. useRef](#12-useref)
- [13. memo, useCallback](#13-memo-usecallback)
- [14. React Redux](#14-react-redux)
- [15. React Router](#15-react-router)
- [16. Typescript](#16-typescript)
- [17. Ant Design of React](#17-ant-design-of-react)

## 1. 安装

```sh
npm i -g create-react-app
```

## 2. Hello

```sh
create-react-app $ProjName
code $ProjName
```

开启服务 `npm start`

`public/manifest.json` 是项目的配置

src 可以清空后加入下面两个文件

src/index.js 程序入口，必须要有

```js
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root') /*as HTMLElement*/);
root.render(
  <App />
);
```

src/App.js 是一个组件

```js
export default function App() {
  return (
    <div>App</div>
  );
}
```

## 3. vscode 配置

`.vscode/settings.json`

```json
{
    "emmet.includeLanguages": {
        "javascript": "javascriptreact"
    },
    "emmet.triggerExpansionOnTab": true,
    "[javascript]": {
        "editor.tabSize": 2
    },
    "[javascriptreact]": {
        "editor.tabSize": 2
    },
    "[typescript]": {
        "editor.tabSize": 2
    },
    "[typescriptreact]": {
        "editor.tabSize": 2
    }
}
```

安装插件 ES7+ React/Redux/React-Native snippets

- 输入 rfc 直接生成 react functional component

## 4. JSX 语法

### 4.1. 插值

```js
{msg}
```

### 4.2. label for

for -> htmlFor

```js
<label htmlFor="username">用户名</label>
<input type="text" id="username" />
```

效果：点击 label 会聚焦到 input

### 4.3. class

class -> className

```js
<div className="xxx">content</div>
```

### 4.4. style

style 里需要插值一个对象，属性名用小驼峰

```js
<div style={{backgroundColor: 'yellow'}}>content</div>
```

### 4.5. for

```js
let arr = ['a', 'b', 'c'];

<ul>
  {
    arr.map((item, index) => <li key={index}>{item}</li>)
  }
</ul>
```

## 5. 样式

导入 css 文件就能生效了

```js
import "./App.css";
```

## 6. 钩子

- 函数式组件没有生命周期，没有 this，没有 state
- 用 Hook 更新状态

## 7. useState

```js
import { useState } from 'react';

export default function App() {
  const [msg, setMsg] = useState('Hello');

  return (
    <div>
      {msg}
      <button onClick={() => setMsg('world')}>upd</button>
    </div>
  );
}
```

造轮子，getter setter 二合一

```js
function State(value) {
  const [getter, setter] = useState(value);
  return { get: () => getter, set: setter };
}
```

## 8. useEffect

监听 useState 的数据变化

```js
export default function App() {
  const [a, setA] = useState(0);
  const [b, setB] = useState(0);
  const [c, setC] = useState(0);
  useEffect(() => {}, [a, b]); // 只检测 a, b
  return ...;
}
```

写法一 `useEffect(() => {}, [a, b]);`

- 检测 a, b 变化
- 如果调用 setA/setB 但是无修改，不会触发
- 程序启动时触发一次

写法二 `useEffect(() => {}, []);`

- 不检测任何数据但是程序启动时触发一次

写法三 `useEffect(() => {});`

- 任何数据都能检测
- 程序启动时触发一次

写法四

```js
useEffect(() => {
  return () => console.log('onDestroy');
});
```

- 组件销毁时触发

## 9. 父子组件通讯

参数传递

```js
import { useState } from 'react';

function App2(props) {
  return (
    <div>
      {props.num}
      <button onClick={() => props.setNum(1)}>upd</button>
    </div>
  );
}

export default function App() {
  const [num, setNum] = useState(0);
  return (
    <App2 num={num} setNum={setNum} />
  );
}
```

## 10. 跨级组件通讯

createContext, useContext

```js
import { createContext, useContext, useState } from 'react';

const NumContext = createContext();

function App2() {
  const num = useContext(NumContext);
  console.log(num);
  return (
    <div>{num.get()}
      <button onClick={() => num.set(1)}>upd</button>
    </div>
  );
}

function State(value) {
  const [getter, setter] = useState(value);
  return { get: () => getter, set: setter };
}

export default function App() {
  const num = State(0);
  return (
    <NumContext.Provider value={num}>
      <App2 />
    </NumContext.Provider>
  );
}
```

## 11. 双向绑定

```js
import { useState } from 'react';

function State(value) {
  const [getter, setter] = useState(value);
  return { get: () => getter, set: setter };
}

export default function App() {
  let num = State(0);
  return (
    <div>
      <input
        type='text'
        value={num.get()}
        onChange={(event) => num.set(parseInt(event.target.value))}
      />
    </div>
  );
}
```

## 12. useRef

```js
import { useRef } from 'react';

export default function App() {
  const element = useRef(null);
  return (
    <div>
      <input
        type='text'
        ref={element}
      />
      <button onClick={() => console.log(element.current.value)}>upd</button>
    </div>
  );
}
```

## 13. memo, useCallback

父组件更新不影响子组件

只使用 memo，需要子组件是静态的

```js
import { memo } from 'react';

const Child = memo(() => {
  console.log(123); // 查看子组件是否更新
  return <div>456</div>;
});

export default function App() {
  return (
    <Child />
  );
}
```

使用 useCallback

```js
import { memo, useCallback, useState } from 'react';

const Child = memo((props) => {
  console.log('child update');
  return <button onClick={() => props.doSth()}>upd</button>;
});

export default function App() {
  const [num, setNum] = useState(0);
  const doSth = useCallback(() => setNum((num) => num + 1), []);

  return (
    <div>
      {num}
      <Child doSth={doSth} />
    </div>
  );
}
```

useMemo

- `useCallback(() => setNum((num) => num + 1), []);` 改成 `useMemo(() => () => setNum((num) => num + 1), []);`
- useCallback 是 useMemo 的语法糖？？？

## 14. React Redux

## 15. React Router

```sh
npm i react-router-dom
```

- BrowserRouter：Histroy 模式
- HashRouter：Hash 模式

项目目录如下

- pages
  - Detail.js（一个正常的组件）
  - Home.js（一个正常的组件）
- router
  - index.js
- App.js
- index.js

index.js

```js
import ReactDOM from 'react-dom/client';
import Router from './router';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <Router />
);
```

router/index.js

- `<Route path="*" element={...}></Route>` 写在后面，可以作为 404 使用

```js
import App from '../App';
import Home from '../pages/Home';
import Detail from '../pages/Detail';
import { BrowserRouter, Route, Routes } from 'react-router-dom';

export default function Router() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<App />}>
          <Route path="/home" element={<Home />}></Route>
          <Route path="/detail" element={<Detail />}></Route>
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
```

App.js

- OutLet 是子页面

```js
import { OutLet } from 'react-router-dom';

export default function App() {
  return (
    <div>
      <Outlet />
    </div>
  );
}
```

***

Link：路由链接

```js
import { Link } from 'react-router-dom';

export default function App() {
  return (
    <div>
      <Link to='/home'>首页</Link>
      <br />
      <Link to='/detail'>详情</Link>
    </div>
  );
}
```

***

useLocation：获取路径

```js
import { useLocation } from 'react-router-dom';

export default function App() {
  const location = useLocation();
  console.log(location.pathname);
  // "/" or "/home" or "/detail";
  return ...
}
```

***

useNavigate：路径跳转

```js
import { Outlet, useNavigate } from 'react-router-dom';

export default function App() {
  const navigate = useNavigate();

  return (
    <div>
      <button onClick={() => navigate("/home")}>首页</button>
      <br />
      <button onClick={() => navigate("/detail")}>详情</button>
      <br />
      <Outlet />
    </div>
  );
}
```

- navigate 可以携带状态，用 useLocation().state 获取

```js
navigate('/home', {
  state: { id: 233 }
});

console.log(useLocation().state.id);
```

***

参数

useParams

- router/index.js `<Route path="/home/:id"></Route>`
- 网址 `/home/233`

```js
import { useParams } from 'react-router-dom';

export default function Home() {
  const params = useParams();
  console.log(params.id);

  return (
    <div>Home</div>
  );
}
```

useParams

- router/index.js `<Route path="/home"></Route>`
- 网址 `/home?id=233`，`/home/?id=233` 似乎也可

```js
import { useSearchParams } from 'react-router-dom';

export default function Home() {
  const [params] = useSearchParams();
  console.log(params.get('id'));

  return (
    <div>Home</div>
  );
}
```

## 16. Typescript

```sh
create-react-app $projName --template typescript
```

目前的内容 js 和 ts 基本通用

## 17. Ant Design of React

```sh
npm install antd
```
