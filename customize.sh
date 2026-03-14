#!/bin/bash

# 1. Set default IP
sed -i 's/192.168.1.1/192.168.1.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. Clear default password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 3. Rename Hostname
sed -i 's/OpenWrt/R2S-AutoExpand/g' openwrt/package/base-files/files/bin/config_generate

# 4. Auto-Expand Partition Script (Runs on first boot)
cat <<EOF >> openwrt/package/lean/default-settings/files/zzz-default-settings
# Install required tools for resizing
if [ -b /dev/mmcblk0 ]; then
    # Use parted to expand the partition (assuming partition 2 is rootfs)
    parted -s /dev/mmcblk0 resizepart 2 100%
    # Inform the kernel of the change
    partprobe /dev/mmcblk0
    # Expand the filesystem (for ext4)
    resize2fs /dev/mmcblk0p2
fi
EOF
