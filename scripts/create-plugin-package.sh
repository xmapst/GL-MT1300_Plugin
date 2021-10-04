cd openwrt/bin/targets/*/*
rm -fr *
mkdir plugin

# plugin list in ../../../packages/mipsel_24kc
pkglist="base/frpc_*.ipk base/luci-app-frpc_*.ipk base/npc_*.ipk base/luci-app-nps_*.ipk base/UnblockNeteaseMusic_*.ipk base/luci-app-unblockneteasemusic_*.ipk base/shadowsocksr-libev-*.ipk base/pdnsd-alt_*.ipk base/chinadns-ng_*.ipk base/microsocks_*.ipk base/dns2socks_*.ipk base/simple-obfs*.ipk base/tcping_*.ipk base/v2ray*.ipk base/xray*.ipk base/trojan*.ipk base/ipt2socks_*.ipk base/redsocks2_*.ipk base/luci-app-passwall*.ipk base/luci-app-ssr-plus*.ipk luci/luci-compat_*.ipk base/xray-core_*.ipk gli_pub/shadowsocks-libev-ss-*.ipk base/shadowsocksr-libev-ssr-*.ipk base/luci-app-openclash*.ipk"

for pkg in $pkglist
do
    file=../../../packages/mipsel_24kc/$pkg
    ls=`ls $file 2>/dev/null`
    if [ -z $ls ]
    then
        echo "$pkg does not exists."
    else
        echo "Copying $pkg to plugin..."
        cp -f $file ./plugin/
    fi
done


echo "Creating installation script for passwall"
cat << EOF > ./plugin/install-passwall.sh
opkg update
opkg install luci ttyd luci-app-ttyd luci-compat luci-lib-ipkg wget htop
opkg install ./chinadns-ng_*.ipk
opkg install ./dns2socks_*.ipk
opkg install ./ipt2socks_*.ipk
opkg install ./microsocks_*.ipk
opkg install ./pdnsd-alt_*.ipk
opkg install ./shadowsocks-libev-ss-local_*.ipk
opkg install ./shadowsocks-libev-ss-redir_*.ipk
opkg install ./shadowsocksr-libev-ssr-local_*.ipk
opkg install ./shadowsocksr-libev-ssr-redir_*.ipk
opkg install ./simple-obfs*.ipk
opkg install ./tcping_*.ipk
opkg install ./trojan*.ipk
opkg install ./xray-core_*.ipk
opkg install ./v2ray-core_*.ipk
opkg install ./v2ray-plugin_*.ipk
opkg install ./luci-app-passwall_*.ipk
EOF

chmod +x ./plugin/install-passwall.sh

echo "Creating installation script for ssr plus"
cat << EOF > ./plugin/install-ssrp.sh
opkg update
opkg install luci ttyd luci-app-ttyd luci-compat luci-lib-ipkg wget htop
opkg install ./pdnsd-alt_*.ipk
opkg install ./microsocks_*.ipk
opkg install ./dns2socks_*.ipk
opkg install ./shadowsocksr-libev-ssr-local_*.ipk
opkg install ./simple-obfs*.ipk
opkg install ./tcping_*.ipk
opkg install ./ipt2socks_*.ipk
opkg install ./xray-core_*.ipk
opkg install ./v2ray-core_*.ipk
opkg install ./v2ray-plugin_*.ipk
opkg install ./shadowsocks-libev-ss-local_*.ipk
opkg install ./shadowsocks-libev-ss-redir_*.ipk
opkg install ./shadowsocksr-libev-ssr-check_*.ipk
opkg install ./shadowsocksr-libev-ssr-redir_*.ipk
opkg install ./trojan_*.ipk
opkg install ./luci-app-ssr-plus_*.ipk
EOF

chmod +x ./plugin/install-ssrp.sh

echo "Creating installation script for openclash"
cat << EOF > ./plugin/install-openclash.sh
opkg update
opkg install luci ttyd luci-app-ttyd luci-compat luci-lib-ipkg wget htop
opkg install ./luci-app-openclash_*.ipk
mkdir -p /etc/openclash/core
cd /etc/openclash/core
ARCH=mipsle-softfloat
clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')
wget $clash_main_url && tar zxvf clash-linux-*.gz && rm -f clash-linux-*.gz
chmod +x clash*
EOF

chmod +x ./plugin/install-openclash.sh

echo "Creating installation script for frpc"
cat << EOF > ./plugin/install-frpc.sh
opkg update
opkg install luci ttyd luci-app-ttyd luci-compat luci-lib-ipkg wget htop
opkg install ./frpc_*.ipk
opkg install ./luci-app-frpc_*.ipk
EOF

chmod +x ./plugin/install-frpc.sh

echo "Creating installation script for nps"
cat << EOF > ./plugin/install-nps.sh
opkg update
opkg install luci ttyd luci-app-ttyd luci-compat luci-lib-ipkg wget htop
opkg install ./npc_*.ipk
opkg install ./luci-app-nps_*.ipk
EOF

chmod +x ./plugin/install-nps.sh

echo "Creating installation script for unblockneteasemusic"
cat << EOF > ./plugin/install-unblockneteasemusic.sh
opkg update
opkg install luci ttyd luci-app-ttyd luci-compat luci-lib-ipkg wget htop
opkg install ./UnblockNeteaseMusic_*.ipk
opkg install ./luci-app-unblockneteasemusic_*.ipk
EOF

chmod +x ./plugin/install-unblockneteasemusic.sh
