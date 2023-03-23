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


