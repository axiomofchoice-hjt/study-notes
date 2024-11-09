# wsl-debian-get-start

[[toc]]

## 1. 安装 WSL Debian

```bat
wsl --shutdown
wsl --install Debian
```

## 2. WSL 配置

/etc/wsl.conf

```ini
[interop]
appendWindowsPath = false
```

## 3. 修改软件源

```sh
sudo nano /etc/apt/sources.list
sudo apt install apt-transport-https ca-certificates
sudo apt update
```

```text
deb https://mirrors.huaweicloud.com/debian bookworm main
deb https://mirrors.huaweicloud.com/debian bookworm-updates main
deb https://mirrors.huaweicloud.com/debian-security bookworm-security main
deb https://mirrors.huaweicloud.com/debian bookworm-backports main
```

错误：出现认证问题，将 sources.list 的 https 改成 http，安装 apt-transport-https ca-certificates 后再改回来

## 4. 基础软件

```sh
sudo apt install git curl zip unzip tar
sudo apt install build-essential cmake
```

## 5. 安装 zsh

```sh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-syntax-highlighting
```

配置主题和插件 `~/.zshrc`

```sh
ZSH_THEME="agnoster" # 在对应位置修改
plugins=(git zsh-syntax-highlighting) # 在对应位置修改
prompt_dir() {
    prompt_segment green $CURRENT_FG '%~'
}
prompt_status() {}
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)%n"
  fi
}
prompt_git() {}
```

## 6. zshrc 添加功能

```sh
function add_script() {
    touch $1.sh
    chmod u+x $1.sh
}
alias run="./run.sh"
alias clean="./clean.sh"
alias test="./test.sh"

wlan_ip=$(~/get_wlan_ip)
host_ip=$(cat /etc/resolv.conf | grep "^nameserver " | cut -d " " -f2)

function set_git_proxy() {
    git config --global http.proxy http://$1:7890
    git config --global https.proxy http://$1:7890
    echo set proxy=http://$1:7890
}

function reset_git_proxy() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

set_git_proxy $wlan_ip
```

## 7. git 配置

```sh
git config --global user.name "axiomofchoice-hjt"
git config --global user.email "1939696303@qq.com"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```

## 8. 安装 vscode 插件

...

## 9. 安装 vcpkg

```sh
git clone https://github.com/microsoft/vcpkg
./vcpkg/bootstrap-vcpkg.sh
sudo ln -s $(pwd)/vcpkg/vcpkg /usr/local/bin/vcpkg
```

小安装一个 fmt 库（似乎需要 `sudo apt install pkg-config`）

```sh
vcpkg install fmt
```

## 10. 安装 clangd

[clangd-16.0.2](https://github.com/clangd/clangd/releases/download/16.0.2/clangd-linux-16.0.2.zip)

```sh
unzip clangd-linux-16.0.2.zip -d ~
rm clangd-linux-16.0.2.zip
sudo ln -s ~/clangd_16.0.2/bin/clangd /usr/local/bin/clangd
```

## 11. 配置 clang-format

```sh
echo "---
BasedOnStyle: Google
Language: Cpp
IndentWidth: 4
TabWidth: 4
---" > ~/.clang-format
```

## 12. 安装 node

```sh
sudo apt install nodejs npm
sudo npm install n -g
sudo n stable
```
