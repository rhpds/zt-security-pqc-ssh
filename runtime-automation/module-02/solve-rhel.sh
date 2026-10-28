#!/bin/sh
echo "Solving module-02" >> /tmp/progress.log

# Participant commands for module-02: inspect the PQC foundation (read-only).
cat /etc/redhat-release
update-crypto-policies --show
ssh -Q kex
ssh -Q kex | grep mlkem
runuser -l rhel -c "ssh -G node1 | grep -i kexalgorithms"

echo "Solved module-02" >> /tmp/progress.log
exit 0
