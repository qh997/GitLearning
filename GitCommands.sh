#!/bin/bash

# 显示版本库 .git 目录所在位置
git rev-parse --git-dir
# 显示工作区根目录
git rev-parse --show-toplevel
# 相对于工作区根目录的相对目录
git rev-parse --show-prefix
# 显示当前目录到工作区根目录的相对深度
git rev-parse --show-cdup
# 显示分支
git rev-parse --symbolic --branches
# 显示里程碑
git rev-parse --symbolic --tags
# 显示所有的引用
git rev-parse --symbolic --glob=refs/*
# 显示 HEAD 对应的 SHA1 值
git rev-parse HEAD
# 解析 describe 输出为 SHA1 值
git describe | xargs git rev-parse

# 显示 Git 核心程序安装路径
git --exec-path

# 显示各种类型的对象
git show-ref

# 编辑 .git/config 版本库文件
git config -e
# 编辑 ~/.gitconfig 全局配置文件
git config -e --global
# 编辑 /etc/gitconfig 系统级配置文件
git config -e --system

# 进行一次空提交
git commit --allow-empty
# 强行添加被忽略的文件
git add -f <filename>

# 查看历史（指定格式）
git log --pretty=fuller # email full fuller medium oneline raw short
# 显示关联的引用
git log --decorate
# 精简输出
git status -s
# 精简输出并显示分支
git status -s -b
# 查看忽略文件状态
git status --ignored -s

# 工作区 vs 暂存区
git diff
# 工作区 vs 版本库
git diff HEAD
# 暂存区 vs 版本库
git diff --cached
git diff --staged
# 逐词比较
git diff --word-diff

# 将文件 filename 的改动撤出暂存区
git reset -- <filename>
git reset HEAD <filename>
# 用 HEAD 指向的目录树替换暂存区的目录树，工作区不变
git reset
git reset HEAD
# 工作区不变，暂存区和引用回退
git reset HEAD^
git reset --mixed HEAD^
# 工作区和暂存区不变，引用回退
git reset --soft HEAD^
# 工作区、暂存区和引用回退
git reset --hard HEAD^

# git commit --amend 相当于以下命令
git reset --soft HEAD^
git commit -e -F .git/COMMIT_EDITMSG

# 汇总显示工作区、暂存区与 HEAD 的差异
git checkout
git checkout HEAD
# 检出 branch 分支，更新 HEAD 以指向 branch 分支
# 用 branch 指向的树更新工作区和暂存区
git checkout <branch>
# 用暂存区全部（或指定）文件替换工作区
git checkout .
git checkout -- <file>
# 用 HEAD 指向的分支的全部（或指定）文件替换工作区和暂存区
git checkout HEAD .
git checkout HEAD <file>
# 用 <branch> 指向的提交的文件替换工作区和暂存区
git checkout <branch> -- <file>

# 从暂存区删除文件，工作区不变
git rm --cached <file>

# 查看目录树
git ls-tree -l HEAD
git ls-files --with-tree=HEAD
# 查看暂存区的目录树
git ls-files -s
# 要使用 ls-tree 查看暂存区的目录树需要首先 write-tree
# 然后用得到的哈希值运行 ls-tree
git write-tree | xargs git ls-tree -l -r -t <SHA1>

# 清除当前工作区中未跟踪的文件和目录
git clean -fd
# 显示将要清除的当前工作区中未跟踪的文件和目录
git clean -nd

# 保存当前工作进度
git stash
# 查看保存的工作进度
git stash list
# 恢复最近的工作进度
git stash pop
# 恢复最近的工作进度但不清除 stash list
git stash apply

# 查看版本库对象的类型
git cat-file -t
# 查看版本库对象的大小
git cat-file -s
# 查看版本库对象的内容
git cat-file -p

# 显示引用对应的提交 ID
git rev-parse refs/heads/master
# 显示引用对应的文件 ID
git rev-parse HEAD:welcomes
# 显示引用对应的 tree ID
git rev-parse HEAD^{tree}

# 生成 commit 的哈希值
(printf "commit %s\000" $(git cat-file commit HEAD | wc -c | awk '{printf "%s", $1}'); git cat-file commit HEAD) | sha1sum
# 生成 blob 的哈希值
(printf "blob %s\000" $(git cat-file blob HEAD:welcome.txt | wc -c | awk '{printf "%s", $1}'); git cat-file blob HEAD:welcome.txt) | sha1sum
# 生成 tree 的哈希值
(printf "tree %s\000" $(git cat-file tree HEAD^{tree} | wc -c | awk '{printf "%s", $1}'); git cat-file tree HEAD^{tree}) | sha1sum

# 查看历史记录
git reflog show master
# 恢复历史
git reset --hard master@{2}
# 丢弃90天以前的记录
git reflog expire --all
# 强制让记录全部过期
git reflog expire --expire=now --all

# 将最近的提交显示为一个易记的名称
git describe
# 将指定的提交或引用显示为一个易记的名称
git describe (<commit>|<ref>)

# 从历史提交中恢复删除的文件
git cat-file -p HEAD~1:<filename> > <filename>
git show HEAD~1:<filename> > <filename>
git checkout HEAD~1 -- <filename>

# 基于最新提交建立归档文件
git archive -o latest.zip HEAD
# 只将目录 src 和 doc 建立归档
git archive -o latest.zip HEAD src doc

# 以反向时间顺序列出 commit 对象
git rev-list HEAD
# 查看某版本的所有历史提交
git rev-list --oneline (<commit>|<tag>)
# 查看多个版本的所有历史提交（并集）
git rev-list --oneline D F
# 排除某个版本及其历史版本
git rev-list --oneline ^G D
git rev-list --oneline G..D
# 排除某两个版本公共历史版本
git rev-list --oneline B...C
# 某个提交的历史提交，自身除外
git rev-list --oneline B^@
# 提交本身，不包括其历史提交
git rev-list --oneline B^!

# 文件追溯
git blame <filename>
# 文件追溯，指定行
git blame -L 6,+5 <filename>

# 二分查找
git bisect

# 图形化界面
gitk
gitg
qgit

# 变基操作
# (1) git checkout <till>
# (2) 将 <since>..<till> 的范围写入临时文件
# (3) git reset --hard <newbase>
# (4) 从临时文件中按顺序重新提交
git rebase --onto <newbase> <since> <till>
git rebase --onto <newbase> <since>
git rebase                  <since> <till>
git rebase                  <since>

# 版本库克隆
git clone <repository> <directory>
# 不包含工作区（裸版本库）
git clone --bare <repository> <directory.git>
# 裸版本库并对上游版本库进行了注册
git clone --mirror <repository> <directory.git>

# 查看远程版本库的引用
git ls-remote ［</path/to/remote>］

# 验证数据库中对象的连接性和有效性
git fsck
# 不考虑 reflog
git fsck --no-reflogs

# 数据库清理
git prune

# 为本地分支创建跟踪
git checkout --track -b <newbranch> <branch>
# 添加远程版本库
git remote add <newremote> </path/to/remote>
# 显示已注册的远程版本库
git remote -v
# 查看远程分支
git branch -r
# 更改远程版本库的地址
git remote set-url <remote> <newpath>

# 获取最近3个提交的补丁文件
git format-patch -s HEAD~3..HEAD