#!/bin/sh

LIBVIRT_DIR="${XDG_DATA_HOME:-/usr/share}/libvirt"
RELEASE="2022.04.05"

# Download Arch Linux ISO if not already present on the system
[ ! -e "${LIBVIRT_DIR}/iso/archlinux-${RELEASE}-x86_64.iso" ] && echo "Downloading Arch Linux ISO"
/usr/bin/aria2c -q --seed-time=0 --follow-torrent=mem --dir="${LIBVIRT_DIR}/iso" --on-download-complete="/bin/true" "https://archlinux.org/releng/releases/${RELEASE}/torrent/" || true

# Create VM
/usr/bin/virt-install -q \
--name="${1:-archsible}" \
--vcpus=4 \
--memory=4096 \
--cdrom="${LIBVIRT_DIR}/iso/archlinux-${RELEASE}-x86_64.iso" \
--disk size=100,path="${LIBVIRT_DIR}/vm/${1:-archsible}.qcow2",format=qcow2 \
--os-variant=archlinux \
--graphics spice \
--boot uefi \
--wait=1 & /usr/bin/sleep 5

echo "Wait for the installation medium to boot and follow the steps from usage section in README. Ansible playbooks will be executed automatically by this script. When you're ready press any key to continue." && read -r

# Run installation play and create snapshot if successful
echo "Provide guest system root password to continue."
/usr/bin/ansible-playbook archsible.yml --limit=vms --tags install || exit 0 
[ "$(/usr/bin/virsh list --all | /usr/bin/grep "${1:-archsible}" | /usr/bin/awk '{ print $3}' || true)" != "shut" ] &&
/usr/bin/virsh shutdown --domain "${1:-archsible}" && /usr/bin/sleep 5
/usr/bin/virsh snapshot-create-as --domain "${1:-archsible}" --name "install" &&
/usr/bin/virsh start --domain "${1:-archsible}"

# Run post-installation play and create snapshot if successful
echo "Provide guest system user password to continue."
/usr/bin/ansible-playbook archsible.yml --limit=vms --skip-tags install || exit 0
[ "$(/usr/bin/virsh list --all | /usr/bin/grep "${1:-archsible}" | /usr/bin/awk '{ print $3}' || true)" != "shut" ] &&
/usr/bin/virsh shutdown --domain "${1:-archsible}" && /usr/bin/sleep 5
/usr/bin/virsh snapshot-create-as --domain "${1:-archsible}" --name "post-install" &&
/usr/bin/virsh start --domain "${1:-archsible}"

# Connect to VM
/usr/bin/killall /usr/bin/virt-manager && 
/usr/bin/sleep 5 && /usr/bin/virt-manager --connect qemu:///system --show-domain-console "${1:-archsible}"
