# WebStudy

- [WebStudy](#webstudy)
  - [HTML](#html)
    - [基本格式](#基本格式)
    - [body 部分](#body-部分)
    - [HTML 实体](#html-实体)
  - [CSS](#css)
    - [block / inline](#block--inline)
    - [添加样式的方式](#添加样式的方式)
    - [CSS 选择器](#css-选择器)
    - [伪类](#伪类)
    - [伪元素](#伪元素)
    - [样式合并冲突机制](#样式合并冲突机制)
    - [值类别](#值类别)
    - [盒模型](#盒模型)
    - [浮动和清除](#浮动和清除)
    - [定位](#定位)
    - [背景](#背景)
    - [字体](#字体)
    - [文本](#文本)
    - [布局](#布局)
    - [界面组件：左侧边栏](#界面组件左侧边栏)
    - [横向菜单](#横向菜单)
    - [下拉菜单](#下拉菜单)
  - [JavaScript](#javascript)
    - [字符串](#字符串)
    - [数组](#数组)
    - [对象](#对象)
    - [Map](#map)
    - [Set](#set)
    - [函数](#函数)
    - [类型](#类型)
    - [class](#class)
    - [Date](#date)
    - [JSON](#json)
    - [BOM](#bom)
    - [DOM](#dom)
    - [表单](#表单)
    - [JS 事件](#js-事件)
    - [提示框](#提示框)
    - [canvas](#canvas)
    - [cookie](#cookie)
  - [math.js](#mathjs)
  - [jQuery](#jquery)
    - [选择器](#选择器)
    - [操作 DOM 内容](#操作-dom-内容)
    - [操作 DOM 结构](#操作-dom-结构)
    - [事件](#事件)
    - [动画](#动画)
    - [Ajax](#ajax)
  - [TypeScript](#typescript)
    - [类型声明](#类型声明)
    - [类](#类)
  - [WebSocket](#websocket)
    - [客户端](#客户端)
  - [nodejs](#nodejs)
  - [node-webkit](#node-webkit)
  - [uni-app](#uni-app)
  - [Vue 2/3](#vue-23)
    - [运行](#运行)
    - [单文件组件](#单文件组件)
    - [.html 文件基本构成](#html-文件基本构成)
    - [响应式](#响应式)
    - [组件](#组件)
    - [生命周期钩子](#生命周期钩子)
    - [插值](#插值)
    - [指令 Attribute](#指令-attribute)
    - [v-事件](#v-事件)
    - [计算属性](#计算属性)
    - [监视属性](#监视属性)
    - [绑定样式](#绑定样式)
    - [vue 表单](#vue-表单)
    - [自定义指令](#自定义指令)
    - [ref](#ref)
    - [props 配置](#props-配置)
    - [混合 mixin](#混合-mixin)
    - [自定义插件](#自定义插件)
    - [css scoped](#css-scoped)
    - [vue-axios](#vue-axios)
    - [vue-router](#vue-router)
    - [vuex store](#vuex-store)

## HTML

### 基本格式

注释：`<!-- 注释 -->`

```HTML
<!DOCTYPE html> <!-- 声明版本(HTML5) -->
<html>
<head>
  <meta charset="utf-8"> <!-- 声明编码(UTF-8) -->
  <title>
    Title
  </title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://underscorejs.org/underscore-min.js"></script>
</head>
<body>
  <p>
    Hello world
  </p>
</body>
</html>
```

### body 部分

```html
<H1> 一级标题 </H1>
<H2 style="text-align:center;"> 二级标题 + 居中 </H2>
<p style="font-family:consolas;color:rgb(0, 0, 0);background-color:Yellow;font-size:20px;">
  字体样式
</p>
<hr/> <!-- 分割线 -->
<div> <!-- 划分出一块作为整体，有换行效果 -->
  <b>粗体</b> <i>斜体</i> <ins>下划线</ins> <del>删除线</del> <pre>code</pre>
</div>
<div>
  <small>小字体</small>
</div>
<span> <!-- 划分出一块作为整体，无换行效果 -->
  <sub>下标</sub>
</span>
<span>
  <sup>上标</sup>
</span>
<br/> <!-- 换行 -->
<img src="https://cdn.jsdelivr.net/gh/Tsuk1ko/moe-project/bilibili/bg.png" alt="加载失败时显示的文字"/> <!-- 图片 -->
<a href="https://www.luogu.com.cn/"> 超链接 </a>
<table border="1"> <!-- 表格，border 取 "1" 或 "0" -->
  <tr> <!-- 表格的行 -->
    <th> A </th> <!-- th 是表格的表头，有加粗、居中效果 -->
    <td> B </td> <!-- 表格的单元 -->
    <td rowspan="2"> C </td> <!-- rowspan 跨几列 -->
  </tr>
  <tr>
    <td colspan="2"> D </td> <!-- colspan 跨几行 -->
  </tr>
</table>
<ul> <!-- 无序列表 -->
  <li> 无序列表 1 </li>
  <li> 无序列表 2 </li>
</ul>
<ol> <!-- 有序列表 -->
  <li> 有序列表 1 </li>
  <li> 有序列表 2 </li>
</ol>
```

### HTML 实体

`&` 开头，`;` 结尾。

## CSS

### block / inline

display 样式

- block（块级元素）的宽度和父元素同宽。
- inline（行内元素）会尽可能收缩内容。
- none 不显示也不占用文档流。

body 元素与窗口同宽，但是有外间距（？）。

### 添加样式的方式

- 行内样式：`<p style="">...</p>`。
- 嵌入样式：在 `<head>` 中写入 `<style>` 标签。
- 链接样式：`<link href="styles.css" rel="stylesheet" type="text/css" />`
- import 指令：`@import url(styles2.css)`，需要出现在其他样式之前。

样式规则：`p, h1 { color: red; }`

- `p, h1` 是选择符。
- `color` 是属性。
- `red` 是值。
- 允许多条规则引用给一个选择符。

### CSS 选择器

- `#id` 按 id 查找。
- `tag` 按 tag 查找。
- `.class` 按 class 查找。
- `[name='email']` 按属性查找（属性值有时可用不引号）。
- `[name^='pre']` 属性值前缀，`[name$='post']` 属性值后缀。
- `.c1.c2` 写在一起表示交集，`p,div` 逗号表示并集。
- `ul.c1 li.c2` 空格表示在前者的子树中查找后者（层级选择器）。
- `ul.c1>li.c2` 大于号表示在前者的儿子中查找后者（子选择器）。
- `li+li` 加号表示在前者的右兄弟中查找第一个后者

如果 `<a href="#">...</a>`，点击它会回到顶部。如果井号后有其他 ID 会到下文对应位置。

### 伪类

用 `x:Hover { ... }` 来渲染。新版可能要用双冒号。

- 链接伪类：
  - Link（？）
  - Visited 用户此前点击过。
  - Hover 鼠标悬停。
  - Active 在上面按住鼠标。
- focus：点击它后获得焦点。
- target：同一页面跳转后的目标。
- 结构化伪类：
  - first-child, last-child, nth-child(x) 虽然由于但是出现在这里总觉得不对劲。

### 伪元素

用 `x::first-letter { ... }` 来渲染。

- first-letter：段落首字母。（`p::first-letter { font-size:300%; }` 放大 300%）
- first-line：段落第一行。
- before, after：在前 / 后添加特定元素。（？）

### 样式合并冲突机制

继承：子元素继承自父元素。

层叠：

- 游览器默认样式表
- 用户样式表
- 链接样式
- 嵌入样式
- 行内样式

层叠特指数：I-C-E，即 ID 选择符 > 类选择符 > 标签选择符。

特指数相同，选择位置靠下的。

`p {color:green !important; font-size:12pt;}` 可以防止样式被覆盖。

### 值类别

文本值：特定于属性。

数字值：

- 绝对值，一般指像素 `*px`。
- 相对值
  - 百分比 `*%`
  - 字母 M 的宽度 `*em`（由字体和 em 共同决定）
  - 字母 x 的高度 `*ex`（由字体和 ex 共同决定）

颜色值：

- 颜色名 red 等。
- 十六进制颜色 `#RRGGBB / #RGB`
- RGB 颜色值 `rgb(r, g, b)`
- RGB 百分比值 `r%, g%, b%`
- HSL 色相、饱和度、亮度 `HSL(*, *%, *%)`
- Alpha 通道（不透明度）（？）

### 盒模型

属性

- 边框 border
- 内边距 padding（内容与边框的间距）
- 外边距 margin（边框与相邻元素的间距）

边距简写：`margin: *px *px *px *px;` 顺时针一圈（即 top, right, bottom, left）。如果只写了两个值，第一个值表示 top \& bottom，第二个值表示 right \& left。如果只写一个值，表示四个属性。

边框

- 宽度 border-width
  - thin, medium, thick（实际宽度因游览器而异）
  - `*px`
- 样式 border-style
  - none, hidden, dotted, dashed, solid, double, groove, ridge, inset, outset（虚线 dashed 具体样式因游览器而异）
- 颜色 border-color
- border-radius（待补）

边框简写：`border: 4px solid #F33`，4 个边的宽度也能顺时针声明。

元素的默认内 / 外边距因游览器而异。可以考虑用 reset.css 来统一。

垂直的相邻元素外边距会重叠（取较大值）。水平的相邻元素外边距不重叠（取两者之和）。

- 不显式声明宽度的块级元素，边框宽度、内边距、外边距都会影响元素宽度。
- 显式声明宽度的元素，宽度仅表示内容区。（边框框住的宽度 = width + padding-left + padding-right）

### 浮动和清除

`float: left;`

图片浮动后，文字边框什么的不受影响，但是文字却绕着它显示（图片的外边框可以与文字保持距离，但是文字的外边框不行）。

浮动元素必须有确定的宽度（图片有默认宽度可不声明）。

浮动元素会始终找最靠上的位置，在多个靠上位置中，left 找最靠左的，right 找最靠右的。

浮动元素可能不被父元素包裹，可以考虑：

- 为浮动元素的父元素设置 `overflow:hidden;` 强制包裹浮动元素。（该声明本来是用来隐藏溢出的内容的）
- 浮动父元素（`float:left; width=100%;`），下一元素清除浮动。
- 父元素内末尾添加 `<div style="clear: both;"><div>`，内容为空。也可以用伪元素 after（略）。这个方法对没有父元素也有效，适用性也最好。

`clear: left` 表明元素左边不能出现浮动元素，`right, both` 同理。

### 定位

`position: static, relative, absolute, fixed`。

- static（默认）静态定位，处于文档流中。
- relative 相对定位，处于文档流中，但显示时通过 top 和 left 相对与原来位置定位。
- absolute 绝对定位，相对于父元素定位。
- fixed 固定定位，相对于窗口定位。

### 背景

背景图片显示在背景颜色上面。

- background-color: 背景颜色
- background-image: 背景图片 url
- background-repeat: no-repeat, repeat, repeat-x, repeat-y 是否向某些方向延伸
- background-position: (top, bottom, center) (left, right, center) 背景起点，一共 9 个位置。也可以用两个百分比数，50% 表示 center。
- background-size: 两个像素表示图片大小。百分比表示相对于背景区的大小。cover 表示填满，保持宽高比。contain 表示不超出范围的最大图片，保持宽高比。
- background-attachment: scroll, fixed 滚动元素的背景是否随之滚动。
- background（简写属性）可以一次设定上述所有值。

多个背景，先列出的图片在上层：

```css
background:
  url(images/turq_spiral.png) 30px -10px no-repeat, 
  url(images/pink_spiral.png) 145px 0px no-repeat, 
  url(images/gray_spiral.png) 140px -30px no-repeat, #ffbd75;
```

背景渐变：略

### 字体

三种字体来源：

- 用户机器中的字体
- 第三方网站上的字体（用 `link`）
- Web 服务器上的字体（用 `@font-face`）

字体相关的属性：

- font-famity 使用什么字体。
  - 字体栈：列出多个字体，逗号隔开，前面的不能用就用后面的。
  - 字体栈最后一个字体要选通用字体（应该是满足要求的字体里随便挑一个），包括：
    - serif 衬线字体，笔画末端有装饰线
    - sans-serif 无衬线字体，笔画末端无装饰线
    - monospace 等宽字体
    - cursive 草书体（手写体）
    - fantasy 奇怪形状的字体
  - 倒数第二个字体要选用户机器内置的字体，包括：
    - 衬线字体
      - Georgia
      - Palatino / Book Anitqua
      - Times New Roman
    - 无衬线字体
      - Arial
      - Arial Black
      - Arial Narrow
      - Tahoma
      - Trebuchet MS
      - Verdana
    - 等宽字体
      - Courier New
      - Lucida Console / Monaco
    - 草书体 Comic Sans MS
    - 奇怪体 Impact
- font-size 字体大小，可继承
  - 绝对字体大小 `*px`，或者 `x-small / medium / x-large`（？）
  - 相对字体大小 百分比、em、rem
- font-style 斜体还是正体，可以用 `<em>` 替代
  - italic 斜体（或 oblique）
  - normal 正体
- font-weight 字体粗细，可以用 `<strong>` 替代
  - normal、bold
- font-variant 字体变化，small-caps 可以将小写英文字母变成小型大写字母（？？？）
  - small-caps、normal
- font 简写属性
  - 规则一：必须声明 font-size 和 font-family
  - 规则二：先声明 (weight, style, variant)，然后 font-size，最后 font-family

### 文本

文本属性：

- text-indent 段落缩进，往右缩进的长度值（正负都可）
- letter-spacing 字符间距，正值增大间距，负值减小间距
- word-spacing 单词间距，正负都可
- text-decoration 文本装饰
  - underline 下划线
  - overline 上划线
  - line-through 上划线和下划线
  - blink 删除线
  - none
- text-align 文本对齐
  - left 左对齐
  - right 右对齐
  - center 居中对齐
  - justify 两端对齐（平均分）
- line-height 行高，比较复杂，用百分比就完了
  - 大于 1 增加行的间距，小于 1 减少行的间距
- text-transform 转换大小写
  - uppercase 全大写
  - lowercase 全小写
  - capitalize 单词首字母大写
- vertical-align 垂直对齐，可以实现上标和下标
  - 百分比、`sub / super / top / middle / bottom`

### 布局

- 固定宽度布局：比较适合的宽度为 960 像素（900 - 1100）
- 流动布局：随用户调整游览器窗口大小而变化。比如导航页在网页变窄时收缩。
- 弹性布局：窗口变宽时，布局和元素大小都发生变化。

固定宽度布局：

- 最外面的元素 `margin: 0 auto;` 实现居中，不要动 position 的值。
- 分栏元素 `float: left;` 并设置宽度，宽度之和等于父元素宽度，可以从左到右排列（但是高度不一致）。
- 页脚 `clear: both;`，保证在所有浮动元素下面。
- 综上有：

```html
<style>
    .wrapper { margin: 0 auto; width: 200px; background-color: grey; }
    header { background-color: lightcoral; }
    nav { float: left; width: 40px; background-color: red; }
    article { float: left; width: 120px; background-color: green; }
    aside { float: left; width: 40px; background-color: blue; }
    footer { clear: both; background-color: chocolate; }
</style>
<div class="wrapper">
    <header>header</header>
    <nav>nav</nav><article>article<br>article</article><aside>aside</aside>
    <footer>fotter</footer>
</div>
```

分栏元素增加 padding 会改变布局：

- 重设 width 来抵消影响。（比较麻烦）
- 容器套 div，并设置 padding。
- `* { box-sizing: border-box; }` 让每个元素的 width 包含 padding 和 border。

`word-wrap: break-word` 将过长的单词断开。

display: table-cell...

### 界面组件：左侧边栏

- 用无序列表 ul > li 内放链接 a 的方式。
- `* { margin: 0; padding: 0; }`。
- 设置 nav 的宽度。
- 设置 ul 的边框。
- 设置链接之间的分割线 `li+li a { border-top: 1px solid black }`
- 设置 li `list-style-type: none;`，取消点。
- 设置 a `display: block;`，使得点击范围变为整行。
- 设置 a `text-decoration: none;`，取消下划线，颜色也可改掉。
- 设置 a 的伪元素（悬浮，点击）。

```html
<nav class="list3">
  <ul>
    <li><a href="#">Alternative</a></li>
    <li><a href="#">Country</a></li>
    <li><a href="#">Jazz</a></li>
    <li><a href="#">Rock</a></li>
  </ul>
</nav>
```

```css
.list3 ul {
  border: 1px solid #f00;
  border-radius: 3px;
  padding: 5px 10px 3px;
}

.list3 li {
  list-style-type: none;
}

.list3 li+li a {
  border-top: 1px solid #f00;
}

.list3 a {
  text-decoration: none;
  font: 20px 'Exo', helvetica, arial, sans-serif;
  font-weight: 400;
  color: #000;
  padding: 3px 10px;
  display: block;
}

.list3 a:hover {
  color: #069;
}
```

### 横向菜单

- 用 ul li 来做菜单，浮动让菜单变横向。

```html
<nav class="list1">
  <ul>
    <li><a href="#">A</a></li>
    <li><a href="#">B</a></li>
    <li><a href="#">C</a></li>
    <li><a href="#">D</a></li>
    <li><a href="#">E</a></li>
  </ul>
</nav>  
```

```css
* {margin:0; padding:0;}
nav {font:16px helvetica, arial, serif; overflow:hidden; margin:20px 50px;}
.list1 ul {overflow:hidden;} 
.list1 li {
  float:left;
  list-style-type:none; 
}
.list1 a {
  display:block;
  padding:0 16px;
  text-decoration:none;
  color:#999;
}
.list1 li + li a {border-left:1px solid #aaa;}
.list1 a:hover {color:#555;}
```

### 下拉菜单

- 很复杂

```html
<nav class="multi_drop_menu">
  <ul>
    <li>
      <a href="#">Power</a> <!-- 一级，且有下拉菜单 -->
      <ul>
        <li><a href="#">Corporate</a></li> <!-- 二级 -->
        <li>
          <a href="#">Political</a> <!-- 二级，且有下拉菜单 -->
          <ul>
            <li><a href="#">Senator</a></li> <!-- 三级 -->
            <li><a href="#">Representative</a></li> <!-- 三级 -->
          </ul>
        </li>
      </ul>
    </li>
    <li>
      <a href="#">Money</a> <!-- 一级 -->
      <ul>
        <li><a href="#">Business</a></li> <!-- 二级 -->
        <li><a href="#">Inheritence</a></li> <!-- 二级 -->
      </ul>
    </li>
  </ul>
</nav>
```

```css
.multi_drop_menu {
  font: 1em helvetica, arial, sans-serif;
  /* font color and size */
}

.multi_drop_menu a {
  display: block;
  color: #555;
  /* text color */
  background-color: #eee;
  /* background color */
  padding: .2em 1em;
  /* padding around link text */
  border-width: 3px;
  /* divider width */
  border-color: transparent;
  /* divider color - can be 'transparent' */
}

.multi_drop_menu li:hover>a {
  color: #fff;
  /* hover text color */
  background-color: #aaa;
  /* hover background color */
}

.multi_drop_menu li a:active {
  background: #fff;
  /* b/g hilite when clicked */
  color: #ccc;
  /* text color hilite when clicked */
  background-clip: padding-box;
  /* prevents border hiliting */
}

.multi_drop_menu li ul {
  width: 9em;
}

/* width of 2nd, 3rd level menus */
.multi_drop_menu li li a {
  border-right-style: none;
  border-top-style: solid;
}

.multi_drop_menu li li li a {
  border-left-style: solid;
}

/* for vertical top level meneu - add 'vertical' class to nav */
.multi_drop_menu.vertical {
  width: 8em;
}

/* top level menu width (vertical only) */
.multi_drop_menu.vertical li a {
  border-right-style: none;
  border-top-style: solid;
}

.multi_drop_menu.vertical li li a {
  border-left-style: solid;
}

/* "FUNCTIONAL" STYLINGS - ADJUST WITH CARE! */
/* level 1 */
.multi_drop_menu * {
  margin: 0;
  padding: 0;
}

.multi_drop_menu ul {
  float: left;
}

/* forces ul to enclose floated li elements */
.multi_drop_menu li {
  float: left;
  /* makes menu horizontal */
  list-style-type: none;
  /* removes default bullets off lists */
  position: relative;
  /* position context for child list */
}

.multi_drop_menu li a {
  display: block;
  /* makes link fill li */
  border-right-style: solid;
  /* adds a right border on the links */
  background-clip: padding-box;
  /* background only under padding, not border */
  text-decoration: none;
  /* removes link underlining */
}

.multi_drop_menu li:last-child a {
  border-right-style: none;
}

/* level 2*/
.multi_drop_menu li ul {
  display: none;
  /* hides levels 2, 3, etc. */
  position: absolute;
  /* position relative to parent menu */
  left: 0;
  /* aligns left of sub-menu to parent */
  top: 100%;
  /* aligns to bottom of parent */
}

.multi_drop_menu li:hover>ul {
  display: block;
  /* displays menu when parent hovered */
}

.multi_drop_menu li li {
  position: relative;
  /* position context for child list */
  float: none;
  /* kills inherited float - makes list stack */
}

/* level 3 */
.multi_drop_menu li li ul {
  position: absolute;
  /* position relative to parent menu */
  left: 100%;
  /* aligns menu with right of parent */
  top: 0;
  /* aligns with parent menu choice top */
}

/* for vertical top level, add 'vertical' class to nav */
.multi_drop_menu.vertical ul,
.multi_drop_menu.vertical li {
  float: none;
  /* makes top level menu vertical */
}

.multi_drop_menu.vertical li ul {
  left: 100%;
  /* aligns level 2 menu to right of level 1 */
  top: 0;
  /* aligns sub-menu with top of menu choice */
}
```

## JavaScript

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

### 字符串

- 字符串常量用单双引号都可。
  - 用反引号，可以换行也可以替换（模板字符串）：\``Hello, ${name}!`\`
- 打印字符串 `console.log(s)`。
- 字符串大小写转换 `toUpperCase(s), toLowerCase(s)`。
- 子串位置 `"123".indexOf("2")`（返回 1），找不到返回 -1。
- 字符串切片 `"12345".substring(1, 3)`（返回 `"23"`）。

### 数组

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

### 对象

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

### Map

- 定义 `var mp = new Map();`
- 添加 `mp.set(key, value);`
- 删除 `mp.delete(key);`
- 存在 `mp.has(key)`
- 求值 `mp.get(key)`

### Set

- 定义 `var st = new Set();`
- 添加 `st.add(key);`
- 删除 `st.delete(key);`
- 存在 `st.has(key)`

### 函数

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

### 类型

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

### class

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

### Date

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

### JSON

- 键是字符串，用双引号；值有 6 种类型 `number, boolean, string, null, array, object`。
- 对象转换为 JSON 字符串：`JSON.stringify(obj)`。
- JSON 字符串转换为对象：`JSON.parse(s)`

### BOM

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

### DOM

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

### 表单

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

### JS 事件

- `<xx onclick="jscode">`：鼠标点击后执行 js 代码。
- `<xx onmouseover="jscode" onmouseout="jscode">`：鼠标进入、移出时执行。
- `<xx onmousedown="jscode" onmouseup="jscode">`：鼠标在该位置按下、释放时执行。
- `<input type="text" onchange="jscode" />`：改变内容时执行。

### 提示框

- `alert("消息框")`。
- `confirm("您确认提交吗？")`，返回 `true / false`。
- `prompt("请输入字符串", "")`，第二个参数是初始字符串，点取消返回 `null`。

### canvas

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

### cookie

document.cookie 查看和修改

永久有效：`ok=233; Secure; expires=Fri, 31 Dec 9999 23:59:59 GMT;`

## math.js

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

## jQuery

- jQuery 对象类似 DOM 节点的数组。
- `$(element)` DOM 节点转化为 jQuery 对象。
- `obj.get(0)` jQuery 对象转换为 DOM 节点。

### 选择器

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

### 操作 DOM 内容

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

### 操作 DOM 结构

- `obj.append("htmlcode" / obj2)` 添加儿子至末尾（最前用 `prepend`）。传入 obj2 将会移动而非复制。
- `obj.after("htmlcode" / obj2)` 往后添加兄弟（往前用 `before`）。移动语义同理。
- `obj.remove()` 删除。

### 事件

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

### 动画

- `obj.show(), obj.hide(), obj.toggle()` 显示 / 隐藏 / 切换显示状态。传入参数 time（毫秒 / `"slow"`）会变成展示动画。
- `obj.slideDown(time), obj.slideUp(time), obj.slideToggle(time)` 拉窗帘。
- `obj.fadeIn(time), obj.fadeOut(time), obj.fadeToggle(time)` 淡入淡出。
- `obj.animate(css, time)` 参数是最终状态的 css 和毫秒，实现渐变。
- `obj.delay(time)` 一种不动的动画。
- `obj.stop()` 停止所有动画。
- 参数最后可以写个函数（`$(this)` 获取对象），动画结束时执行。
- 串行动画：`obj.delay(1000).show(1000).hide(1000)`。
- 动画没有执行，可能是 css 中对应样式没作用。

### Ajax

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

## TypeScript

### 类型声明

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

函数声明 `function f(x: number): number { ... }`

可选参数 `function f(x: number, y?: number)`，其中 y 是可选参数。

类型别名 `type name = number`

可以函数重载！TSnb！！

接口：略

### 类

```TS
class ClassName {
  private a: number; // 默认 public
  static b: number; // 用 ClassName.b 访问
  constructor() { this.a = 1; }
}
```

## WebSocket

### 客户端

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

## nodejs

`process.exit(0)` 退出

process.stdin 太难了不学了

## node-webkit

将 web 打包成桌面程序。

## uni-app

将 vue 项目打包成微信小程序

创建项目步骤

- `vue create -p dcloudio/uni-preset-vue name` 在当前目录下建立 name 文件夹作为项目文件夹，生成项目。
- 选择默认模板
- `cd name`，`npm run serve`（生成网页）
- 删除 .git 文件夹

`npm run dev:mp-weixin` 生成 `/dist/dev/mp-weixin`，用微信开发工具打开即可。

## Vue 2/3

### 运行

- 游览器运行 `.html` 文件，加载 `<script src="https://unpkg.com/vue@next"></script>`，js 代码里 `Vue.createApp(object).mount("#id")`。

### 单文件组件

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

### .html 文件基本构成

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

### 响应式

- 初始化时，所有对象内的元素都是响应式的。
- 数组内的元素不是响应式的，赋值的方式 `arr[0] = 233` 不会触发动作（可以写成 `arr.splice(0, 1) = 233`，也可以写 `Vue.set(vm.arr, 0, 233)`），但是数组的一些函数会触发：
  - push, pop, shift, unshift
  - splice
  - sort, reverse

### 组件

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

### 生命周期钩子

- 直接在配置里写 mounted 等函数。
- created 函数在一个实例被创建后执行。
- mounted 函数在挂载完后执行。
- 每次 data 变更后执行 updated。（？）
- 析构时执行 unmounted。（？）
- 不要把箭头函数赋值给生命周期钩子，因为箭头函数没有 this 的定义。
- 挂载流程：beforeCreate → 创建 data、methods → created → 模板替换 → beforeMount → 挂载 → mounted
- 更新流程：数据更新 → beforeUpdate → 页面更新 → updated
- 销毁流程：`v-if v-for` 更新 → beforeDestroy → 销毁 → destroyed

### 插值

- `<span>{{ msg }}</span>` 进行文本插值。
- `<span v-once>{{ msg }}</span>` 一次性插值（不动态更新）。

### 指令 Attribute

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

### v-事件

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

### 计算属性

- 写进 methods 里的函数如果被模板调用，任一 data 更新后会再调用一遍该函数。开销较大。
- 写进 computed 里的函数，只会在启动时和依赖改变时调用。（缓存机制）模板的计算属性里不要用小括号。

### 监视属性

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

### 绑定样式

- `<div class="a" v-bind:class="b">`，最终样式会合并为 `"a" data.b`
- 多个动态样式：
  - 用数组 `v-bind:class="arr"`，`arr = ["a", "b", "c"]`。
  - 用对象 `v-bind:class="obj"`，`obj = { "a": true, "b": true, "c": false }`，true 表示应用，false 表示不应用。
- 元素内样式：`<div v-bind:style="obj">`，`obj = { fontSize: 40 + "px" }`。如果多个对象可以用数组来合并，`<div v-bind:style="[obj1, obj2]">`。

### vue 表单

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

### 自定义指令

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

### ref

- `<div ref="r1"></div>`。
- `this.$refs.r1` 拿到真实元素。如果该元素是自定义组件，拿到的是 VueComponent。
- 可以取代 document.getElementById。

### props 配置

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

### 混合 mixin

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

### 自定义插件

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

### css scoped

`<style scoped>` 局部 css，只对这个文件有效。

### vue-axios

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

### vue-router

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

### vuex store

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
