# git

[[toc]]

## 1. 安装

Debian: `sudo apt install git`

## 2. 配置

查看所有配置 `git config --list`

```sh
git config --global user.name "axiomofchoice-hjt" # 用户名
git config --global user.email "Axiomofchoice@163.com" # 邮箱
git config --global core.quotepath false # 文件名显示中文
git config --global core.autocrlf false # 取消 CRLF
git config --global pull.rebase true # pull 默认 rebase
git config --global core.editor "code --wait" # 编辑器默认 vscode
```

### 2.1. 命令别名

```sh
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st "status -sb"
git config --global alias.up '!git add --all; git commit -m =; git push;'
git config --global alias.lg "log --oneline --graph"
```

### 2.2. 代理

```sh
git config --global http.proxy http://127.0.0.1:xxxx
git config --global https.proxy http://127.0.0.1:xxxx
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 2.3. 配置文件

- `~/.gitconfig` 用户配置
- `.git/config` 项目配置
- `git config --global --edit` 编辑配置文件

### 2.4. ssh 配置

1. `ssh-keygen -t rsa -C "1939696303@qq.com"`
2. `~/.ssh/id_rsa.pub` 文件内容复制后到 github 添加 SSH 公钥
3. `ssh -T git@github.com` 验证

如果失败且 `~/.ssh/known_hosts` 文件不存在，执行 `ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts`

如果还失败，编辑 `~/.ssh/config` 如下：

```text
# 配置 github.com
Host github.com
HostName github.com
IdentityFile ~/.ssh/id_rsa

# 配置其他网站
Host xxx.com
HostName xxx.com
IdentityFile ~/.ssh/id_xxx
```

## 3. 项目配置

### 3.1. .gitignore

注释 `#` 必须是在行首，不能跟在内容后，下面的写法不合法

```text
build  # comment
```

## 4. 克隆

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

depth 克隆

```sh
git clone $url --depth=1 # 只有 master 最新版
cd $dir
git fetch --depth=1 origin $branch # 拉取分支的最新版
git checkout $branch
git fetch --unshallow # 拉取当前分支的完整历史
```

克隆单分支

```sh
git clone $url --branch $branch --single-branch
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

## 5. 查看

- `git status` 状态
- `git diff <file>` 查看差别
- `git log` 日志，可指定文件 / commit
  - `--oneline` 精简日志
  - `--graph` 以图的形式
  - `--stat` 显示文件更改
  - `-p` `--patch` 查看 diff
- `git reflog` 操作日志

## 6. 提交

- `git add $path` 暂存更改
- `git commit -m "$message"` 提交更改
- `git reset HEAD $path` 取消暂存
- `git checkout $path` 删除更改（会丢失）
- `git reset --soft $target` 移动 HEAD 指针，不改变文件，将文件变化体现在暂存区
- `git reset --hard $target` 强制移动 HEAD 指针，改变文件

目标 `$target` 可以是：

- `HEAD^` 上一个提交
- `HEAD~10` 往前第 10 个提交
- commit id
- `origin/main` origin/main 分支

标签

- `git tag` 查看标签
- `git tag $tagname` 打标签

## 7. 分支

- `git branch` 查看本地分支
- `git branch $branch` 新建分支
- `git checkout $branch` 切换分支
- `git checkout -b $branch $remoteBranch` 新建分支、拉取远程代码、切换
- `git branch -D $branch` 删除分支
- `git remote prune origin` 删除远程已经删除的分支
- `git fetch --all` 更新所有 remote 分支

rebase 后推送要用 `git push --force-with-lease`

## 8. tag

- `git checkout $tagname` ？
- `git pull origin --tags $tagname` 当前分支拉取 tag

## 9. 更改提交

如果编辑器设为 vscode 且装了 gitlens 插件就可以图形化操作

编辑单个提交：

1. `git rebase -i HEAD~10` 编辑文件，显示最后 10 个提交
2. 将需要修改的提交前 pick 改成 edit，保存退出
3. 修改文件并 `git add xxx`
4. `git commit --amend`
5. 修改提交消息，保存退出
6. 可以重复多次 3, 4, 5
7. `git rebase --continue`

合并提交：第二步将被合并的提交前 pick 改成 squash

排序：第二步直接调整提交的顺序

## 10. 子模块

添加

```sh
git submodule add https://github.com/fmtlib/fmt third_party/fmt
```

更新

```sh
git submodule sync
git submodule update --init --recursive
```

删除

```sh
git submodule deinit -f third_party/fmt
git rm --cached third_party/fmt
# 然后删除 .gitmodules 里的字段
```

## 11. patch

- 打 patch：`git diff $COMMIT $COMMIT > $file`
- 应用 patch：`git apply $file`
- `git diff` 未缓存的改动
- `git diff --cached` 缓存的改动
- `git diff HEAD` 所有未提交的改动

## 12. 其他

- `git cherry-pick` 应用某一 commit
- `git revert` 反转某一 commit
- `git count-objects -vH` 计算仓库大小
- `git blame` 按行查看谁最后修改
- `git clean -fd` 清除 untrack 文件和目录

## 13. commit message 规范

```text
type: Subject

body

footer
```

type

- feat 新功能
- fix 修复错误
- docs 文档
- style 格式
- refactor 重构
- perf 性能优化
- test 测试
- chore 项目构建配置
