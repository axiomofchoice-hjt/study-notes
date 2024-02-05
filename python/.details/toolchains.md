# toolchains

- [1. 安装 miniconda](#1-安装-miniconda)
- [2. vscode 配置](#2-vscode-配置)
- [3. conda 环境](#3-conda-环境)
- [4. 包管理](#4-包管理)

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

## 3. conda 环境

- `conda env list` 查看环境
- `conda create -n $envname python=3.11` 创建环境
  - `conda create -p=/home/xxx/$envname python=3.11` 指定位置
- `conda activate $envname` 激活环境
  - `conda activate /home/xxx/$envname` 指定位置
- `conda deactivate` 关闭环境
- `conda remove -n $envname --all` 删除环境
- `conda create -n $dstenv --clone $srcenv` 克隆环境

## 4. 包管理

- `pip install -r requirements.txt` 安装 requirements.txt
- `pip install $package==$version` 安装特定版本
- `pip uninstall $package`
- `pip list` 查看所有包
- `conda install $package -c conda-forge` 通过 conda-forge 源安装
