#!/bin/bash
# diy-part1.sh - 编译前的定制脚本

echo "=========================================="
echo "Starting diy-part1.sh (Pre-compile)"
echo "=========================================="

# 1. 添加 SSR Plus 源
echo "Adding SSR Plus feed..."
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> feeds.conf.default

# 提示：脚本内不需要再写一遍 feeds update/install，我们在工作流里统一处理

echo "=========================================="
echo "diy-part1.sh completed successfully"
echo "=========================================="
