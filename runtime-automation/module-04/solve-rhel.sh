#!/bin/sh
echo "Solving module-04" >> /tmp/progress.log

# Participant commands for module-04 run as the rhel user, over SSH to node1:
# add an sshd drop-in that requires the post-quantum key exchange, test it,
# restart sshd, then verify PQ connections work and classic-only are rejected.
cat > /tmp/solve-module-04.sh << 'EOF'
ssh -o BatchMode=yes node1 "echo 'KexAlgorithms mlkem768x25519-sha256' | sudo tee /etc/ssh/sshd_config.d/01-pqc-required.conf && sudo sshd -t && sudo systemctl restart sshd"
sleep 2
echo "--- post-quantum connection (should succeed) ---"
ssh -o BatchMode=yes node1 hostname
echo "--- classic-only connection (should be rejected) ---"
ssh -o BatchMode=yes -o KexAlgorithms=curve25519-sha256 node1 hostname || echo "classic key exchange rejected, as expected"
EOF
chmod +x /tmp/solve-module-04.sh
runuser -l rhel -c "sh /tmp/solve-module-04.sh"
rm -f /tmp/solve-module-04.sh

echo "Solved module-04" >> /tmp/progress.log
exit 0
