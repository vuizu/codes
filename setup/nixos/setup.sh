#!/bin/bash

function partition_and_formatting() {
    disk_name=/dev/nvme0n1

    ######## Partitioning the disk ########
    # Create a GPT partition table.
    parted $disk_name -- mklabel gpt

    # Add the root partition.
    parted $disk_name -- mkpart root ext4 513MB 100%

    # Add the boot partition.
    parted $disk_name -- mkpart ESP fat32 1MB 512MB
    # Set partition flag state.
    # beacasue the ESP was created first.
    parted $disk_name -- set 2 esp on

    # Add a swap partition.
    # parted $disk_name -- mkpart swap linux-swap -8GB 100%

    ######## Formatting the root partition ########
    mkfs.ext4 -L nixos ${disk_name}p1
    mkfs.fat -F 32 -n boot ${disk_name}p2
    
    mount /dev/disk/by-label/nixos /mnt

    mkdir -p /mnt/boot
    mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

}



# systemctl start wpa_supplicant
# wpa_cli
# > add_network
# > set_network 0 ssid "wifi_name"
# > set_network 0 psk "wifi_password"
# > set_network 0 key_mgmt WPA-PSK
# > enable_network 0
# > quit

mkdir -p ~/.config/nix
echo "substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/" >> ~/.config/nix/nix.conf
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
systemctl restart nix-daemon

nix-shell -p git --command "git clone https://gitclone.com/github.com/vuizu/cpp-practice.git"

# Generate the NixOS configuration.
nixos-generated-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ./

# the root password you set here will be discarded when reboot.
nixos-install --flake .#ntwd --no-root-passwd --show-trace --verbose --option substituters https://mirrors.ustc.edu.cn/nix-channels/store
# reboot

# nixos-rebuild switch --option substituters https://mirrors.ustc.edu.cn/nix-channels/store