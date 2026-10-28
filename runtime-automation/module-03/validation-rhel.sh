#!/bin/sh
echo "Validating module-03" >> /tmp/progress.log

# Objective: an SSH connection from rhel to node1 negotiates a post-quantum
# (ML-KEM) key exchange. Run as the rhel user, which holds the node1 key/config.

OUT=$(runuser -l rhel -c "ssh -o BatchMode=yes -o ConnectTimeout=15 -v node1 true 2>&1")

if ! echo "$OUT" | grep -q "kex: algorithm:"; then
    echo "FAIL: could not establish an SSH connection from rhel to node1"
    echo "HINT: from the rhel terminal try 'ssh node1'. Confirm node1 resolves and is up."
    exit 1
fi

if ! echo "$OUT" | grep "kex: algorithm:" | grep -q "mlkem"; then
    NEG=$(echo "$OUT" | grep "kex: algorithm:")
    echo "FAIL: the SSH connection did not negotiate a post-quantum key exchange"
    echo "       (got: $NEG)"
    echo "HINT: on RHEL 10.1+ the default 'ssh node1' should negotiate mlkem768x25519-sha256."
    exit 1
fi

echo "PASS: module-03 objectives verified (rhel -> node1 negotiated an ML-KEM key exchange)"
exit 0
