# Package Management

- [1. 安装](#1-安装)
- [2. conda 环境](#2-conda-环境)
- [3. 包管理](#3-包管理)

## 1. 安装

[参考](https://docs.conda.io/projects/miniconda/en/latest/)

```sh
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
bash miniconda3.sh -b -u -p ~/miniconda3
rm miniconda3.sh
~/miniconda3/bin/conda init zsh
```

## 2. conda 环境

- `conda env list` 查看环境
- `conda create -n $envname python=3.11` 创建环境
  - `conda create -p=/home/xxx/$envname python=3.11` 指定位置
- `conda activate $envname` 激活环境
  - `conda activate /home/xxx/$envname` 指定位置
- `conda deactivate` 关闭环境
- `conda remove -n $envname --all` 删除环境

## 3. 包管理

- `pip install -r requirements.txt` 安装 requirements.txt
- `conda install xxx -c conda-forge` 通过 conda-forge 源安装
