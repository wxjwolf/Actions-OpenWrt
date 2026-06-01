#!/bin/bash
# diy-part2.sh - 编译后定制脚本

echo "=========================================="
echo "Starting diy-part2.sh"
echo "=========================================="

# 0. 防止 feeds 软链接冲突，确保使用新源里的 sing-box 和 homeproxy
rm -rf feeds/packages/net/sing-box
rm -rf feeds/luci/applications/luci-app-homeproxy

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

# 3. 配置 LAN 口静态网络信息 (IP: 192.168.2.2 | 网关: 192.168.2.1 | 掩码: 255.255.255.0)
echo "Configuring LAN interface static network..."
GEN_FILE="package/base-files/files/bin/config_generate"
if [ -f "$GEN_FILE" ]; then
    # 修改默认 IP 为 192.168.2.2
    sed -i 's/192.168.1.1/192.168.2.2/g' $GEN_FILE
    
    # 在 config_generate 的 lan 接口定义处插入网关(gateway)和子网掩码(netmask)
    # 官方原版通常用 ipad=$1, netm=$2 这种逻辑生成，我们直接在生成的默认配置模板中强制注入
    sed -i '/set network.lan.ipaddr/a\        set network.lan.gateway='\''192.168.2.1'\''\n        set network.lan.netmask='\''255.255.255.0'\''' $GEN_FILE
    
    # 顺便把默认的 DNS 也指向主路由，确保 OpenWrt 自身上网和 HomeProxy 正常更新规则
    sed -i '/set network.lan.gateway/a\        add network.lan.dns='\''192.168.2.1'\''' $GEN_FILE

    echo "✓ LAN IP set to 192.168.2.2"
    echo "✓ LAN Gateway set to 192.168.2.1"
    echo "✓ LAN Netmask set to 255.255.255.0"
    echo "✓ LAN DNS set to 192.168.2.1"
fi

echo "=========================================="
echo "diy-part2.sh completed successfully"
echo "=========================================="
