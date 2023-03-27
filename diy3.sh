# 为alist插件更换最新的golang版本
#update golang 19.x (Fix build for openwrt-21.02/22.03 branches)
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 19.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-alist package/alist

# 更改内核版本
#sed -i 's#^.*KERNEL_PATCHVER:=.*$#KERNEL_PATCHVER:=5.15#' target/linux/x86/Makefile

#修改默认登录地址：192.168.2.1
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

#修改默认主题为luci-theme-argonne
#sed -i 's/luci-theme-bootstrap/luci-theme-argonne/' feeds/luci/collections/luci/Makefile

#修改默认root登录samba
sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

#修改dhcp.sh,软路由IPTV验证登录
sed -i $'s/${vendorid:+-V \"$vendorid\"}/-V \'\'/' package/network/config/netifd/files/lib/netifd/proto/dhcp.sh
