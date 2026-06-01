#!/bin/bash
# diy-part1.sh - 编译前定制脚本（HomeProxy 版）

echo "=========================================="
echo "Starting diy-part1.sh (Switching to HomeProxy)"
echo "=========================================="

# 1. 移除旧的 SSR Plus 源 (helloworld)
sed -i '/helloworld/d' feeds.conf.default

# 2. 添加 HomeProxy 及其核心 sing-box 所需的仓库
# 我们引入 ImmortalWrt 的 packages 源，它的 sing-box 更新最快，依赖最全
echo "Adding ImmortalWrt Packages feed for HomeProxy..."
echo "src-git im_packages https://github.com/immortalwrt/packages.git" >> feeds.conf.default
echo "src-git im_luci https://github.com/immortalwrt/luci.git" >> feeds.conf.default

# 3. 强制优先使用新添加的源（防止官方旧版依赖冲突）
# 这一步能确保编译时使用的是适配 HomeProxy 的新版插件
sed -i '1i src-git custom_pkgs https://github.com/immortalwrt/packages.git' feeds.conf.default

echo "=========================================="
echo "diy-part1.sh completed successfully"
echo "=========================================="
