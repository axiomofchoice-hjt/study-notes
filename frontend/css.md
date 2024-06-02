# css

- [1. block / inline](#1-block--inline)
- [2. 添加样式的方式](#2-添加样式的方式)
- [3. CSS 选择器](#3-css-选择器)
- [4. 伪类](#4-伪类)
- [5. 伪元素](#5-伪元素)
- [6. 样式合并冲突机制](#6-样式合并冲突机制)
- [7. 值类别](#7-值类别)
- [8. 盒模型](#8-盒模型)
- [9. 浮动和清除](#9-浮动和清除)
- [10. 定位](#10-定位)
- [11. 背景](#11-背景)
- [12. 字体](#12-字体)
- [13. 文本](#13-文本)
- [14. 布局](#14-布局)
- [15. 界面组件：左侧边栏](#15-界面组件左侧边栏)
- [16. 横向菜单](#16-横向菜单)
- [17. 下拉菜单](#17-下拉菜单)

## 1. block / inline

display 样式

- block（块级元素）的宽度和父元素同宽。
- inline（行内元素）会尽可能收缩内容。
- none 不显示也不占用文档流。

body 元素与窗口同宽，但是有外间距（？）。

## 2. 添加样式的方式

- 行内样式：`<p style="">...</p>`。
- 嵌入样式：在 `<head>` 中写入 `<style>` 标签。
- 链接样式：`<link href="styles.css" rel="stylesheet" type="text/css" />`
- import 指令：`@import url(styles2.css)`，需要出现在其他样式之前。

样式规则：`p, h1 { color: red; }`

- `p, h1` 是选择符。
- `color` 是属性。
- `red` 是值。
- 允许多条规则引用给一个选择符。

## 3. CSS 选择器

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

## 4. 伪类

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

## 5. 伪元素

用 `x::first-letter { ... }` 来渲染。

- first-letter：段落首字母。（`p::first-letter { font-size:300%; }` 放大 300%）
- first-line：段落第一行。
- before, after：在前 / 后添加特定元素。（？）

## 6. 样式合并冲突机制

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

## 7. 值类别

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

## 8. 盒模型

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

## 9. 浮动和清除

`float: left;`

图片浮动后，文字边框什么的不受影响，但是文字却绕着它显示（图片的外边框可以与文字保持距离，但是文字的外边框不行）。

浮动元素必须有确定的宽度（图片有默认宽度可不声明）。

浮动元素会始终找最靠上的位置，在多个靠上位置中，left 找最靠左的，right 找最靠右的。

浮动元素可能不被父元素包裹，可以考虑：

- 为浮动元素的父元素设置 `overflow:hidden;` 强制包裹浮动元素。（该声明本来是用来隐藏溢出的内容的）
- 浮动父元素（`float:left; width=100%;`），下一元素清除浮动。
- 父元素内末尾添加 `<div style="clear: both;"><div>`，内容为空。也可以用伪元素 after（略）。这个方法对没有父元素也有效，适用性也最好。

`clear: left` 表明元素左边不能出现浮动元素，`right, both` 同理。

## 10. 定位

`position: static, relative, absolute, fixed`。

- static（默认）静态定位，处于文档流中。
- relative 相对定位，处于文档流中，但显示时通过 top 和 left 相对与原来位置定位。
- absolute 绝对定位，相对于父元素定位。
- fixed 固定定位，相对于窗口定位。

## 11. 背景

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

## 12. 字体

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

## 13. 文本

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

## 14. 布局

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

## 15. 界面组件：左侧边栏

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

## 16. 横向菜单

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

## 17. 下拉菜单

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
