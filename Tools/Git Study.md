# Git

- [1. ubuntu 安装](#1-ubuntu-安装)
- [2. git 配置](#2-git-配置)
  - [2.1. 配置文件](#21-配置文件)
- [3. 查看](#3-查看)
- [4. 提交](#4-提交)
- [5. 回滚](#5-回滚)
- [6. 分支](#6-分支)
- [7. 修改已提交内容](#7-修改已提交内容)
- [8. 其他](#8-其他)

## 1. ubuntu 安装

```bash
sudo apt install git
```

## 2. git 配置

用户名和邮箱

```sh
git config --global user.name "axiomofchoice-hjt"
git config --global user.email "1939696303@qq.com"
```

SSH 配置

```sh
ssh-keygen -t rsa -C "1939696303@qq.com"
cat ~/.ssh/id_rsa.pub
# 复制后到 github 加 SSH 公钥
# 验证 ssh -T git@github.com
# 如果失败，且 ~/.ssh/known_hosts 文件不存在，执行 ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
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

设置别名

```sh
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```

查看所有配置 `git config --list`

### 2.1. 配置文件

`~/.gitconfig` 用户配置

`.git/config` 项目配置

## 3. 查看

- `git status` 状态
- `git diff readme.txt` 查看差别
- `git log` 日志
- `git log --pretty=oneline` 精简日志
- `git reflog` 操作日志

## 4. 提交

- `git add . && git commit -m "message" && git push origin main -f`

## 5. 回滚

- `git reset --soft HEAD^` 将上一个提交退回至缓存区
- `git reset --soft HEAD~10` 将往前第 10 个提交退回至缓存区
- `git reset --hard origin/main` 强制更新到 origin/main 分支

## 6. 分支

- `git branch` 查看本地分支
- `git branch $branch` 新建分支
- `git checkout $branch` 切换分支
- `git checkout -b $branch $remoteBranch` 新建分支、拉取远程代码、切换
- `git branch -D $branch` 删除分支

## 7. 修改已提交内容

1. `git rebase -i HEAD~10` 编辑文件，显示最后 10 个提交
2. 将需要修改的提交前 pick 改成 edit
3. `:wq` 保存退出
4. `git add xxx`
5. `git commit --amend`
6. 修改提交消息
7. `:wq` 保存退出
8. `git rebase --continue`

## 8. 其他

cherry-pick

`git count-objects -vH` 计算仓库大小
