#!/bin/sh
echo "Validating module-01" >> /tmp/progress.log

# Objective: confirm this is a RHEL 10 host with post-quantum SSH available.

if ! grep -q "release 10" /etc/redhat-release 2>/dev/null; then
    echo "FAIL: this does not look like a RHEL 10 system"
    echo "HINT: this lab requires Red Hat Enterprise Linux 10.1 or later. Contact lab support."
    exit 1
fi

if ! command -v ssh > /dev/null 2>&1; then
    echo "FAIL: ssh client not found"
    echo "HINT: OpenSSH should be pre-installed. Contact lab support."
    exit 1
fi

if ! ssh -Q kex 2>/dev/null | grep -q "mlkem768x25519-sha256"; then
    echo "FAIL: OpenSSH does not offer the post-quantum key exchange mlkem768x25519-sha256"
    echo "HINT: this requires RHEL 10.1+ with the DEFAULT crypto-policy. Contact lab support."
    exit 1
fi

echo "PASS: module-01 objectives verified (RHEL 10 with post-quantum SSH available)"
exit 0
