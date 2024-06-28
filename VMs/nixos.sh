#!/bin/bash

# Define variables
ISO_PATH="Downloads/nixos-gnome-x86_64-linux.iso"

VM_NAME="nixos_vm"
VM_DISK="~/Disks/nixos_vm_disk.img"
RAM_SIZE="4G"
CPU_COUNT="2"
DISK_SIZE="20G"

# Check if ISO path exists
if [ ! -f "$ISO_PATH" ]; then
  echo "ISO file not found at $ISO_PATH"
  exit 1
fi

# Create a virtual disk for the VM
echo "Creating virtual disk..."
qemu-img create -f qcow2 "$VM_DISK" "$DISK_SIZE"

# Launch QEMU with the NixOS ISO
echo "Starting the VM with NixOS ISO..."
qemu-system-x86_64 \
  -m "$RAM_SIZE" \
  -smp cpus="$CPU_COUNT" \
  -boot d \
  -cdrom "$ISO_PATH" \
  -drive file="$VM_DISK",format=qcow2 \
  -name "$VM_NAME" \
  -net nic -net user,hostfwd=tcp::2222-:22 \
  -vga std \
  -display sdl \
  -enable-kvm &

# Wait for the VM to boot and NixOS installer to be ready
echo "Waiting for the VM to boot..."
sleep 30

# Connect to the VM using SSH (assuming NixOS live environment has SSH enabled)
echo "Connecting to the VM via SSH..."
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2222" 2>/dev/null
sshpass -p "nixos" ssh -o StrictHostKeyChecking=no -p 2222 nixos@localhost << 'EOF'
  # Install NixOS
  sudo -i
  nixos-generate-config --root /mnt
  cat << 'EOL' > /mnt/etc/nixos/configuration.nix
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.device = "/dev/sda";
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.openssh.enable = true;
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$AqthL.R4$JL0NYau4MX3JXt.bokcq.G4Z/5mDmdBIC8Y62Z5ffK0md1vP4x5KxGp/7ZJLez5hF/b.IqgnzWfZz5LKo4W0G.";
  };
}
EOL
  nixos-install
  reboot
EOF

echo "NixOS installation script completed. Rebooting the VM..."

# Wait for the VM to reboot and become ready
sleep 60

# Reconnect to the VM after installation
echo "Connecting to the newly installed NixOS VM via SSH..."
sshpass -p "nixos" ssh -o StrictHostKeyChecking=no -p 2222 nixos@localhost

echo "NixOS VM with GUI is up and running!"
