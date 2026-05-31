#!/bin/bash
echo "======== diy-part1.sh 开始执行 ========"

# 修改默认 IP 为 192.168.2.2
sed -i 's/192.168.1.1/192.168.2.2/g' package/base-files/files/bin/config_generate

# 更换为 Argon 主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

# Samba 允许 root 登录
#sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

# 添加 ssr-plus feed
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> feeds.conf.default

# 更新 feed
./scripts/feeds update -a
./scripts/feeds install -a

echo "======== diy-part1.sh 执行完成 ========"
