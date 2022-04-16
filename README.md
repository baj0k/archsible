# Archsible
Ansible playbooks designed to automate the deployment of Arch Linux environment across different machines.

Playbooks in this repository are designed to ease the installation, configuration and hardening of the Arch Linux OS.
Please note that the playbooks are heavily customized and might require some changes before being useful for anyone else.

## Playbooks
Each playbook consists of two plays - installation of the base Arch Linux OS and post-installation configuration including the deployment of my dotfiles.

## Roles
- System installation with full disk encryption
- General post-installation configuration
- Blackarch repository configuration
- Dotfiles deployment

## Prerequisites
- UEFI support enabled on target machine
- sshpass installed on the ansible controller

## Usage
- Modify hosts.cfg file according to your needs
- Modify variables inside the playbooks and in the group_vars folder
- Boot the Arch Linux installation medium on target machine and set the root password with passwd command

Run the chosen playbook with:
$ ansible-playbook -i hosts.cfg --ask-pass playbook.yml

## Important information 
Below cases should be considered workarounds and changed as soon as possible.
- The LUKS1 format is used because grub doesn't yet fully support LUKS2. This requires upstream code to be patched.
- Any installation tasks that are done in chroot are using a command ansible module. This is due to the current lack of possibility to execute ansible playbooks in the remote chroot.
- In the dotfiles playbook there are task for installing the libxft-bgra package which is a patched version of libxft. Currently libxft has some troubles displaying some unicode glyphs.

## Full disk encryption
This setup utilizes the LVM on LUKS scenario using a single physical disk with two partitions.
The EFI partition is unencrypted and stores the bootloader binary (GRUB) which asks for a passphrase before being executed. 
The LUKS partition stores an encrypted LUKS container which is decrypted automatically with the key embedded in the initramfs that is loaded by the bootloader.

### How it works:
After the machine is powered on, the bootloader (GRUB) asks for a passphrase to be unlocked and executed.
Bootloader takes the kernel image and the initramfs which are used to bring up the rest of the system. In the initramfs, the path to the unencrypted key is stored which allows automatic decryption of the LUKS container during boot.

### Security considerations:
- With an encrypted boot partition, there is no option to modify user's kernel image or initramfs, but it would be still vulnerable to Evil Maid attacks.
- Randomness and length of the key makes it resistant to brute force and dictionary attacks.
- If the plain text key is kept with tight permissions (000 root:root) the only possibility for the attacker to obtain the decryption key is to gain root privileges on the running system at which point the system should already be considered fully compromised.
- GRUB doesn't yet support some of the LUKS 2 format features so the setup utilizes LUKS 1