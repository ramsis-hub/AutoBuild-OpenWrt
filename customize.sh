#!/bin/bash

# 1. Set default IP (Change 192.168.1.1 if you need a different gateway)
sed -i 's/192.168.1.1/192.168.1.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. Clear default password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 3. Rename Hostname
sed -i 's/OpenWrt/R2S-OpenClash/g' openwrt/package/base-files/files/bin/config_generate
