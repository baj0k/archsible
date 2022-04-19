# Archsible
Ansible playbook designed to automate the deployment of Arch Linux environment across different machines.

## Plays
Archsible playbook consists of two plays - installation of the base Arch Linux OS and post-installation configuration.
Please note that the post-installation play is heavily customized and will require changes before being usable for anyone else.

## Roles
- install - Minimal system installation with optional full disk encryption
- post-install - Personalized post-installation configuration
- hardening - Bunch of tweaks to improve overall system security
- blackarch - Blackarch repository configuration and setup of penetration testing environment

## Prerequisites
- UEFI support enabled on target machine

## Usage
On target machine:
- Boot the Arch Linux installation medium and set the root password using passwd command

On ansible controller:
- Modify hosts.cfg file according to your needs
- Review default variables in the group_vars folder and change them if necessary

Run the playbook using following command. Host groups are defined in hosts.cfg file.
```
$ ansible-playbook archsible.yml --limit=<hosts_group>
```
Additionally, 'install' tag can be used to only install the base Arch Linux OS and skip post-configuration tasks.
```
$ ansible-playbook archsible.yml --limit=<hosts_group> --tags install
```
Similarly, 'post-install', 'hardening' and 'blackarch' tags can be used to only execute corresponding roles.

## Important information 
Below cases should be considered workarounds and changed when it becomes possible.
- The LUKS1 format is used for encryption because grub doesn't yet fully support LUKS2. This requires upstream code to be patched.
- Any installation tasks that are done in chroot are using a command ansible module. This happens due to the current lack of possibility to execute ansible tasks in remote chroot.
- Task for installing the libxft-bgra package which is a patched version of libxft are required because currently libxft has some troubles displaying unicode glyphs.

## Full disk encryption
This setup utilizes the LVM on LUKS scenario using a single physical disk with two partitions.
The EFI partition is unencrypted and stores the bootloader binary (GRUB) which asks for a passphrase before being executed. 
The LUKS partition stores an encrypted LUKS container which is decrypted with the key embedded in the initramfs.
LUKS container decryption happens automatically after initramfs is loaded by the bootloader.

### Security considerations:
- With an encrypted boot partition, there is no option to modify user's kernel image or initramfs, but it would be still vulnerable to Evil Maid attacks.
- Randomness and length of the key makes it resistant to brute force and dictionary attacks.
- If plain text key is kept with tight permissions (000 root:root) the only possibility for the attacker to obtain the decryption key is to gain root privileges on the running system at which point the system should already be considered fully compromised.
- GRUB doesn't yet support some of the LUKS 2 format features so the setup utilizes LUKS 1
