# Module 3: Create and Use Post-Quantum Authentication Keys (ML-DSA)

### Brief Overview

With post-quantum key exchange enforced, this module secures the other half of the SSH connection: authentication. The learner generates a hybrid post-quantum SSH key pair based on ML-DSA (FIPS 204), installs the public key on the server, and logs in using it. Verbose output confirms that authentication succeeds with the new post-quantum key. This completes the lab's end-to-end story: both the key exchange and the login are now protected against quantum-capable adversaries, using only standard RHEL 10 command-line tools.

### Audience and Time

- **Personas:** Junior system administrators and people new to Linux (beginner).
- **Prerequisites:** Completion of Modules 1 and 2 (post-quantum key exchange enforced). Comfort running `ssh-keygen` and copying a file/key to a remote host.
- **Estimated duration:** 10 minutes.

### Learning Objectives

- Create a hybrid post-quantum (ML-DSA) SSH key pair on RHEL 10 using `ssh-keygen` (maps to design objective 3).
- Configure the server to trust the new public key and authenticate to it with the ML-DSA key pair (maps to design objective 3).
- Verify successful post-quantum authentication by inspecting the SSH client output (maps to design objectives 2 and 3).

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Why authentication also needs post-quantum protection | 2 min |
| 2 | Generate an ML-DSA key pair | 3 min |
| 3 | Install the public key and log in with it | 5 min |

### Detailed Steps

1. Read the short concept: key exchange protects the session, but authentication keys prove identity; ML-DSA (FIPS 204) provides a post-quantum digital signature for SSH authentication.
2. On the client, generate a hybrid post-quantum authentication key pair with `ssh-keygen -t <ml-dsa-type>` (the ML-DSA key type), accepting the default file location or specifying a clear filename.
3. List the generated files and observe the new private key and matching `.pub` public key created by `ssh-keygen`.
4. Copy the new public key to the server's authorized keys, for example with `ssh-copy-id -i <key>.pub <user>@<server>` (or by appending it to `~/.ssh/authorized_keys` on the server).
5. Authenticate to the server using the new key with `ssh -vv -i <key> <user>@<server>`.
6. In the verbose output, locate the offer/acceptance lines for the ML-DSA key and confirm that authentication succeeded with the post-quantum key rather than a password or a classical key.
7. Confirm you are logged in on the server (for example with `hostname` or `whoami`), then log out with `exit`.
8. Optionally re-run `ssh -vv` and note that both the ML-KEM hybrid key exchange (from Module 2) and the ML-DSA authentication are now in use together.

### Key Takeaways

- Full post-quantum SSH protection requires both a post-quantum key exchange (ML-KEM) and post-quantum authentication (ML-DSA).
- ML-DSA (FIPS 204) is a post-quantum digital signature algorithm usable directly through the familiar `ssh-keygen` workflow.
- Generating and deploying an ML-DSA key uses the same steps administrators already know for classical SSH keys, lowering the barrier to adoption.
- Verbose `ssh -vv` output confirms which authentication key was accepted, giving verifiable proof of post-quantum login.

### Infrastructure Notes

- The learner needs write access to their own `~/.ssh` on the client and the ability to add a public key to the server's authorized keys for the SSH user account.
- A solve/validate playbook checks that an ML-DSA key pair exists and that authentication to the server succeeds using it.
