# 为alist插件更换最新的golang版本
#update golang 19.x (Fix build for openwrt-21.02/22.03 branches)
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 19.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-alist package/alist

#替换luci-theme-argon和luci-app-argon-config
rm -rf feeds/luci/themes/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
rm -rf package/luci/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci/luci-app-argon-config

#修改默认登录地址：192.168.2.1
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

#修改默认主题为luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

#修改默认root登录samba
sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

#添加luci-app-adguardhome
git clone https://github.com/nhyoungboy/luci-app-adguardhome.git package/luci-app-adguardhome

