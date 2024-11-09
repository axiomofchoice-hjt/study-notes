# settings

[[toc]]

## 1. Bash Prompt

`~/.bashrc`

```sh
export PS1="\e[91m\u \e[33m\w\e[0m -> "
```

## 2. zsh

### 2.1. 安装

```sh
yay -S install zsh zsh-syntax-highlighting util-linux-user
chsh -s /bin/zsh
```

### 2.2. 配置

`~/.zshrc`

```sh
PROMPT='%F{208}%n%f %F{226}%~%f -> '  # 这句话放 conda init 前
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # 这句话放 conda init 后
autoload -U colors && colors
autoload -U promptinit && promptinit
setopt prompt_subst
source ~/.zshkeybind
setopt interactivecomments
```

`~/.zshkeybind`

```sh
# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history

# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# Fix numeric keypad  
# 0 . Enter  
bindkey -s "^[Op" "0"
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3  
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6  
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9  
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + - * /  
bindkey -s "^[Ol" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
# delete
bindkey "^[[3~" delete-char
# Ctrl+Left/Right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
```
