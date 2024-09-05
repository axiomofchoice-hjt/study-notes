# toolchains

- [1. 安装 miniconda](#1-安装-miniconda)
- [2. vscode 配置](#2-vscode-配置)
- [3. conda](#3-conda)
- [4. pip](#4-pip)
- [5. 调试](#5-调试)

## 1. 安装 miniconda

[参考](https://docs.conda.io/projects/miniconda/en/latest/)

```sh
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
bash miniconda3.sh -b -u -p miniconda3
rm miniconda3.sh
./miniconda3/bin/conda init zsh
```

## 2. vscode 配置

安装插件 python

如果无法格式化，安装插件 black formatter

## 3. conda

- `conda env list` 查看环境
- `conda create -n $envname python=3.11` 创建环境
  - `conda create -p=/home/xxx/$envname python=3.11` 指定位置
- `conda activate $envname` 激活环境
  - `conda activate /home/xxx/$envname` 指定位置
- `conda deactivate` 关闭环境
- `conda remove -n $envname --all` 删除环境
- `conda create -n $dstenv --clone $srcenv` 克隆环境
- `conda install $package -c conda-forge` 通过 conda-forge 源安装
- `conda env update -f env.yml` 通过 env.yml 安装
- `conda env create -f env.yml` 通过 env.yml 创建环境

## 4. pip

- `pip install -r requirements.txt` 安装 requirements.txt
- `pip install $package==$version` 安装特定版本
- `pip uninstall $package`
- `pip list` 查看所有包

如果一个包卸载不掉，删除 `env/lib/pythonx.x/site-packages/easy-install.pth`

## 5. 调试

启动 `python -m pdb xxx.py`

- `run` 重新运行
- `c` 继续
- n, s, p, b
- `return` 单步运行，跳出函数
- `b` 查看所有断点
- `clear` 清空断点
- `!xxx` 执行语句
- `until xxx` 执行到指定位置，until 要打全
