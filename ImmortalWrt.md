### 1. 预安装的软件包
<pre><code>apk-openssl autocore base-files ca-bundle curl default-settings-chn dnsmasq-full dropbear firewall4 grub2-bios-setup kmod-button-hotplug kmod-nf-nathelper kmod-nft-offload kmod-vmxnet3 libc libgcc libustream-openssl logd luci nano netifd nftables procd-ujail uci uclient-fetch urandom-seed urngd luci-app-homeproxy luci-i18n-homeproxy-zh-cn sing-box</code></pre>

### 2. 首次启动脚本 (uci-defaults)
```bash
# 1. 基础参数定义 (完美适配 25.12+ 的 CIDR 格式)
lan_ip_address="192.168.2.2/24"   # 包含 255.255.255.0 子网掩码
lan_gateway="192.168.2.1"
lan_dns="192.168.2.1"
root_password=""                  # 留空则代表首次登录不需要密码

# 开启日志记录
exec >/tmp/setup.log 2>&1

# 2. 配置 Root 密码
if [ -n "$root_password" ]; then
  (echo "$root_password"; sleep 1; echo "$root_password") | passwd > /dev/null
fi

# 3. 配置 LAN 口网络信息（旁路由核心逻辑）
if [ -n "$lan_ip_address" ]; then
  # 设置静态 IP 地址与 CIDR 掩码
  uci set network.lan.ipaddr="$lan_ip_address"
  
  # 设置网关
  uci set network.lan.gateway="$lan_gateway"
  
  # 设置 DNS 服务器
  uci del network.lan.dns 2>/dev/null
  uci add_list network.lan.dns="$lan_dns"
  
  # 【关键】关闭旁路由 LAN 口的 DHCP 广播服务，防止与主路由冲突
  uci set dhcp.lan.ignore='1'
  
  # 提交保存网络与 DHCP 配置
  uci commit network
  uci commit dhcp
fi

echo "All done! Side-gateway configuration applied."
