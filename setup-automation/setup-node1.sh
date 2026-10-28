#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

# Passwordless sudo so the rhel user can harden sshd in module-04 over SSH
# non-interactively (sudo tee / sudo systemctl restart sshd).
echo 'rhel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/rhel-nopasswd
chmod 0440 /etc/sudoers.d/rhel-nopasswd

echo "Setup vm node1" > /tmp/progress.log
chmod 666 /tmp/progress.log

# --- node1 = the SSH server the participant connects to from rhel ---
# RHEL 10.1+ already ships OpenSSH with post-quantum key exchange enabled via the
# DEFAULT crypto-policy, so sshd here accepts mlkem768x25519-sha256 out of the box.
# We only install the throwaway lab public key so rhel can connect without a
# password. The participant hardens sshd to *require* PQ key exchange in module-04.

LAB_PUBKEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHsMI+wAwvAzESUWssXyCheYVEzD3IVbWaad1BGztdBP zt-security-pqc-ssh-lab-key'

authorize_key() {
  home="$1"; owner="$2"
  mkdir -p "$home/.ssh"
  touch "$home/.ssh/authorized_keys"
  grep -qF "$LAB_PUBKEY" "$home/.ssh/authorized_keys" || echo "$LAB_PUBKEY" >> "$home/.ssh/authorized_keys"
  chmod 700 "$home/.ssh"
  chmod 600 "$home/.ssh/authorized_keys"
  chown -R "$owner" "$home/.ssh"
}
authorize_key /home/rhel rhel:rhel
authorize_key /root root:root

systemctl enable --now sshd

echo "Lab setup complete" >> /tmp/progress.log
exit 0
