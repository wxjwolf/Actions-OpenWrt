# 为alist插件更换最新的golang版本
#update golang 19.x (Fix build for openwrt-21.02/22.03 branches)
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 19.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-alist package/alist

#替换luci-theme-argon和luci-app-argon-config
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/applications/luci-app-argon-config
#git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config

# 更改内核版本
#sed -i 's#^.*KERNEL_PATCHVER:=.*$#KERNEL_PATCHVER:=6.1#' target/linux/x86/Makefile

#修改默认登录地址：192.168.2.1
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

#修改默认主题为luci-theme-argonne
#sed -i 's/luci-theme-bootstrap/luci-theme-argonne/' feeds/luci/collections/luci/Makefile

#修改默认root登录samba
sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

#修改dhcp.sh,软路由IPTV验证登录
sed -i $'s/${vendorid:+-V \"$vendorid\"}/-V \'\'/' package/network/config/netifd/files/lib/netifd/proto/dhcp.sh

# 修改“固件版本”，增加时间Build 2023.03.27 @ OpenWrt 
sed -i "s/OpenWrt /Build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

#增加lan桥接端口
sed -i "s/exit 0/uci set network.lan.ifname=\'eth0 eth2\'\nuci commit network\nexit 0/" package/lean/default-settings/files/zzz-default-settings

#修改主页显示时间格式
sed -i 's/os.date()/os.date(\"%Y年%m月%d日 %X\")/' package/feeds/luci/luci-mod-admin-full/luasrc/view/admin_status/index.htm
