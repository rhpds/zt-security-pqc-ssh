# Module 1: Inspect a Classical SSH Session

### Brief Overview

This module establishes the classical baseline that the rest of the lab builds on. Learners connect from a RHEL 10 client to a RHEL 10 server over SSH and inspect the raw handshake so they can see which key exchange algorithm is negotiated by default. Along the way they meet the "Harvest Now, Decrypt Later" (HNDL) threat, which explains why a classical key exchange is a long-term risk. By the end, the learner has a concrete before picture to compare against once post-quantum key exchange is enforced in Module 2.

### Audience and Time

- **Personas:** Junior system administrators and people new to Linux (beginner).
- **Prerequisites:** Comfort with basic Linux commands (cd, ls, cat) and the ability to open an SSH connection. No cryptography background required.
- **Estimated duration:** 8 minutes.

### Learning Objectives

- Observe the key exchange algorithm negotiated during a default (classical) SSH session by inspecting raw handshake logs with `ssh -vv` (maps to design objective 2).
- Verify that the RHEL 10 client and server start from the DEFAULT system-wide crypto policy (baseline for design objectives 1 and 2).

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Why classical key exchange is a risk (HNDL framing) | 2 min |
| 2 | Connect to the server and read the handshake | 4 min |
| 3 | Record the baseline key exchange algorithm | 2 min |

### Detailed Steps

1. Read the short framing: quantum computers threaten today's public-key cryptography via the Harvest Now, Decrypt Later attack, where captured traffic is decrypted later once a capable quantum computer exists.
2. On the client host, confirm the active system-wide crypto policy by running `update-crypto-policies --show` and observe that it reports `DEFAULT`.
3. Open a verbose SSH connection to the server with `ssh -vv <user>@<server>` so the full handshake is printed to the terminal.
4. In the verbose output, locate the line beginning with `debug1: kex:` (or `debug2: KEX algorithms:`) that reports the negotiated key exchange algorithm.
5. Note that the negotiated key exchange is a classical algorithm (for example a curve25519- or ecdh-based method) with no post-quantum component.
6. Record the negotiated classical key exchange algorithm name — this is the baseline value to compare against in Module 2.
7. Log out of the SSH session with `exit` to return to the client shell.

### Key Takeaways

- SSH negotiates a key exchange algorithm at the start of every connection, and `ssh -vv` lets you see exactly which one was chosen.
- The RHEL 10 default crypto policy uses classical key exchange, which is vulnerable to the Harvest Now, Decrypt Later threat.
- Establishing a clear classical baseline makes the effect of enabling post-quantum key exchange visible in later modules.

### Infrastructure Notes

- Requires the two pre-provisioned RHEL 10 hosts (client + server) with the SSH user account already created.
- Both hosts must begin under the DEFAULT system-wide crypto policy so the baseline handshake is classical.
