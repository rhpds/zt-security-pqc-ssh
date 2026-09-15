# zt-security-pqc-ssh

Hands-On Post-Quantum Cryptography (PQC) with RHEL 10 OpenSSH

In this hands-on lab, participants will explore the transition from classical encryption to quantum-resistant security using Red Hat Enterprise Linux 10. Designed for beginners with no prior post-quantum background, the lab demystifies the "Harvest Now, Decrypt Later" (HNDL) threat model and explains how Post-Quantum Cryptography (PQC) protects sensitive enterprise communications.

Through a series of step-by-step practical exercises, learners will inspect a standard, classical SSH session, configure system-wide cryptographic policies to enforce hybrid quantum-resistant key exchanges (ML-KEM), and generate next-generation hybrid authentication keys (ML-DSA). By inspecting raw SSH handshake logs (-vv), participants will directly observe how RHEL 10 seamlessly upgrades session security and user identity verification without breaking existing workflows.

Learning Objectives
Understand the core concepts of quantum computing threats (HNDL) and PQC in plain terms.

Inspect classical vs. post-quantum key exchange algorithms during active OpenSSH sessions.

Enforce hybrid post-quantum key exchange mechanisms in sshd.

Generate, deploy, and authenticate using post-quantum SSH key pairs on RHEL 10.

**Owner:** jscar-hawk

---

## What was set up

1. Repository created
2. `catalog-info.yaml` added to repository
3. Registered in Developer Hub catalog
4. Orchestrator workflow started — your AI-guided content pipeline is running!

## What happens next

Claude will walk you through the entire content lifecycle — from intake and spec creation, through Jira tracking and reviews, all the way to a published lab on RHDP. Just follow the prompts!

## Getting started

### DevSpaces (recommended)

1. Open in DevSpaces: `https://devspaces.apps.ocpv-infra02.wdc07.infra.demo.redhat.com#https://github.com/rhpds/zt-security-pqc-ssh`
2. Use Claude via the **extension** or the **CLI**:
   - **Extension:** Click the **Claude** icon in the sidebar, click **New Session**. If the Claude icon is not visible, open **Extensions** (`Ctrl/Cmd+Shift+X`), find **Claude Code for VS Code** under the DevSpaces section, click it, then click **Enable (Workspace)**.
   - **CLI:** Open a terminal and run `claude`
3. Run `/rhdp-publishing-house` — and you're off!

### Local machine

1. Install the skills:
   ```
   git clone -b prod https://github.com/rhpds/rhdp-publishing-house-skills.git ~/.claude/skills/publishing-house
   ```
2. Clone the repo:
   ```
   git clone https://github.com/rhpds/zt-security-pqc-ssh
   ```
3. `cd zt-security-pqc-ssh`
4. Start Claude CLI: `claude`
5. Run `/rhdp-publishing-house` — and you're off!
