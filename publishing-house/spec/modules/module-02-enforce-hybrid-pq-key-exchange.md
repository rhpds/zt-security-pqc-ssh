# Module 2: Enforce Hybrid Post-Quantum Key Exchange (ML-KEM)

### Brief Overview

In this module the learner defends against the Harvest Now, Decrypt Later threat by enforcing hybrid post-quantum key exchange system-wide. Using RHEL 10 crypto policies, the learner switches the system away from the classical DEFAULT baseline so that OpenSSH negotiates an ML-KEM (FIPS 203) based hybrid key exchange. The learner then reconnects to the server and re-reads the raw handshake to confirm the change actually took effect. This is the core "before and after" of the lab, done entirely with standard RHEL tooling.

### Audience and Time

- **Personas:** Junior system administrators and people new to Linux (beginner).
- **Prerequisites:** Completion of Module 1 (a recorded classical key exchange baseline). Comfort editing a file and running commands with `sudo`.
- **Estimated duration:** 12 minutes.

### Learning Objectives

- Configure the system-wide crypto policy to enforce hybrid post-quantum (ML-KEM) key exchange for OpenSSH on RHEL 10 (maps to design objective 1).
- Observe the difference between the classical and post-quantum key exchange by re-inspecting the raw SSH handshake with `ssh -vv` (maps to design objective 2).
- Verify that a new SSH session negotiates the hybrid ML-KEM key exchange (maps to design objectives 1 and 2).

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Understand crypto policies and ML-KEM | 3 min |
| 2 | Apply the post-quantum crypto policy | 4 min |
| 3 | Reconnect and confirm the ML-KEM handshake | 5 min |

### Detailed Steps

1. Read the short concept: RHEL system-wide crypto policies centrally control which algorithms applications like OpenSSH may use, and ML-KEM (FIPS 203) provides post-quantum key encapsulation used in a hybrid key exchange.
2. Confirm the current policy with `update-crypto-policies --show` and observe it still reports the classical `DEFAULT` from Module 1.
3. Apply the crypto policy that enables hybrid post-quantum key exchange system-wide using `sudo update-crypto-policies --set <PQ-policy>` (the policy that turns on ML-KEM hybrid key exchange).
4. Confirm the change with `update-crypto-policies --show` and observe that it now reports the post-quantum policy instead of `DEFAULT`.
5. If required for the running SSH service, restart or reload `sshd` on the affected host with `sudo systemctl restart sshd` so the new policy is in effect for new connections.
6. Reconnect to the server with `ssh -vv <user>@<server>` to capture the new handshake.
7. Locate the `debug1: kex:` line again and observe that the negotiated key exchange now names an ML-KEM based hybrid algorithm instead of the classical algorithm recorded in Module 1.
8. Compare the new negotiated key exchange value against the baseline recorded in Module 1 to confirm the post-quantum change took effect.
9. Log out with `exit` to return to the client shell.

### Key Takeaways

- System-wide crypto policies let an administrator change the algorithms every application uses with a single command, rather than editing each service's configuration.
- ML-KEM (FIPS 203) is used in a hybrid key exchange, combining a classical and a post-quantum method so security holds even if one is broken.
- Enforcing hybrid post-quantum key exchange directly addresses the Harvest Now, Decrypt Later threat for SSH traffic.
- The `ssh -vv` handshake output provides direct, verifiable evidence that the policy change altered the negotiated key exchange.

### Infrastructure Notes

- The crypto policy change is applied on the RHEL 10 host(s); ensure the learner has `sudo` privileges to run `update-crypto-policies` and restart `sshd`.
- A solve/validate playbook checks `update-crypto-policies` state and the negotiated key exchange in a new session to confirm hybrid ML-KEM is enforced.
