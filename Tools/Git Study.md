# Git

- [1. Debian 安装](#1-debian-安装)
- [2. git 配置](#2-git-配置)
  - [2.1. SSH 配置](#21-ssh-配置)
  - [2.2. 命令别名](#22-命令别名)
  - [2.3. 代理](#23-代理)
  - [2.4. 配置文件](#24-配置文件)
- [3. 克隆](#3-克隆)
- [4. 查看](#4-查看)
- [5. 提交](#5-提交)
- [6. 回滚](#6-回滚)
- [7. 分支](#7-分支)
- [8. 修改已提交内容](#8-修改已提交内容)
- [9. 其他](#9-其他)

## 1. Debian 安装

```bash
sudo apt install git
```

## 2. git 配置

查看所有配置 `git config --list`

用户名和邮箱

```sh
git config --global user.name "axiomofchoice-hjt"
git config --global user.email "1939696303@qq.com"
```

### 2.1. SSH 配置

```sh
ssh-keygen -t rsa -C "1939696303@qq.com"
cat ~/.ssh/id_rsa.pub
# 复制后到 github 加 SSH 公钥
# 验证 ssh -T git@github.com
# 如果失败，且 ~/.ssh/known_hosts 文件不存在，执行 ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
# 如果还失败，参考下面的方法编辑 ~/.ssh/config
```

多个 SSH 公私钥管理：新建 `~/.ssh/config`

```text
# 配置 github.com
Host github.com
HostName github.com
IdentityFile ~/.ssh/id_rsa

# 配置 gitee
Host gitee.com
HostName gitee.com
IdentityFile ~/.ssh/id_xxx
```

### 2.2. 命令别名

```sh
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```

`up = "!git add --all; git commit -m \"=\"; git push;"`（需要进入配置文件进行配置）

### 2.3. 代理

```sh
git config --global http.proxy http://127.0.0.1:xxxx
git config --global https.proxy http://127.0.0.1:xxxx
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 2.4. 配置文件

`~/.gitconfig` 用户配置

`.git/config` 项目配置

`git config --global --edit` 编辑配置文件

## 3. 克隆

直接克隆

- `git clone $url`
- `git clone $url $dir` 指定目录

从空项目中拉取

```sh
mkdir $dir
cd $dir
git init
git remote add origin $url
git fetch
git checkout $branch
```

sparse checkout，可拉取指定目录

```sh
mkdir $dir
cd $dir
git init
git remote add origin $url
git config core.sparsecheckout true
echo $sub_dir >> .git/info/sparse-checkout
git fetch
git checkout $branch
```

## 4. 查看

- `git status` 状态
- `git diff readme.txt` 查看差别
- `git log` 日志
- `git log --pretty=oneline` 精简日志
- `git reflog` 操作日志

## 5. 提交

- `git add .; git commit -m "message"; git push origin main -f`

## 6. 回滚

- `git reset --soft $target` 移动 HEAD 指针，不改变文件，将文件变化体现在暂存区
- `git reset --hard $target` 强制移动 HEAD 指针，改变文件

目标 `$target`

- `HEAD^` 上一个提交
- `HEAD~10` 往前第 10 个提交
- commit id
- `origin/main` origin/main 分支

## 7. 分支

- `git branch` 查看本地分支
- `git branch $branch` 新建分支
- `git checkout $branch` 切换分支
- `git checkout -b $branch $remoteBranch` 新建分支、拉取远程代码、切换
- `git branch -D $branch` 删除分支

## 8. 修改已提交内容

1. `git rebase -i HEAD~10` 编辑文件，显示最后 10 个提交
2. 将需要修改的提交前 pick 改成 edit
3. `:wq` 保存退出
4. `git add xxx`
5. `git commit --amend`
6. 修改提交消息
7. `:wq` 保存退出
8. `git rebase --continue`

## 9. 其他

cherry-pick

`git count-objects -vH` 计算仓库大小
