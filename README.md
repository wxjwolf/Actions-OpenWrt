# OpenWrt 自动编译（x86 Legacy - 精简版）

基于 GitHub Actions 的 OpenWrt 自动编译工作流，仅生成 rootfs.tar.gz。

## 功能特性

- ✅ 编译 x86 Legacy (32位) 版本
- ✅ **仅生成 rootfs.tar.gz**（适用于 Docker/LXC/PVE CT）
- ✅ 集成 LuCI Web 界面
- ✅ 集成 SSR Plus（科学上网）
- ✅ 默认 IP: 192.168.2.2
- ✅ 默认关闭 DHCP
- ✅ 中文界面

## 使用方法

### 1. Fork 本仓库

点击 GitHub 右上角的 Fork 按钮

### 2. 触发编译

- **手动触发**: Actions → Build OpenWrt → Run workflow
- **自动触发**: 每天北京时间凌晨 2 点

### 3. 下载文件

编译完成后下载：
- `openwrt-rootfs.tar.gz` - rootfs 文件（约 200-300MB）
- `build-config` - 编译配置文件

## Docker 使用方法

```bash
# 1. 导入镜像
zcat openwrt-rootfs.tar.gz | docker import - openwrt:x86-legacy

# 2. 运行容器
docker run -d \
  --name openwrt \
  --privileged \
  --network host \
  --restart unless-stopped \
  openwrt:x86-legacy /sbin/init

# 3. 进入容器
docker exec -it openwrt /bin/bash
