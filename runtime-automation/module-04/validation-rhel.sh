#!/bin/sh
echo "Validating module-04" >> /tmp/progress.log

# Objective: node1 now REQUIRES post-quantum key exchange — PQ connections work,
# classic-only connections are refused. Run as the rhel user.

# 1) The drop-in exists on node1.
if ! runuser -l rhel -c "ssh -o BatchMode=yes -o ConnectTimeout=15 node1 'test -f /etc/ssh/sshd_config.d/01-pqc-required.conf'"; then
    echo "FAIL: /etc/ssh/sshd_config.d/01-pqc-required.conf not found on node1"
    echo "HINT: on node1 run: echo 'KexAlgorithms mlkem768x25519-sha256' | sudo tee /etc/ssh/sshd_config.d/01-pqc-required.conf"
    exit 1
fi

# 2) A default (post-quantum) connection still works.
if ! runuser -l rhel -c "ssh -o BatchMode=yes -o ConnectTimeout=15 node1 true"; then
    echo "FAIL: cannot connect to node1 with the default key exchange after hardening"
    echo "HINT: on node1 run 'sudo sshd -t' then 'sudo systemctl restart sshd'; check the drop-in syntax."
    exit 1
fi

# 3) A classic-only connection is now rejected.
if runuser -l rhel -c "ssh -o BatchMode=yes -o ConnectTimeout=15 -o KexAlgorithms=curve25519-sha256 node1 true" 2>/dev/null; then
    echo "FAIL: node1 still accepts the classical curve25519-sha256 key exchange"
    echo "HINT: ensure the drop-in contains exactly 'KexAlgorithms mlkem768x25519-sha256' and sshd was restarted."
    exit 1
fi

echo "PASS: module-04 objectives verified (node1 requires post-quantum key exchange)"
exit 0
