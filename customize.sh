#!/bin/bash

# 1. Set default IP
sed -i 's/192.168.1.1/192.168.1.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. Clear default password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 3. Set Hostname
sed -i 's/OpenWrt/R2S-OpenClash/g' openwrt/package/base-files/files/bin/config_generate

# 4. Write Auto-Expand script for first boot
# Using \EOF is the verified fix for your previous syntax failure
cat <<\EOF >> openwrt/package/lean/default-settings/files/zzz-default-settings
if [ -b /dev/mmcblk0 ]; then
    # Expand the second partition to 100% of the SD card
    parted -s /dev/mmcblk0 resizepart 2 100%
    # Refresh partition table
    partprobe /dev/mmcblk0
    # Expand the filesystem to fill the new space
    resize2fs /dev/mmcblk0p2
fi
EOF
