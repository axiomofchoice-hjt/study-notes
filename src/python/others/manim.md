# manim

[[toc]]

## 1. Get Start

`conda install -c conda-forge manim`

```py
import manim as mm


class Main(mm.Scene):
    def construct(self):
        circle = mm.Circle()
        circle.set_fill(mm.PINK, opacity=0.5)
        self.play(mm.Create(circle))
        self.play(mm.FadeOut(circle))
```

执行命令 `manim -qh xxx.py Main` 即可。

（可能要升级 ffmpeg）

## 2. vscode 配置

安装插件 Manim Sideview。

增加设置：

```json
{
    "manim-sideview.previewLooping": false,
    "manim-sideview.runOnSave": false
}
```

打开 python 文件点右上角按钮，需要输入场景名，场景名是类名 `Main`。

## 3. 对象

圆

```py
circle = mm.Circle()
self.play(mm.Create(circle))
```

文本

```py
text = mm.Text("Hello Manim!", font_size=48)
self.play(mm.Write(text))
```

数学公式（需要装 latex，略）

## 4. 基本操作

`self.play` 执行动画，多个参数表示动画同时进行。

`self.play(circle.animate.set_fill(mm.PINK, opacity=0.5))`

ReplacementTransform 变形

旋转用 `Rotate` 不要用 animate.rotate

`self.wait()` 等待一段时间

## 5. 定位

创建时 mobject 位于原点（屏幕中心）

`mobject.shift(mm.RIGHT)` 向右移动一单位

`mobject.move_to(mm.RIGHT * 2)` 移动到绝对位置

`mobject.next_to(mobject2, mm.RIGHT, buff=0.5)` 移动到 mobject2 的相对位置

`mobject.align_to(mobject2, mm.LEFT)` 用对象左边界来定位

## 6. 外观

`.set_stroke(color=mm.GREEN, width=20)` 线样式

`set_fill(mm.YELLOW, opacity=1.0)` 填充样式

## 7. 动画

`self.play` 播放动画

- 参数 run_time 设置秒数，默认 1

`mm.FadeIn`

`mm.FadeOut`

`self.wait(2)` 停两秒

## 8. 输出设置

`manim -qh xxx.py Main`

- `-p` 自动播放 `-k` 打开目录
- `-qh` 高质量 (1080p60) `-ql` 低质量 (480p15) `-qm` 中等质量 `-qk` 4k 质量
- `-i` 输出 `.git`

用 `self.next_section()` 分割，加上 `--save_sections` 命令行参数，可以输出多个视频

## 9. x

数学对象 mobject，是可以显示的对象

`self.add(mobject)` 立即显示一个对象

- 后加入的对象显示在前

`self.remove(mobject)` 立即移除一个对象
