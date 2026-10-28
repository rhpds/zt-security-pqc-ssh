#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

# Passwordless sudo for the lab user (needed for non-interactive sudo in scripts).
echo 'rhel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/rhel-nopasswd
chmod 0440 /etc/sudoers.d/rhel-nopasswd

echo "Setup vm rhel" > /tmp/progress.log
chmod 666 /tmp/progress.log

# --- Post-Quantum SSH lab provisioning (rhel = the bastion the participant uses) ---
# On RHEL 10.1+ the post-quantum algorithms are already part of the DEFAULT
# crypto-policy, and OpenSSH already offers the mlkem768x25519-sha256 key
# exchange. No packages or policy changes are required here — the participant
# simply observes and uses what is already enabled.

# Self-contained rhel -> node1 SSH using a throwaway, lab-only keypair embedded
# below (matched by the public key installed on node1 in setup-node1.sh). This
# keeps the lab working without depending on platform-provisioned inter-VM keys.
install_rhel_key() {
  home="$1"; owner="$2"; sshuser="$3"
  mkdir -p "$home/.ssh"
  cat > "$home/.ssh/id_ed25519" << 'KEYEOF'
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACB7DCPsAMLwMxElFrLF8goXmFRMw9yFW1mmndQRs7XQTwAAAKCjaa47o2mu
OwAAAAtzc2gtZWQyNTUxOQAAACB7DCPsAMLwMxElFrLF8goXmFRMw9yFW1mmndQRs7XQTw
AAAEBLcn0meKmC/2cx4+JIgzeoROBgh5HTtewXwQGmM9sAzXsMI+wAwvAzESUWssXyCheY
VEzD3IVbWaad1BGztdBPAAAAG3p0LXNlY3VyaXR5LXBxYy1zc2gtbGFiLWtleQEC
-----END OPENSSH PRIVATE KEY-----
KEYEOF
  cat > "$home/.ssh/id_ed25519.pub" << 'PUBEOF'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHsMI+wAwvAzESUWssXyCheYVEzD3IVbWaad1BGztdBP zt-security-pqc-ssh-lab-key
PUBEOF
  cat > "$home/.ssh/config" << CFGEOF
Host node1
    HostName node1
    User $sshuser
    IdentityFile $home/.ssh/id_ed25519
    StrictHostKeyChecking accept-new
CFGEOF
  chmod 700 "$home/.ssh"
  chmod 600 "$home/.ssh/id_ed25519" "$home/.ssh/config"
  chmod 644 "$home/.ssh/id_ed25519.pub"
  chown -R "$owner" "$home/.ssh"
}
install_rhel_key /home/rhel rhel:rhel rhel
install_rhel_key /root root:root root

# node1 hostname resolution: prefer platform-provided DNS. If the platform
# exposes node1's address via NODE1_IP (see setup-automation/main.yml), pin it
# in /etc/hosts as a fallback.
if [ -n "${NODE1_IP}" ] && ! getent hosts node1 >/dev/null 2>&1; then
  echo "${NODE1_IP} node1" >> /etc/hosts
fi

echo "Lab setup complete" >> /tmp/progress.log
exit 0
