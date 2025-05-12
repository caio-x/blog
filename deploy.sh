#!/bin/bash

# 判断是否启用详细输出模式
verbose=0
for arg in "$@"; do
    if [ "$arg" = "-i" ]; then
        verbose=1
        break
    fi
done

# 设置输出目标
if [ $verbose -eq 1 ]; then
    output="/dev/tty"
else
    output="/dev/null"
fi

# 输出开始信息
echo "Begin generate Hexo static files......"

# 执行 hexo 命令
hexo g >"$output" 2>&1

# 执行 cp 命令
cp -r /root/code_workspace/hexo_blog/blog.spade-ace.tech /var/www/blog >"$output" 2>&1

# 输出完成信息
echo "Deploy finished!"
