#!/bin/bash

# Define variables
ISO_PATH="Downloads/ubuntu-24.04-desktop-amd64.iso"
VM_NAME="ubuntu_vm"
VM_DISK="$HOME/Disks/ubuntu_vm_disk.img"  
RAM_SIZE="2G"
CPU_COUNT="2"
DISK_SIZE="30G"
SSH_PORT=2222
LOG_FILE="ubuntu_vm.log"
DOTFILES_DIR="$HOME/.dotfiles"
VM_USER="ubuntu"
VM_PASSWORD="ubuntu"

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

# Function to copy dotfiles and run the setup script
setup_dotfiles() {
  echo "Copying dotfiles to the VM..." | tee -a "$LOG_FILE"
  scp -r -P ${SSH_PORT} "$DOTFILES_DIR" ${VM_USER}@localhost:~/.dotfiles

  echo "Running dotfiles setup script on the VM..." | tee -a "$LOG_FILE"
  sshpass -p "${VM_PASSWORD}" ssh -o StrictHostKeyChecking=no -p ${SSH_PORT} ${VM_USER}@localhost << 'EOF'
    cd ~/.dotfiles
    ./setup.sh
EOF
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

  # Launch QEMU with the Ubuntu ISO for installation
  echo "Starting the VM with Ubuntu ISO..." | tee -a "$LOG_FILE"
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

  # Wait for the VM to boot and Ubuntu installer to be ready
  echo "Waiting for the VM to boot..." | tee -a "$LOG_FILE"
  sleep 30

  # Manual steps: Install Ubuntu via the graphical installer
  echo "Please complete the Ubuntu installation manually. Once done, the script will proceed."

  # Wait for user to complete installation and reboot the VM
  read -p "Press Enter once the installation is complete and the VM has rebooted..."

  # Boot the VM from the virtual disk
  start_vm

  # Wait for the VM to boot from the disk
  sleep 30
fi

# Wait for SSH to be ready
wait_for_ssh

# Reconnect to the VM after installation
echo "Connecting to the newly installed Ubuntu VM via SSH..." | tee -a "$LOG_FILE"
sshpass -p "${VM_PASSWORD}" ssh -o StrictHostKeyChecking=no -p ${SSH_PORT} ${VM_USER}@localhost

echo "Ubuntu VM is up and running!" | tee -a "$LOG_FILE"

# Copy dotfiles and run setup script
setup_dotfiles

echo "Dotfiles setup completed!" | tee -a "$LOG_FILE"
