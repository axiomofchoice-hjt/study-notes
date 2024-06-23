# setuptools

- [1. Get Start](#1-get-start)
- [2. 构建命令](#2-构建命令)
- [3. 生成可执行脚本](#3-生成可执行脚本)

## 1. Get Start

```sh
pip install setuptools
```

创建 setup.py

```py
from setuptools import setup, find_packages

setup(
    name='proj',
    version='1.0.0',
    packages=find_packages(),
    author='Your Name',
    author_email='your@email.com',
    description='Description of your package',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    url='https://github.com/your_username/your_package',
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
    ],
    install_requires=[
        # List your dependencies here
    ],
)
```

项目里创建 `proj/__init__.py`

`pip install .` 即可

## 2. 构建命令

|            旧命令             |           新命令           |
| :---------------------------: | :------------------------: |
|   `python setup.py install`   |      `pip install .`       |
|   `python setup.py develop`   | `pip install --editable .` |
|    `python setup.py sdist`    |     `python -m build`      |
| `python setup.py bdist_wheel` |     `python -m build`      |

## 3. 生成可执行脚本

[参考](https://setuptools.pypa.io/en/latest/userguide/entry_point.html)

```py
setup(
    # ...
    entry_points={
        'console_scripts': [
            'script_name = proj_name:func_name',
        ]
    }
)
```
