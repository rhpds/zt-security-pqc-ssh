# step1_pqc_ssh_baseline

Provision the RHEL 10 client/server baseline for the PQC SSH lab — create the rhel SSH user account, lay down a baseline sshd_config, and ensure the DEFAULT system-wide crypto policy so learners start from a clean classical baseline.

## Requirements

None.

## Role Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `pqc_ssh_user` | `rhel` | SSH lab user account created on the hosts. |
| `pqc_ssh_user_groups` | `[wheel]` | Supplementary groups for the lab user (`wheel` grants sudo). |
| `pqc_ssh_user_passwordless_sudo` | `true` | Grant the lab user passwordless sudo (needed for Module 2). |
| `pqc_ssh_authorized_keys` | `[]` | Optional public keys to pre-install for the lab user. |
| `pqc_ssh_crypto_policy` | `DEFAULT` | System-wide crypto policy baseline (learners change it in Module 2). |
| `pqc_sshd_password_authentication` | `true` | Baseline `PasswordAuthentication` (on so learners can `ssh-copy-id`). |
| `pqc_sshd_pubkey_authentication` | `true` | Baseline `PubkeyAuthentication` (on for ML-DSA login). |

## Dependencies

- `ansible.posix` — for the `authorized_key` module (only used when `pqc_ssh_authorized_keys` is non-empty).

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: zt_security_pqc_ssh.ansible.step1_pqc_ssh_baseline
```

## License

GPL-2.0-or-later
