#!/bin/sh

LIBVIRT_DIR="${XDG_DATA_HOME:-/usr/share}/libvirt"
RELEASE="2022.04.05"

# Download Arch Linux ISO if not already present on the system
[ ! -e "${LIBVIRT_DIR}/iso/archlinux-${RELEASE}-x86_64.iso" ] && echo "Downloading Arch Linux ISO" || exit 0
aria2c -q --seed-time=0 --follow-torrent=mem --dir="${LIBVIRT_DIR}/iso" --on-download-complete="/bin/true" "https://archlinux.org/releng/releases/${RELEASE}/torrent/" || true

# Create VM
virt-install -q \
--name="${1:-archsible}" \
--vcpus=4 \
--memory=4096 \
--cdrom="${LIBVIRT_DIR}/iso/archlinux-${RELEASE}-x86_64.iso" \
--disk size=100,path="${LIBVIRT_DIR}/vm/${1:-archsible}.qcow2",format=qcow2 \
--os-variant=archlinux \
--graphics spice \
--boot uefi \
--wait=1 & sleep 5
virt-manager --connect qemu:///system --show-domain-console "${1:-archsible}"

# Run installation play
echo "Wait for the installation medium to boot and follow the steps from usage section in README.md. When you're ready press any key to execute the installation play."; read -r REPLY
echo "Provide guest system root password to continue."

ansible-playbook archsible.yml --limit=vms --tags install || exit 0 
[ "$(virsh list --all | grep "${1:-archsible}" | awk '{ print $3}' || true)" != "shut" ] &&
virsh shutdown --domain "${1:-archsible}" && sleep 5
virsh snapshot-create-as --domain "${1:-archsible}" --name "install" &&
virsh start --domain "${1:-archsible}"

# Run post-installation play
echo "wait for the machine to reboot. Depending on the network configuration of the hypervisor you may need to change the machine's ip address in the inventory file. To avoid errors regarding host key checking remove your ~/.ssh/known_hosts file. When you're ready press any key to execute the post-installation play."; read -r REPLY
echo "Provide guest system user password to continue."

ansible-playbook archsible.yml --limit=vms --skip-tags install || exit 0
[ "$(virsh list --all | grep "${1:-archsible}" | awk '{ print $3}' || true)" != "shut" ] &&
virsh shutdown --domain "${1:-archsible}" && sleep 5
virsh snapshot-create-as --domain "${1:-archsible}" --name "post-install" &&
virsh start --domain "${1:-archsible}"

# Connect to VM
killall virt-manager && 
sleep 5 && virt-manager --connect qemu:///system --show-domain-console "${1:-archsible}"
