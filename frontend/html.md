# html

- [1. 基本格式](#1-基本格式)
- [2. body 部分](#2-body-部分)
- [3. HTML 实体](#3-html-实体)

## 1. 基本格式

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

## 2. body 部分

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

## 3. HTML 实体

`&` 开头，`;` 结尾。
