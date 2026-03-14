#!/bin/bash

# 1. Set default IP
sed -i 's/192.168.1.1/192.168.1.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. Clear default password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 3. Rename Hostname
sed -i 's/OpenWrt/R2S-AutoExpand/g' openwrt/package/base-files/files/bin/config_generate

# 4. Auto-Expand Partition Script
# The backslash before EOF ensures the content is written exactly as-is.
cat <<\EOF >> openwrt/package/lean/default-settings/files/zzz-default-settings
if [ -b /dev/mmcblk0 ]; then
    # Resize partition 2 to take up the full SD card
    parted -s /dev/mmcblk0 resizepart 2 100%
    # Tell the kernel the partition table changed
    partprobe /dev/mmcblk0
    # Expand the actual data structures (Ext4)
    resize2fs /dev/mmcblk0p2
fi
EOF
