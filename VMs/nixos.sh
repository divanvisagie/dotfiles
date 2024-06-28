#!/bin/bash

# Define variables
ISO_PATH="Downloads/nixos-gnome-24.05.1695.dd457de7e08c-x86_64-linux.iso"
VM_NAME="nixos_vm"
VM_DISK="Disks/nixos_vm_disk.img"  
RAM_SIZE="4G"
CPU_COUNT="2"
DISK_SIZE="20G"
SSH_PORT=2222
LOG_FILE="nixos_vm.log"

# Function to start the VM
start_vm() {
  echo "Starting the VM from the virtual disk..." | tee -a "$LOG_FILE"
  qemu-system-x86_64 \
    -m "$RAM_SIZE" \
    -smp cpus="$CPU_COUNT" \
    -boot c \
    -drive file="$VM_DISK",format=qcow2 \
    -name "$VM_NAME" \
    -net nic -net user,hostfwd=tcp::${SSH_PORT}-:22 \
    -vga std \
    -display sdl \
    -enable-kvm &>> "$LOG_FILE" &
}

# Function to wait for SSH to be ready
wait_for_ssh() {
  echo "Waiting for SSH to be ready..." | tee -a "$LOG_FILE"
  while ! nc -z localhost $SSH_PORT; do
    sleep 5
  done
  echo "SSH is ready." | tee -a "$LOG_FILE"
}

# Check if the virtual disk already exists
if [ -f "$VM_DISK" ]; then
  echo "Virtual disk found. Booting from disk..." | tee -a "$LOG_FILE"
  start_vm
else
  echo "Virtual disk not found. Starting installation from ISO..." | tee -a "$LOG_FILE"

  # Create a virtual disk for the VM
  echo "Creating virtual disk..." | tee -a "$LOG_FILE"
  qemu-img create -f qcow2 "$VM_DISK" "$DISK_SIZE" | tee -a "$LOG_FILE"

  # Launch QEMU with the NixOS ISO for installation
  echo "Starting the VM with NixOS ISO..." | tee -a "$LOG_FILE"
  qemu-system-x86_64 \
    -m "$RAM_SIZE" \
    -smp cpus="$CPU_COUNT" \
    -boot d \
    -cdrom "$ISO_PATH" \
    -drive file="$VM_DISK",format=qcow2 \
    -name "$VM_NAME" \
    -net nic -net user,hostfwd=tcp::${SSH_PORT}-:22 \
    -vga std \
    -display sdl \
    -enable-kvm &>> "$LOG_FILE" &

  # Wait for the VM to boot and NixOS installer to be ready
  echo "Waiting for the VM to boot..." | tee -a "$LOG_FILE"
  sleep 30

  # Connect to the VM using SSH (assuming NixOS live environment has SSH enabled)
  echo "Connecting to the VM via SSH..." | tee -a "$LOG_FILE"
  ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:${SSH_PORT}" 2>/dev/null
  sshpass -p "nixos" ssh -o StrictHostKeyChecking=no -p ${SSH_PORT} nixos@localhost << 'EOF'
    sudo -i
    set -x
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

  echo "NixOS installation script completed. Rebooting the VM..." | tee -a "$LOG_FILE"

  # Wait for the VM to reboot and become ready
  sleep 60

  # Kill the existing QEMU process (installation VM)
  pkill qemu-system-x86_64

  # Boot the VM from the virtual disk
  start_vm

  # Wait for the VM to boot from the disk
  sleep 30
fi

# Wait for SSH to be ready
wait_for_ssh

# Reconnect to the VM after installation
echo "Connecting to the newly installed NixOS VM via SSH..." | tee -a "$LOG_FILE"
sshpass -p "nixos" ssh -o StrictHostKeyChecking=no -p ${SSH_PORT} nixos@localhost

echo "NixOS VM with GUI is up and running!" | tee -a "$LOG_FILE"
