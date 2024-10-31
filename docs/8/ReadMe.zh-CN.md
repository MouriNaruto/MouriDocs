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
