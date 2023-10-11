# Three

- [1. 安装](#1-安装)
- [2. 开始](#2-开始)
- [3. 摄像头](#3-摄像头)
- [4. 渲染](#4-渲染)
- [5. 几何体](#5-几何体)
- [6. 材质](#6-材质)
- [7. 变换](#7-变换)
- [8. 线](#8-线)
- [9. 文字](#9-文字)
- [10. 时钟](#10-时钟)
- [11. 补间动画](#11-补间动画)
- [12. 随手记录](#12-随手记录)

## 1. 安装

```text
npm install --save three
```

```js
import * as THREE from 'three'
```

## 2. 开始

```html
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <!-- <link rel="icon" href="..."> -->
  <title>
    Blockchallenge
  </title>
</head>

<body>
  <canvas id="canvas"></canvas>
</body>

<script src="./js/three.min.js"></script>
<script src="./js/main.js"></script>

<style>
  body {
    margin: 0px;
  }
  canvas {
    position: fixed;
  }
</style>

</html>
```

```js
const canvas = document.getElementById('canvas');

let width = () => (window.innerWidth);
let height = () => (window.innerHeight);

console.log(width(), height());

var scene = new THREE.Scene();

// 创建网格模型
var geometry = new THREE.BoxGeometry(100, 100, 100); // 几何对象
var material = new THREE.MeshLambertMaterial({
    color: 0xdddddd
}); // 材质对象
var mesh = new THREE.Mesh(geometry, material); // 网格模型
scene.add(mesh); // 网格模型添加到场景中

// 点光源
var point = new THREE.PointLight(0xffffff);
point.position.set(400, 200, 300); // 点光源位置
scene.add(point); // 点光源添加到场景中

// 环境光
var ambient = new THREE.AmbientLight(0x444444);
scene.add(ambient);

// 相机设置
var camera = new THREE.PerspectiveCamera(75, width() / height(), 0.1, 1000); // 透视摄像头
camera.position.set(200, 300, 200); // 设置相机位置
camera.lookAt(scene.position); // 设置相机方向

// 创建渲染器对象
var renderer = new THREE.WebGLRenderer({ canvas, antialias: true }); // 打开抗锯齿
renderer.setPixelRatio(window.devicePixelRatio); // 设置设备像素比率
renderer.setSize(width(), height()); // 设置渲染区域
renderer.setClearColor(0x000000, 1); // 设置背景颜色

// 执行渲染操作
renderer.render(scene, camera);

window.onresize = () => {
    renderer.setSize(width(), height());
    camera.aspect = width() / height();
    camera.updateProjectionMatrix();
    renderer.render(scene, camera);
};
```

## 3. 摄像头

```js
var camera = new THREE.PerspectiveCamera( 75, width / height, 0.1, 1000 ); // 透视摄像头
```

PerspectiveCamera 参数

- 视野角度 FOV，单位是角度
- 长宽比，宽除以高
- 近截面，太近的物体就不渲染
- 远截面，太远的物体就不渲染

## 4. 渲染

在渲染时可以直接 `renderer.render(scene, camera);` 渲染，也可以

```js
let clock = new THREE.Clock();
let mainLoop = () => {
  requestAnimationFrame( mainLoop );
  let delta = clock.getDelta() // 渲染时间间隔，getDelta 方法必须只调用一次
  // 可以在这里修改物体的状态
  renderer.render( scene, camera );
}
mainLoop();
```

requestAnimationFrame 是一个动画循环，适合游戏的渲染

在修改物体的状态时，场景是自动更新的，可以对静态物体 `object.matrixAutoUpdate = false;` 来关闭

## 5. 几何体

- 盒子 `new THREE.BoxGeometry(width, height, depth)`
- 圆 `new THREE.CircleGeometry(radius, segments)`
  - segments 表示用几个三角形来近似
  - 扇形 `new THREE.CircleGeometry(radius, segments, Math.PI * 0.25, Math.PI * 0.75)`
- 受挤压的 2D 图形 ExtrudeGeometry
- 绕着一条线旋转形成的形状 LatheGeometry
- 用函数生成表面 ParametricGeometry
- 平面 `new THREE.PlaneGeometry(width, height)`
- 2D 图形 ShapeGeometry
- 球 `new THREE.SphereGeometry(radius, widthSegments, heightSegments)`

```js
// 创建网格模型
var geometry = new THREE.BoxGeometry(100, 100, 100); // 几何体
var material = new THREE.MeshLambertMaterial({
  color: 0x0000ff
}); // 材质对象
var mesh = new THREE.Mesh(geometry, material); // 网格模型
scene.add(mesh); // 网格模型添加到场景中
```

## 6. 材质

MeshBasicMaterial 不受光照的影响。MeshLambertMaterial 只在顶点计算光照，而 MeshPhongMaterial 则在每个像素计算光照。MeshPhongMaterial 还支持镜面高光。

MeshToonMaterial 与 MeshPhongMaterial 类似，但有一个很大的不同。它不是平滑地着色，而是使用一个渐变图（一个X乘1的纹理（X by 1 texture））来决定如何着色。

更改材质：假设是立方体，直接 `mesh.material[4] = ...`

## 7. 变换

- 平移 `mesh.position.set(x, y, z)` / `mesh.position.x = x`
- 缩放 `mesh.scale.set(x, y, z)` / `mesh.scale.x = x`
- 旋转 `mesh.rotation.set(x, y, z)` / `mesh.rotation.x = x`
  - 是一个欧拉对象，另有属性旋转顺序
  - 旋转顺序：默认 `XYZ`，先对 x 轴旋转，再 yz。可以修改

## 8. 线

```js
const material = new THREE.LineBasicMaterial({ color: 0x0000ff });

const points = [];
points.push(new THREE.Vector3(-10, 0, 0));
points.push(new THREE.Vector3(0, 10, 0));
points.push(new THREE.Vector3(10, 0, 0));

const geometry = new THREE.BufferGeometry().setFromPoints(points); // 注意线条不是闭合的

const line = new THREE.Line(geometry, material);

scene.add(line);
```

## 9. 文字

需要在 canvas 上绘制

## 10. 时钟

`const clock = THREE.Clock();`

- 有 ordTime 属性，保存上次打点的时刻
- `.getElapsedTime()` 时钟运行的总时长，会打点
- `.getDelta()` 上次打点到现在的时间间隔，会打点

## 11. 补间动画

`npm install --save gsap`

- `import gsap from 'gsap'`
- `gsap.to(box.position, { x: 5, duration: 1});` 用 1 秒到达 5
- 加速：
  - `{ease: 'power1.in'}`
  - `power1.out`
  - `power1.inOut`
- 回调：
  - `{onComplete: () => {}}` 动画结束
  - `onStart` 动画开始
- 重复
  - `{repeat: 2}` 重复两次，会突变到原来位置
  - `{repeat: -1}` 无限次
- 往返 `{yoyo: true}`
- 延迟 `{delay: 2}`

***

- `var animation = gsap.to(...)`
- `.isActive()` 是否在运行
- `.pause();` 暂停
- `.resume();` 恢复
- `.seek(0.5);` 跳到 0.5 秒
- `.kill();` 删除

## 12. 随手记录

BoxGeometry

- uv: 是一个立方体展开图与立方体的顶点对应关系，用于展示材质
