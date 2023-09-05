# Tools

- [1. nano 编辑器](#1-nano-编辑器)
- [2. VSCode](#2-vscode)
  - [2.1. 任务](#21-任务)
  - [2.2. 调试](#22-调试)
- [3. SSH](#3-ssh)
- [4. pandoc](#4-pandoc)
- [5. zsh 终端](#5-zsh-终端)

## 1. nano 编辑器

保存并退出：Ctrl+S，Ctrl+X

## 2. VSCode

### 2.1. 任务

顶部菜单 终端 -> 配置默认生成任务

Ctrl+Shift+B 执行任务

### 2.2. 调试

侧边栏 运行和调试 -> 创建 lauch.json 文件

F5 调试

## 3. SSH

- `ssh $username@$hostname`
- `-p $port` 指定端口

可以类似 github 使用 ssh 公私钥验证

## 4. pandoc

安装 `sudo apt install pandoc`

markdown 转换为 html `pandoc -f gfm -t html {}.md -o {}.html`

[](https://github.com/Wandmalfarbe/pandoc-latex-template)

## 5. zsh 终端

```sh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-syntax-highlighting
```

同时需要把 `~/.bashrc` 的内容添加到 `~/.zshrc` 里

配置主题和插件

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

主题位置 `~/.oh-my-zsh/themes/agnoster.zsh-theme`

命令

- 可以省略 cd
- 按一次 tab 来获取提示
- 自动补全插件，End 键补全
