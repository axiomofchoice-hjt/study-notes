# manim

- [1. Get Start](#1-get-start)
- [2. vscode 配置](#2-vscode-配置)
- [3. 基本操作](#3-基本操作)
- [4. 定位](#4-定位)
- [外观](#外观)
- [动画](#动画)
- [5. 输出设置](#5-输出设置)
- [x](#x)

## 1. Get Start

`conda install manim`

```py
import manim


class Main(manim.Scene):
    def construct(self):
        circle = manim.Circle()
        circle.set_fill(manim.PINK, opacity=0.5)
        self.play(manim.Create(circle))
        self.play(manim.FadeOut(circle))
```

执行命令 `manim -qh xxx.py Main` 即可

## 2. vscode 配置

安装插件 Manim Sideview

增加设置

```json
{
    "manim-sideview.previewLooping": false,
    "manim-sideview.runOnSave": false
}
```

打开 python 文件点右上角按钮，需要输入场景名

## 3. 基本操作

`self.play` 执行动画，多个参数表示动画同时进行

`self.play(circle.animate.set_fill(manim.PINK, opacity=0.5))`

ReplacementTransform 变形

旋转用 `Rotate` 不要用 animate.rotate

`self.wait()` 等待一段时间

## 4. 定位

创建时 mobject 位于原点（屏幕中心）

`mobject.shift(manim.RIGHT)` 向右移动一单位

`mobject.move_to(manim.RIGHT * 2)` 移动到绝对位置

`mobject.next_to(mobject2, manim.RIGHT, buff=0.5)` 移动到 mobject2 的相对位置

`mobject.align_to(mobject2, manim.LEFT)` 用对象左边界来定位

## 外观

`.set_stroke(color=manim.GREEN, width=20)` 线样式

`set_fill(manim.YELLOW, opacity=1.0)` 填充样式

## 动画

`self.play` 播放动画

- 参数 run_time 设置秒数，默认 1

`manim.FadeIn`

`manim.FadeOut`

`self.wait(2)` 停两秒

## 5. 输出设置

`manim -qh xxx.py Main`

- `-p` 自动播放 `-k` 打开目录
- `-qh` 高质量 (1080p60) `-ql` 低质量 (480p15) `-qm` 中等质量 `-qk` 4k 质量
- `-i` 输出 `.git`

用 `self.next_section()` 分割，加上 `--save_sections` 命令行参数，可以输出多个视频

## x

数学对象 mobject，是可以显示的对象

`self.add(mobject)` 立即显示一个对象

- 后加入的对象显示在前

`self.remove(mobject)` 立即移除一个对象
