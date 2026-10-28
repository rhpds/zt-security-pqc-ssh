#!/bin/sh
echo "Validating module-02" >> /tmp/progress.log

# Objective: the system crypto policy is DEFAULT-based and OpenSSH offers ML-KEM.

POLICY=$(update-crypto-policies --show 2>/dev/null)
if ! echo "$POLICY" | grep -q "DEFAULT"; then
    echo "FAIL: crypto policy is '$POLICY', expected a DEFAULT-based policy"
    echo "HINT: run 'update-crypto-policies --show'; on RHEL 10.1+ it should read DEFAULT."
    exit 1
fi

if ! ssh -Q kex 2>/dev/null | grep -q "mlkem768x25519-sha256"; then
    echo "FAIL: OpenSSH does not list the post-quantum key exchange mlkem768x25519-sha256"
    echo "HINT: confirm with 'ssh -Q kex | grep mlkem'. Requires RHEL 10.1+ DEFAULT policy."
    exit 1
fi

echo "PASS: module-02 objectives verified (policy=$POLICY, ML-KEM available in OpenSSH)"
exit 0
