# Filesystem

`import os`：

- 重命名文件 `os.rename(file, name)`
- 删除文件 `os.remove(file)`
- 返回当前目录中的内容（不带路径） `os.listdir(dir)`
- 创建目录 `os.mkdir(dir)`
- 删除空目录 `os.rmdir(dir)`
- 返回当前目录 `os.getcwd()`
- 切换当前目录 `os.chdir(dir)`
- 返回是否是文件 `os.path.isfile(file)`
- 返回是否是目录 `os.path.isdir(dir)`
- 路径拼接 `os.path.join(s1, s2, ...)`
- 去掉路径去掉扩展名 `os.path.basename(file)`
- 执行文件的目录 `os.path.dirname(os.path.abspath(__file__))`

`import shutil`：

- 复制文件 `shutil.copy(from, to)`
- 复制文件夹 `shutil.copytree(from, to)`（将一个文件夹的内容复制到一个空文件夹中，后者不存在则创建）
- 删除文件夹 `shutil.rmtree(dir)`
- 移动文件（夹） `shutil.move(from, to)`

`import glob`：

- `glob.glob(s)` 返回所有匹配的文件或目录，支持通配符

`from pathlib import Path`

- `Path(".")`
- `path / path`
- `path.is_dir()`
- `for i in path.iterdir()`
- `path.glob("**/*.py")`
- `path.resolve()` 转换为绝对路径
- `path.exists()`
- `with path.open() as f:` 打开文件？
- `path.as_posix()` 转换为字符串
- 执行文件的目录 `Path(__file__).parent()`
