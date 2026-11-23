# Getting Started with Post-Quantum Cryptography in RHEL 10 OpenSSH

## Overview

Quantum computers threaten today's public-key cryptography through the "Harvest Now, Decrypt Later" (HNDL) attack: adversaries capture encrypted traffic today and decrypt it once a capable quantum computer exists. Red Hat Enterprise Linux 10 ships post-quantum cryptography (PQC) support in OpenSSH so administrators can defend against this threat with existing tools and workflows. This lab is part 1 of a 3-part RH1 session and is scoped to ~30 minutes.

Participants confirm that RHEL 10's DEFAULT system-wide crypto policy already includes a hybrid post-quantum key exchange (ML-KEM) for OpenSSH, prove a real SSH connection negotiates it by reading the raw handshake logs, contrast that against a forced classical-only connection, then harden the server's `sshd` configuration so it requires post-quantum key exchange and rejects classical fallbacks — all on RHEL 10 from the command line.

## Target Audience

- **Role:** Junior system administrators and people new to Linux
- **Experience level:** Beginner
- **What they already know:** Basic Linux command line navigation and how to open an SSH connection
- **What they don't know:** Post-quantum cryptography, the HNDL threat model, RHEL crypto policies, and how SSH key exchange and authentication algorithms are negotiated

## Prerequisites

- Comfort running basic commands in a Linux terminal (cd, ls, cat, editing a file)
- Familiarity with connecting to a host over SSH
- No prior cryptography or post-quantum background required

Automated validation of prerequisites: No — prerequisites are trust-based. The lab environment provides the RHEL 10 hosts and accounts pre-configured, so learners need only the general skills above.

## Learning Objectives

1. Confirm that post-quantum (ML-KEM) key exchange is already enabled in RHEL 10's DEFAULT system-wide crypto policy and in OpenSSH.
2. Observe the difference between classical and post-quantum key exchange by inspecting raw SSH handshake logs (`ssh -v`).
3. Harden an SSH server to require hybrid post-quantum (ML-KEM) key exchange and confirm classical-only clients are rejected.

## Content Type

Lab (hands-on)

## Products & Technologies

- Red Hat Enterprise Linux 10
- OpenSSH (upstream project, as shipped in RHEL 10)
- ML-KEM (FIPS 203) post-quantum key exchange algorithm

## Module Map

| Module | Title | Duration |
|--------|-------|----------|
| 1 | About This Lab | 5 min |
| 2 | Your Post-Quantum Foundation | 8 min |
| 3 | A Post-Quantum SSH Connection | 8 min |
| 4 | Require Post-Quantum SSH | 9 min |
| — | **Total hands-on** | **~30 min** |
| — | Intro / framing (HNDL context) | included in modules |
| — | **Total lab** | **~30 min** |

## Difficulty Level

Beginner

## Environment

**Learner view:** When the lab starts, the learner has terminal access to a single RHEL 10 bastion (`rhel`) and can reach a second RHEL 10 host (`node1`) over SSH. Both hosts are pre-provisioned with the default RHEL 10 system-wide crypto policy (DEFAULT, which already includes post-quantum ML-KEM) and a user account for SSH access. No PQC configuration is applied automatically — the learner confirms it's there, proves it on the wire, then makes it mandatory on `node1`.

**Automation needed:** Yes

Automation must provision two RHEL 10 hosts (`rhel` bastion + `node1`), create the SSH user account and baseline `sshd` configuration, and ensure the DEFAULT crypto policy is in place so learners begin from that baseline. QA for this lab is a single `qa-automation/e2e.yml` that drives the lab's steps end-to-end and asserts final state (crypto policy and negotiated kex, then that `node1` enforces post-quantum kex and rejects classical-only clients) — there are no per-module solve/validate playbooks.

## Infrastructure Requirements

- **Platform:** RHEL VMs
- **Cloud provider:** CNV
- **Topology:** Per-student (each learner gets their own isolated pair of hosts)
- **Sizing:** Per student — 1 RHEL 10 bastion (2 vCPU, 4GB RAM, 30GB disk) + 1 RHEL 10 node (2 vCPU, 4GB RAM, 30GB disk)
- **Automation approach:** Ansible
- **AI/MaaS:** None
- **External services:** cdn.redhat.com, subscription.rhsm.redhat.com (RHEL content pulled at provisioning; the student session is local bastion-to-node SSH)
- **AAP version:** N/A (AAP not used)
- **Non-GA products:** None (RHEL 10 and its post-quantum OpenSSH are GA)

## Assessment Strategy (Optional)

This is a zero-touch lab. There are no per-module solve/validate playbooks; QA is a single end-to-end test (`qa-automation/e2e.yml`) that performs the lab's steps and asserts the final state:

- The system-wide crypto policy is `DEFAULT` and OpenSSH offers `mlkem768x25519-sha256`.
- A real SSH connection from `rhel` to `node1` negotiates `mlkem768x25519-sha256`.
- After hardening `node1`'s `sshd` config, a post-quantum connection still succeeds and a classical-only connection (`curve25519-sha256`) is rejected.
