#!/bin/bash

# 显示版本库 .git 目录所在位置
git rev-parse --git-dir
# 显示工作区根目录
git rev-parse --show-toplevel
# 相对于工作区根目录的相对目录
git rev-parse --show-prefix
# 显示当前目录到工作区根目录的相对深度
git rev-parse --show-cdup

# 编辑 .git/config 版本库文件
git config -e
# 编辑 ~/.gitconfig 全局配置文件
git config -e --global
# 编辑 /etc/gitconfig 系统级配置文件
git config -e --system

# 进行一次空提交
git commit --allow-empty

# 查看历史（指定格式）
git log --pretty=fuller # email full fuller medium oneline raw short
# 精简输出
git status -s

# 工作区 vs 暂存区
git diff
# 工作区 vs 版本库
git diff HEAD
# 暂存区 vs 版本库
git diff --cached
git diff --staged