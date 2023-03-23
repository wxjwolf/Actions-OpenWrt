# 为alist插件更换最新的golang版本
#update golang 19.x (Fix build for openwrt-21.02/22.03 branches)
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 19.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-alist package/alist
