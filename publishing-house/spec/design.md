# Getting Started with Post-Quantum Cryptography in RHEL 10 OpenSSH

## Overview

Quantum computers threaten today's public-key cryptography through the "Harvest Now, Decrypt Later" (HNDL) attack: adversaries capture encrypted traffic today and decrypt it once a capable quantum computer exists. Red Hat Enterprise Linux 10 ships post-quantum cryptography (PQC) support in OpenSSH so administrators can defend against this threat with existing tools and workflows. This lab is part 1 of a 3-part RH1 session and is scoped to ~30 minutes.

Participants will inspect the key exchange of a classical SSH session, enforce hybrid post-quantum key exchange (ML-KEM) system-wide using crypto policies, reconnect and confirm the change in the raw handshake logs, then generate a hybrid post-quantum authentication key (ML-DSA) and use it to log in — all on RHEL 10 from the command line.

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

1. Configure system-wide crypto policies to enforce hybrid post-quantum (ML-KEM) key exchange for OpenSSH on RHEL 10.
2. Observe the difference between classical and post-quantum key exchange by inspecting raw SSH handshake logs (`ssh -vv`).
3. Create and authenticate with a hybrid post-quantum (ML-DSA) SSH key pair on RHEL 10.

## Content Type

Lab (hands-on)

## Products & Technologies

- Red Hat Enterprise Linux 10
- OpenSSH (upstream project, as shipped in RHEL 10)
- ML-KEM (FIPS 203) and ML-DSA (FIPS 204) post-quantum algorithms

## Module Map

| Module | Title | Duration |
|--------|-------|----------|
| 1 | Inspect a Classical SSH Session | 8 min |
| 2 | Enforce Hybrid Post-Quantum Key Exchange (ML-KEM) | 12 min |
| 3 | Create and Use Post-Quantum Authentication Keys (ML-DSA) | 10 min |
| — | **Total hands-on** | **~30 min** |
| — | Intro / framing (HNDL context) | included in modules |
| — | **Total lab** | **~30 min** |

## Difficulty Level

Beginner

## Environment

**Learner view:** When the lab starts, the learner has terminal access to a RHEL 10 host (a "client") and can reach a second RHEL 10 host (a "server") over SSH. Both hosts are pre-provisioned with the default RHEL 10 system-wide crypto policy (DEFAULT) and a user account for SSH access. No PQC configuration is applied at start — that is the learner's job.

**Automation needed:** Yes

Automation must provision two RHEL 10 hosts (client + server), create the SSH user account and baseline `sshd` configuration, and ensure the DEFAULT crypto policy is in place so learners begin from a clean classical baseline. For a zero-touch showroom, per-module solve/validate playbooks confirm the crypto policy change and the presence/use of the ML-DSA key.

## Infrastructure Requirements

- **Cloud provider:** TBD — confirmed in infrastructure phase
- **Cluster type:** TBD — confirmed in infrastructure phase
- **OCP version:** TBD — confirmed in infrastructure phase
- **Topology:** TBD — confirmed in infrastructure phase
- **Sizing:** TBD — confirmed in infrastructure phase
- **Automation approach:** TBD — confirmed in infrastructure phase
- **AI/MaaS:** TBD — confirmed in infrastructure phase
- **External services:** TBD — confirmed in infrastructure phase
- **AAP version:** TBD — confirmed in infrastructure phase
- **Non-GA products:** TBD — confirmed in infrastructure phase

## Assessment Strategy (Optional)

This is a zero-touch lab, so each module is verifiable:

- **Module 1:** Learner captures baseline key exchange algorithm from `ssh -vv` output — validated by presence of the connection log / classical kex marker.
- **Module 2:** Validate that the system-wide crypto policy enforces a hybrid ML-KEM key exchange and that a new SSH session negotiates it (check `update-crypto-policies` state and the negotiated kex in the handshake).
- **Module 3:** Validate that an ML-DSA key pair exists and that authentication to the server succeeds using it.
