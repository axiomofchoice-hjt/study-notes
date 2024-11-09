# wsl-manjaro-get-start

[[toc]]

## 1. 安装系统

[参考](https://www.cnblogs.com/RioTian/p/17984821)

[下载](https://github.com/sileshn/ManjaroWSL2/releases)，解压到目标位置，直接运行 exe。

`wsl -d Manjaro` 进入，设置用户。

```sh
sudo pacman-mirrors --country China
sudo pacman -Syu
sudo pacman -S yay
```

安装软件的命令是 `yay -S $name`

## 2. wsl.conf

/etc/wsl.conf 修改

```ini
[interop]
appendWindowsPath = false
```

## 3. 软件

```sh
yay -S cmake make gdb clang llvm ninja htop zip unzip
```

## 4. zsh

[zsh](../../shell/settings.md#zsh)

## 5. 增加脚本

~/.zshrc

```sh
alias git=/mnt/c/Apps/Git/bin/git.exe

function study() {
    if [[ "$1" = "up" ]]; then
        pushd ~/workspace/study-notes > /dev/null
        git up
        popd > /dev/null
    elif [[ "$1" = "pull" ]]; then
        pushd ~/workspace/study-notes > /dev/null
        git pull
        popd > /dev/null
    else
        cd ~/workspace/study-notes
    fi
}

function run() {
    if [[ -f "$1" ]]; then
        out=$(realpath ${1%%.*})
        g++ "$@" -Wall -Wextra -Wpedantic -march=native -o $out && \
            $out && \
            rm $out
    elif [[ -f package.json ]]; then
        yarn dev
    else
        chmod +x run.sh
        ./run.sh "$@"
    fi
}

function asm() {
    if [[ ! -f $1 ]]; then
        return 1
    fi
    stem=$(realpath ${1%%.*})
    g++ "$@" -Wall -Wextra -Wpedantic -march=native -o $stem.o -c && \
        objdump $stem.o -dSCr > $stem.o.txt && \
        rm $stem.o && \
        code $stem.o.txt
}
```

## 6. cpp 环境

### 6.1. clangd

[clangd](https://github.com/clangd/clangd/releases)

```sh
unzip clangd-linux-16.0.2.zip -d ~
rm clangd-linux-16.0.2.zip
sudo ln -s ~/clangd_16.0.2/bin/clangd /usr/local/bin/clangd
```

### 6.2. clang-format

```sh
echo "---
BasedOnStyle: Google
Language: Cpp
IndentWidth: 4
TabWidth: 4
---" > ~/.clang-format
```

## 7. python 环境

[参考](https://docs.conda.io/projects/miniconda/en/latest/)

```sh
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
bash miniconda3.sh -b -u -p ~/miniconda3
rm miniconda3.sh
~/miniconda3/bin/conda init zsh
```

## 8. node 环境

```sh
yay -S nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
```

重启终端

```sh
nvm install node
npm install -g yarn
yarn config set registry https://registry.npmmirror.com/
```
