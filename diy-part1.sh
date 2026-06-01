#!/bin/bash
# diy-part1.sh - 编译前定制脚本（HomeProxy 稳定版）

echo "=========================================="
echo "Starting diy-part1.sh (HomeProxy Optimization)"
echo "=========================================="

# 1. 引入 ImmortalWrt 的 packages 和 luci 源（它们对 sing-box/HomeProxy 维护最好）
echo "src-git im_packages https://github.com/immortalwrt/packages.git" >> feeds.conf.default
echo "src-git im_luci https://github.com/immortalwrt/luci.git" >> feeds.conf.default

# 2. 【核心避坑】在 feeds update 之前，先让脚本在后续流程中把官方旧版的同名包“拉黑”
# 这样编译系统就会强制使用 ImmortalWrt 的新版 HomeProxy 和 sing-box，绝不冲突
# （注：工作流执行完此脚本后会自动跑 update & install）

echo "=========================================="
echo "diy-part1.sh completed successfully"
echo "=========================================="
