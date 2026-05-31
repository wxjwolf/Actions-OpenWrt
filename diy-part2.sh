#!/bin/bash
# diy-part2.sh - 编译后的定制脚本（精简版）

echo "=========================================="
echo "Starting diy-part2.sh (Post-compile)"
echo "=========================================="

# 1. 关闭 DHCP
echo "Disabling DHCP on LAN interface..."
if [ -f "package/network/services/dnsmasq/files/dhcp.conf" ]; then
    sed -i '/config dhcp '\''lan'\''/a\    option ignore '\''1'\''' package/network/services/dnsmasq/files/dhcp.conf
    echo "✓ DHCP disabled on LAN"
fi

# 2. 设置中文为默认语言
echo "Setting Chinese as default language..."
if [ -f "feeds/luci/modules/luci-base/root/etc/config/luci" ]; then
    sed -i 's/option lang '\''auto'\''/option lang '\''zh_cn'\''/g' feeds/luci/modules/luci-base/root/etc/config/luci
    echo "✓ Chinese language set"
fi

echo "=========================================="
echo "diy-part2.sh completed successfully"
echo "=========================================="
