# js

- [1. 字符串](#1-字符串)
- [2. 数组](#2-数组)
- [3. 对象](#3-对象)
- [4. Map](#4-map)
- [5. Set](#5-set)
- [6. 函数](#6-函数)
- [7. 类型](#7-类型)
- [8. class](#8-class)
- [9. Date](#9-date)
- [10. JSON](#10-json)
- [11. BOM](#11-bom)
- [12. DOM](#12-dom)
- [13. 表单](#13-表单)
- [14. JS 事件](#14-js-事件)
- [15. 提示框](#15-提示框)
- [16. canvas](#16-canvas)
- [17. cookie](#17-cookie)
- [18. math.js](#18-mathjs)
- [19. WebSocket 客户端](#19-websocket-客户端)

HTML 的 head 可以嵌入 JS 代码：

```HTML
<script>
  alert("Hello world");
</script>
<script src="/static/js/abc.js"> </script>
```

声明 `var a = 1;`。不用 `var` 的声明都是**全局变量**，会出大问题。代码第一行写 `"use strict";` 进入 strict 模式可禁止使用该语法。

`var` 和 python 一样是函数作用域，用 `let` 代替可以变成块作用域。

不区分整型和浮点型，统一为 Number 类型。

布尔型常量 `true, false`，运算 `&&, ||, !`。

`null` 为空，`undefined` 为未定义，一般都用 `null`。

不要用 `==` 比较，用 `===` 代替。后者一旦类型不一致就返回 `false`。

`for (var i in Arr) { }`（大概会遍历所有非继承属性），`for (var i of Arr) { }`（只遍历元素，针对 Array, Set, Map 等）。

`typeof x` 返回其类型（是个字符串）。

`throw "error";` 抛出异常。

`const PI = 3.14;` 常量。

## 1. 字符串

- 字符串常量用单双引号都可。
  - 用反引号，可以换行也可以替换（模板字符串）：\``Hello, ${name}!`\`
- 打印字符串 `console.log(s)`。
- 字符串大小写转换 `toUpperCase(s), toLowerCase(s)`。
- 子串位置 `"123".indexOf("2")`（返回 1），找不到返回 -1。
- 字符串切片 `"12345".substring(1, 3)`（返回 `"23"`）。

## 2. 数组

- 数组常量 `[1, "A"]`，也可以用 `new Array(1, "A")`。
- 数组长度用赋值改变 `Arr.length = 6`，多出的部分是 `undefined`。
- 访问用索引，超出范围会改变长度。
- 数组元素位置 `[1, 2].indexOf(2)`（返回 1），找不到返回 -1。
- 数组切片 `[1, 2, 3].slice(1, 3)`（返回 `[2, 3]`）。
- 操作尾部 `Arr.push(x..), Arr.pop()`。
- 操作头部 `Arr.unshift(x..), Arr.shift()`。
- `Arr.sort(), Arr.reverse()`。（原地操作并返回自己）（注意 `sort` 默认先转换成 `String`，对数字排序需要 `Arr.sort((x, y) => (x > y) - (x < y))`。
- 数组位置 x 开始删除 y 个元素，再插入一些元素 z `Arr.splice(x, y, z..)`（返回被删除的元素数组）。
- 连接 `[1, 2].concat([3, 4])`（返回 `[1, 2, 3, 4]`）。
- 连接为字符串 `["1", "2"].join("-")`（返回 "1-2"）。

## 3. 对象

- 定义：

```JS
var person = {
    name: 'Bob',
    tags: ['js', 'web', 'mobile']
};
```

- 对象由键值对组成，键是字符串。
- 键符合变量名表示法就能省略引号，此时访问可以用 `person.name`。
- 所有情况访问都能用 `person["name"]`。
- 对不存在的键可以赋值来创建 `person.age = 20;`。
- 删除 `delete person.name;`。
- 存在 `"name" in person`。但是会认为继承属性也是其键，可用 `person.hasOwnProperty("name")` 来避免。
- Object.defineProperty，为对象添加属性：

```js
Object.defineProperty(obj, "key", {
  value: val, // 属性值
  enumerable: true, // 是否可被迭代，默认 false
  writable: true, // 是否可被修改，默认 false
  configurable: true, // 是否可被删除，默认 false
  get() { return x; } // getter
  set(x) { } // setter
})
```

## 4. Map

- 定义 `var mp = new Map();`
- 添加 `mp.set(key, value);`
- 删除 `mp.delete(key);`
- 存在 `mp.has(key)`
- 求值 `mp.get(key)`

## 5. Set

- 定义 `var st = new Set();`
- 添加 `st.add(key);`
- 删除 `st.delete(key);`
- 存在 `st.has(key)`

## 6. 函数

- 定义：

```JS
function sqr(x) {
  return x * x;
}
```

- 传入的参数个数任意，多了就无视，少了就是 `undefined`。
- 函数内可以用类似 Array 的关键字 `arguments`，`length` 取长度，索引取参数。
- `function f(A, B, ...rest)` 中 `rest` 可以取得剩下的参数。
- 由于 JS 每行末尾可能会加分号，如果要多行就在 `return` 后面加括号。
- `this` 即函数内指向以该函数为属性的对象。（一般认为 `obj.func()` 这么调用的时候一定正确，其他情况都是神仙）

变量提升：即先扫描整个函数体的语句，把所有申明的变量“提升”到函数顶部。但是初始化并没有提升。

全局变量实际上都是 `window` 对象的属性。

解构赋值：`var [x, y] = [y, x];`。可以用类似方法直接取出对象的属性 `var {x, y} = obj`。

匿名函数还能用箭头表示，`x => x * x`，`(x, y) => x * x + y * y`，`() => 3`（无参数）。

map / reduce

- `[1, 2, 3].map(x => x * x)` （返回 `[1, 4, 9]`）。（函数可以有第二个参数，即索引）
- `[1, 2, 3].reduce((x, y) => x + y)` （返回 `6`）。
- `[1, 2, 3].filter(x => x % 2 !== 0)` （返回 `[1, 3]`）。

forEach

- `Arr.forEach(function (A, B, self) { });`
- 对于 Array，A = element, B = index。
- 对于 Set，A = B = key。
- 对于 Map，A = key, B = value。

## 7. 类型

- 注意 `Number, Boolean, String` 都是包装对象，即类型都是 `object`。（即，`typeof new Number() === "object"`）
- 注意 `Number, Boolean, String` 不写 `new` 的时候意味着类型转换，且转换到原生对象。（即，`typeof Number("1") === 'number'`）

```Javascript
typeof 0 === "number"
typeof 0n === "bigint"
typeof "" === "string"
typeof false === "boolean"
typeof Math.abs === "function"
typeof undefined === "undefined"
typeof null / typeof [] === "object"
typeof Symbol() === "symbol"
```

- 不要使用 `new Number / Boolean / String`。
- 转换到数字用 `parseInt, parseFloat`。
- 判断 `Array`：`Array.isArray(Arr)`。
- 判断变量是否存在：`typeof x === "undefined"`。
- number 用作整数时，可以表示 -9007199254740991 .. 9007199254740991（9e15）范围内的整数。
- bigint：123n 表示常量；转换为字符串后没有 n；除法（/）是整除；有些函数需要转换为 number。

## 8. class

```js
class A {
  constructor(name) {
    this.name = name;
  }
  print() {
    console.log(this.name);
  }
}
let x = new A("xxx");
```

## 9. Date

```js
var now = new Date(); // 当前日期
now; // Wed Jun 24 2015 19:49:22 GMT+0800 (CST)
now.getFullYear(); // 2015, 年份
now.getMonth(); // 5, 月份，注意月份范围是 0-11，5 表示六月
now.getDate(); // 24, 表示24号
now.getDay(); // 3, 表示星期三（0 是礼拜天）
now.getHours(); // 19, 24小时制
now.getMinutes(); // 49, 分钟
now.getSeconds(); // 22, 秒
now.getMilliseconds(); // 875, 毫秒数
now.getTime(); // 1435146562875, 以 number 形式表示的时间戳（毫秒）
```

dayjs 库

- `dayjs()` 拿到当前时间，`dayjs(num)` 指定时间戳。

## 10. JSON

- 键是字符串，用双引号；值有 6 种类型 `number, boolean, string, null, array, object`。
- 对象转换为 JSON 字符串：`JSON.stringify(obj)`。
- JSON 字符串转换为对象：`JSON.parse(s)`

## 11. BOM

- `window.innerWidth, window.innerHeight`：页面长宽。
- `window.open("/...")` 打开窗口（还是标签页？）。
- `timer = window.setTimeout("func()", "10")` 计时器（单次计时，单位毫秒）。`window.clearTimeout(timer)` 停止计时。
- `window.setInterval(...)` 重复计时的计时器。停止就是 `window.clearInterval(...)`。
- `navigator.appName`：浏览器名称。
- `navigator.appVersion`：浏览器版本。
- `navigator.language`：浏览器设置的语言。
- `navigator.platform`：操作系统类型。
- `navigator.userAgent`：浏览器设定的 User-Agent 字符串。
- `screen.width`：屏幕宽度，以像素为单位。
- `screen.height`：屏幕高度，以像素为单位。
- `screen.colorDepth`：返回颜色位数，如 8、16、24。
- `location.href`：当前 URL。（还有其他方法如 `document.location`，但是不知道区别）
- `location.assign("/...")`：跳转网页。

## 12. DOM

- `document`：DOM 树的根节点。
- `document.cookie`：当前页面的 cookie。
- `document.title`：当前标题。
- `element.getElementById("ID")`：子树中通过 ID 找节点。
- `element.getElementsByTagName("Tag") / getElementsByClassName("Class")`：子树中通过 Tag / Class 找节点。（`Array`）
- `element.parentNode`：父亲。
- `element.children`：儿子。（`Array`）
- `element.innerHTML = "..."`：对它赋值后编码为 HTML，也就是直接修改子树。
- `element.innerText = "..."`：对它赋值后还是文本，不会编码为 HTML。
- `element.style.color = "#ff0000"`：修改 css。（均用驼峰命名法）
- `element.appendChild(x)`：将节点移动到 `element` 最后一个儿子后面。
- `document.createElement("Tag")`：创建一个节点。
- `element.insertBefore(x, y)`：将节点 x 移动到 y 前（父亲是 element）。
- `element.removeChlid(x)`：将节点 x 移除，并返回 x（父亲是 element）。
- `document.write / writeln(s)`：应该是在当前 `script` 的后面添加 html。

## 13. 表单

- `<input type="text" />`，文本框，通过 `element.value` 获取文本。
- `<input type="password" />`，口令框，获取同上。
- `<input type="hidden" />`，隐藏文本，获取同上，用来存数据。
- `<select><option value ="A">A</option><option value ="B">B</option><option value="C">C</option></select>`，下拉框，获取同上（未测）。
- `<label><input type="radio" name = "letter" />A</label><label><input type="radio" name = "letter" />B</label>` 单选框（多选一），用 name 属性串起来。label 让用户可以点击文字选择。获取用 `elementOfInput.checked`（`boolean`）。
- `<input type="checkbox" ... />`，复选框（多选多），同上。
- 设置值直接对 `value / checked` 赋值即可。
- `<button type="button">Text</button>`。如果 `type="submit"` 就会提交表单。

placeholder 属性：空的适合会显示的文字？

form 的 action 属性：表示表单提交的地址。

`<label for="id">账号：</label><input type="text" id="id" />`，点击 label 焦点会移到 id 上。

## 14. JS 事件

- `<xx onclick="jscode">`：鼠标点击后执行 js 代码。
- `<xx onmouseover="jscode" onmouseout="jscode">`：鼠标进入、移出时执行。
- `<xx onmousedown="jscode" onmouseup="jscode">`：鼠标在该位置按下、释放时执行。
- `<input type="text" onchange="jscode" />`：改变内容时执行。

## 15. 提示框

- `alert("消息框")`。
- `confirm("您确认提交吗？")`，返回 `true / false`。
- `prompt("请输入字符串", "")`，第二个参数是初始字符串，点取消返回 `null`。

## 16. canvas

```html
<canvas id="painter" width="100" height=100>
  游览器不支持 canvas 标签
</canvas>
```

```js
let ctx = document.getElementById("painter").getContext("2d"); // 获取画布
ctx.fillStyle = "#000000"; // 填充颜色等 (get, set)
ctx.strokeStyle = "#000000"; // 线条颜色等 (get, set)

// 画一个矩形
ctx.rect(x, y, w, h); // 不知道什么意思
ctx.fillRect(x, y, w, h); // 内部
ctx.strokeRect(x, y, w, h); // 边框

// 画一条 1 -> 2 -> 3 的折线（其实会生成一个路径，ctx.fill() 填充内部）
ctx.lineWidth = 1; // 线条宽度 (get, set)
ctx.beginPath(); // 重置路径
ctx.moveTo(x1, y1);
ctx.lineTo(x2, y2);
ctx.lineTo(x3, y3);
ctx.stroke(); // 绘制线条

// 画一条圆心半径 (x, y, r) 从 angle1 到 angle2 弧度
ctx.beginPath();
ctx.arc(x, y, r, angle1, angle2);
ctx.arc(x, y, r, 0, Math.PI * 2); // 圆
ctx.stroke();

// 绘制文本 s
ctx.font = "30px Arial"; // (get, set)
ctx.textAlign = "center"; // 水平对齐方式 (get, set)
ctx.fillText(s, x, y); // 实心文本
ctx.strokeText(s, x, y); // 空心文本
ctx.measureText(s).width; // 拿到文本的宽度

// drawImage, getImageData, putImageData
```

## 17. cookie

document.cookie 查看和修改

永久有效：`ok=233; Secure; expires=Fri, 31 Dec 9999 23:59:59 GMT;`

## 18. math.js

```js
math.e, math.pi
math.add
math.subtract
math.multiply
math.pow(2, 2)
math.derivative('x^2 + x', 'x')) // 导数, 2 * x + 1
math.format(value, precision) // 浮点格式化
math.complex(1, 2) // 生成复数
math.parse("x + 2").evaluate({x: 2}) // 4
math.simplify("x + 2").evaluate({x: 2}) // 4
```

下面的好用度保留

```js
const parser = math.parser();
parser.evaluate("f(x) = x + 2; f(2)") // 未知类型 分析过的变量或函数会一直保留
parser.evaluate("x = 2; x + 2") // 未知类型
```

## 19. WebSocket 客户端

`var ws = new WebSocket("ws://localhost:8000");`

- `ws.readyState` 返回当前状态，共 4 个值：
  - `WebSocket.CONNECTING` 正在连接
  - `WebSocket.OPEN` 通讯中
  - `WebSocket.CLOSING` 正在关闭
  - `WebSocket.CLOSED` 已经关闭或连接失败

连接成功的回调函数

- `ws.onopen = function() {};`
- `ws.addEventListener("open", func);` 可以指定多个回调函数。

关闭后的回调函数

- `ws.onclose = function(event) {};` event 有 code, reason 等属性。
- `ws.addEventListener("close", func);`

收到服务器数据的回调函数

- `ws.onmessage = function(event) {};` event 有 data 属性表示内容。
- `ws.addEventListener("message", func);`
- 收到的数据可能是 string 也可能是二进制 blob、ArrayBuffer。

发送数据

- `ws.send(data)`，可以是 string 也可以是 blob、ArrayBuffer。
- 用 `ws.bufferedAmount`（没有括号）表示还有多少字节没有发送。`=== 0` 判断是否完成发送。

报错的回调函数

- `ws.onerror = function(event) {};` event 内容待补。
- `ws.addEventListener("error", func);`
