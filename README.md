# GL-iNet MT1300 路由器OpenWrt 插件

感谢P3TERX的GitHub Actions项目，感谢Lienol和Lean两位大神所提供的插件

## 基于GL源码编译插件

使用19.07.07分支编译，包含插件 passwall，ssr plus, frpc, nps, unblockneteasemusic

- 空间不够可参考openwrt扩容overlay[将 Overlay 空间指向外置存储](https://blog.digicat-studio.com/Technology/openwrt_overlay.html)
- opkg update && opkg install block-mount luci ttyd luci-app-ttyd luci-compat luci-lib-ipkg wget htop

## 使用

使用官方原版固件，然后在[actions](https://github.com/xmapst/GL-MT1300_Plugin/actions)这里基于GL官方源码编译的插件，然后上传到GL官方固件进行安装ssrp或者psw。

可以同时安装ssrp和passwall
