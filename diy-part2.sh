#!/bin/bash
echo "======== diy-part2.sh 开始执行 ========"

# 关闭 DHCP（修改默认配置文件）
sed -i '/config dhcp '\''lan'\''/a\	option ignore '\''1'\''' package/base-files/files/etc/config/dhcp

# 确保中文优先（可选）
sed -i 's/option lang '\''en'\''/option lang '\''zh_cn'\''/' package/base-files/files/etc/config/luci 2>/dev/null || true

echo "======== diy-part2.sh 执行完成（DHCP 已关闭） ========"
