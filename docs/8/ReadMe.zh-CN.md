# MD8: Git 使用技巧

## Git 克隆空仓库更改后提交到 main 分支

> git branch -M main

> git push -u origin main

## 使用 GNU Nano 作为 Git 的默认编辑器

> git config --global core.editor nano

## 为特定 Git 仓库禁用 CRLF 换行符转换

> git config core.autocrlf false

## 缩减 Git 本地仓库的体积

> git reflog expire --expire=now --all

> git gc --aggressive --prune=now

## 清除 Git 仓库的未跟踪修改

> git clean -xdf

## 设置 git 凭据自动保存

> git config --global credential.helper store

## 临时保存和恢复 git 工作区

> git stash

> git stash pop

## 一键更新全部 Git 子模块

> git submodule update --init --recursive --remote

## 为 Git 设置 Sock5 代理

> git config --local http.proxy http://127.0.0.1:1080

> git config --local https.proxy https://127.0.0.1:1080

## 添加上游仓库并更新信息

> git remote add upstream https://github.com/openssl/openssl.git

> git fetch --prune --tags --all

## 修改 Git 默认提交用用户信息（全局）

> git config --global user.name "MouriNaruto"

> git config --global user.email "Kenji.Mouri@outlook.com"

## 修改 Git 默认提交用用户信息（局部）

> git config user.name "MouriNaruto"

> git config user.email "Kenji.Mouri@outlook.com"

## 修改本地 Git 仓库的上一个提交的用户信息

> git commit --amend --author "MouriNaruto <Kenji.Mouri@outlook.com>"

## 重构 Git 仓库的 commit 信息

> git rebase -i --root

> git rebase --continue

## 彻底移除 Git 仓库的特定标签

> git tag -d 1.1-ServicingUpdate1-Preview1

> git push origin :refs/tags/1.1-ServicingUpdate1-Preview1

## 彻底移除 Git 仓库的特定分支

> git branch -d linux-minclr-5.15.y

> git push origin -d linux-minclr-5.15.y

## 切换特定 Git 子模块的分支

> git submodule set-branch -b 6.5 qtbase

> git submodule update --remote

## 在 Git 仓库为特定 commit 添加 tag

> git tag -a "4.4.1.0" -m "" f6e971933f47244cfc45244c6f9b1b4ea75e9e1f

## 在 Git 仓库从特定 tag 签出分支

> git checkout -b mouri-dev 26.0.2

## 设置 Git 仓库的上游地址

> git remote set-url origin https://github.com/M2Team/NSudo

## 更新在线 Git 仓库的 tags

> git push --all --follow-tags

## 使用其他远程 Git 仓库源的分支并提交

> git checkout -b newbranch upstream/newbranch

> git push -u origin newbranch

## 合并特定 Git commit

> git merge 3ce7bc40a3c48da1c96c2d04c10045bd797c6aa3

## 删除 git 子模块

> git rm -f framelesshelper

> rd /s .git\modules\framelesshelper

## 还原修改并放弃修改内容

> git reset upstream/master --hard

## 不记得用途的 Git 命令

> git filter-branch --force --index-filter "git rm --cached -r --ignore-unmatch FFmpegUniversal/FFmpeg/" --prune-empty --tag-name-filter cat -- --all

> git push origin master --force --tags

> git fetch --unshallow

```
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
```

> git fetch origin
