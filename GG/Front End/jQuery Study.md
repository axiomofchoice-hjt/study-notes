# jQuery

- [1. 选择器](#1-选择器)
- [2. 操作 DOM 内容](#2-操作-dom-内容)
- [3. 操作 DOM 结构](#3-操作-dom-结构)
- [4. 事件](#4-事件)
- [5. 动画](#5-动画)
- [6. Ajax](#6-ajax)

## 1. 选择器

- `$("#id")` 按 id 查找。
- `$("tag")` 按 tag 查找。
- `$(".class")` 按 class 查找。
- `$("[name='email']")` 按属性查找（属性值有时可用不引号）。
- `$("[name^='pre']")` 属性值前缀，`$("[name$='post']")` 属性值后缀。
- `$(".c1.c2")` 写在一起表示交集，`$("p,div")` 逗号表示并集。
- `$("ul.c1 li.c2")` 空格表示在前者的子树中查找后者（层级选择器）。
- `$("ul.c1>li.c2")` 大于号表示在前者的儿子中查找后者（子选择器）。
- `$("ul.c1 li:nth-child(2)")` 第 2 个儿子（过滤器）（懵逼）。
- `obj.find(".c1")` 在 jQuery 对象的子树中查找。
- `obj.parent()` 返回父亲。
- `obj.next(), obj.prev()` 返回下 / 上一个兄弟。
- `obj.filter(".c1")` 在数组中筛选。
- `obj.first(), obj.last()` 返回数组第一个元素 / 最后一个元素。

## 2. 操作 DOM 内容

- html
  - `obj.html(), obj.text()` 获取内容。
  - `obj.html("htmlcode"), obj.text("text")` 修改内容（会操作数组中所有节点）。
- css
  - `obj.css("css")`，获取 css。
  - `obj.css("background-color", "#FFFFFF").css("color", "#000000").css(cssobj)`，修改 css。
  - `obj.width(), obj.height(), obj.width(400), obj.height(200)` 获取、修改宽高。
- class
  - `obj.hasClass("class")` 询问 class。
  - `obj.addClass("class")` 添加 class。
  - `obj.removeClass("class")` 删除 class。
- 属性
  - `obj.attr("name")` 获取属性值。
  - `obj.attr("name", "Alice")` 修改属性值。
  - `obj.removeAttr("name")` 删除属性。
  - `obj.is(":checked" / ":selected")` 比较特殊的两个属性。
- value
  - `obj.val()` 获取 value。
  - `obj.val("value")` 修改 value。

## 3. 操作 DOM 结构

- `obj.append("htmlcode" / obj2)` 添加儿子至末尾（最前用 `prepend`）。传入 obj2 将会移动而非复制。
- `obj.after("htmlcode" / obj2)` 往后添加兄弟（往前用 `before`）。移动语义同理。
- `obj.remove()` 删除。

## 4. 事件

- `obj.click(func)` 单击。（或用 obj.on）
- `dblclick` 双击。
- `mouseenter` 鼠标进入。
- `mouseleave` 鼠标移出。
- `mousemove` 鼠标在 DOM 内移动。func(e) 可获取鼠标位置 `e.pageX, e.pageY`。
- `hover` 鼠标进入或移出。
- `keydown` 键盘按下。
- `keyup` 键盘松开。
- `keypress` 键盘按一次键。func(?) 可获取按键的值（空缺）。
- `focus` 获得焦点。
- `blur` 失去焦点。
- `change` 内容改变（input, select, textarea）。
- `submit` 提交（form）。
- `ready` DOM 树完成初始化（document）。可以简化成 `$(func)`。
- 取消绑定 `obj.off("click")`。（可以取消单个函数，但是有点麻烦）
- 手动触发事件 `obj.click()`。（或用 obj.trigger）

## 5. 动画

- `obj.show(), obj.hide(), obj.toggle()` 显示 / 隐藏 / 切换显示状态。传入参数 time（毫秒 / `"slow"`）会变成展示动画。
- `obj.slideDown(time), obj.slideUp(time), obj.slideToggle(time)` 拉窗帘。
- `obj.fadeIn(time), obj.fadeOut(time), obj.fadeToggle(time)` 淡入淡出。
- `obj.animate(css, time)` 参数是最终状态的 css 和毫秒，实现渐变。
- `obj.delay(time)` 一种不动的动画。
- `obj.stop()` 停止所有动画。
- 参数最后可以写个函数（`$(this)` 获取对象），动画结束时执行。
- 串行动画：`obj.delay(1000).show(1000).hide(1000)`。
- 动画没有执行，可能是 css 中对应样式没作用。

## 6. Ajax

ajax:（通用请求）

```JS
let jqxhr = $.ajax("/path", {
  method: "GET", // 请求类型
  data: {}, // 字符串、数组或对象
  contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // POST 请求的格式
  headers: {}, // 额外的 HTTP 头
  dataType: "html" // 接收的数据格式
});
```

get:（下面例子的实际 URL 是 `/path?name=Bob&check=1`）

```JS
let jqxhr = $.get("/path", {
  name: "Bob",
  check: 1
});
```

post:

```JS
let jqxhr = $.post("/path", {
  name: "Bob",
  check: 1
});
```

getJson:

```JS
var jqxhr = $.getJSON('/path', {
    name: 'Bob Lee',
    check: 1
}).done(function (data) {
    // data已经被解析为JSON对象了
});
```

接受到的 jqXHR 对象类似 Promise 对象，要用回调函数处理：

```JS
jqxhr.done(function (data) { // 请求成功后执行，接收的内容为 data
  alert(data);
}).fail(function (xhr, status) { // 请求失败后执行
  alert(xhr.status + " " + status);
}).always(function () { // 请求完成后执行

});
```
