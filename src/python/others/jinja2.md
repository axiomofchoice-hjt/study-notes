# jinja2

[[toc]]

## 1. Get Start

`pip install Jinja2`

```py
from jinja2 import Template
template = Template('Hello {{ name }}!')
print(template.render(name='John Doe'))
```

## 2. 模板语法

插值 `{{ expr }}`

if `{% if expr %}...{% endif %}`

for `{% for i in expr %}...{% endfor %}`

- `loop.index0` 从 0 开始的索引
- `loop.index` 从 1 开始的索引
- `loop.first` bool，是否是第一次迭代
- `loop.last` bool，是否是最后一次迭代

用 `foo.bar` 或 `foo['bar']` 来得到 object / dict 的属性

raw `{% raw %}...{% endraw %}`

设置变量 `{% set var = 'abc' %}`

加减号可以移除空白符，`{%-` 可以去掉语法块之前的空白符，`-%}`
