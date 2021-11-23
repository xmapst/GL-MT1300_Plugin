cd /workdir
mkdir -p /workdir/openwrt/package/lean

# Add luci-app-ssr-plus
cd /workdir/openwrt/package/lean
git clone --depth=1 https://github.com/fw876/helloworld

cd /workdir/openwrt
cd /workdir/lede/package/lean
plist="shadowsocksr-libev pdnsd-alt microsocks dns2socks simple-obfs v2ray-plugin v2ray xray trojan trojan-go ipt2socks redsocks2 kcptun luci-app-zerotier frp luci-app-frpc luci-app-nps nps"
for dir in $plist
do
    if [ -d $dir ]
    then
        echo "Copying plugin $dir to /workdir/openwrt/package/lean ..."
        cp -rp $dir /workdir/openwrt/package/lean/
    else
        echo "$dir does not exists..."
    fi
done

cd /workdir/openwrt
[ -d /workdir/openwrt/feeds/gli_pub/shadowsocks-libev ] && mv /workdir/openwrt/feeds/gli_pub/shadowsocks-libev /workdir/openwrt/feeds/gli_pub/shadowsocks-libev.bak
if [ -d /workdir/lede/feeds/packages/net/shadowsocks-libev ]
then
    [ -d /workdir/openwrt/feeds/packages/net/shadowsocks-libev ] && mv /workdir/openwrt/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/packages/net/shadowsocks-libev.bak
    [ -d /workdir/openwrt/feeds/gli_pub ] && cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/gli_pub/shadowsocks-libev
    [ -d /workdir/openwrt/package/lean/helloworld ] && cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/package/lean/helloworld/
    cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/packages/net/shadowsocks-libev
fi

rm -rf /workdir/openwrt/feeds/packages/net/wget
cp -rp /workdir/lede/package/lean/wget /workdir/openwrt/feeds/packages/net/wget
cp -rp /workdir/lede/package/lean/wget /workdir/openwrt/package/lean/wget

# Clone community packages to package/community
mkdir package/community
cd /workdir/openwrt/package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add Serverchan plugin
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add AutoPowerOff plugin
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset
# set plugin file mode 755
find ./luci-app-autotimeset -type d | xargs chmod 755
find ./luci-app-autotimeset -type f | xargs chmod 755

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add gotop
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop

# Add NeteaseMusic plugin
cp -r /workdir/lede/package/lean/UnblockNeteaseMusic /workdir/openwrt/package/lean/
cp -r /workdir/lede/package/lean/UnblockNeteaseMusic-Go /workdir/openwrt/package/lean/
cp -r /workdir/lede/package/lean/luci-app-unblockmusic /workdir/openwrt/package/lean/
ln -s /workdir/openwrt/package/lean/luci-app-unblockmusic/po/zh-cn /workdir/openwrt/package/lean/luci-app-unblockmusic/po/zh_Hans

# Add smartdns
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt ../smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns ../luci-app-smartdns

# Add adbyby
cp -r /workdir/lede/package/lean/adbyby ./
cp -r /workdir/lede/package/lean/luci-app-adbyby-plus ./


# Add openclash
#cd /workdir/openwrt/package/community
#git clone --depth=1 -b master https://github.com/vernesong/OpenClash
#ARCH=mipsle-softfloat
#cd /workdir/openwrt
#mkdir -p files/etc/openclash/core
#cd files/etc/openclash/core

#clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')
#clash_tun_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN-Premium | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')
#clash_game_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')

#wget $clash_main_url && tar zxvf clash-linux-*.gz && rm -f clash-linux-*.gz
#wget -qO- $clash_main_url | gunzip -c > clash
#wget -qO- $clash_tun_url  | gunzip -c > clash_tun
#wget -qO- $clash_game_url | tar xOvz > clash_game

#chmod +x clash*

