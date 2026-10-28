#!/bin/sh
echo "Solving module-03" >> /tmp/progress.log

# Participant commands for module-03 run as the rhel user (they own the SSH key
# and config for node1). Connect to node1 and reveal the negotiated key exchange.
cat > /tmp/solve-module-03.sh << 'EOF'
ssh -o BatchMode=yes node1 hostname
ssh -o BatchMode=yes -v node1 true 2>&1 | grep "kex: algorithm:"
ssh -o BatchMode=yes -o KexAlgorithms=curve25519-sha256 -v node1 true 2>&1 | grep "kex: algorithm:"
EOF
chmod +x /tmp/solve-module-03.sh
runuser -l rhel -c "sh /tmp/solve-module-03.sh"
rm -f /tmp/solve-module-03.sh

echo "Solved module-03" >> /tmp/progress.log
exit 0
