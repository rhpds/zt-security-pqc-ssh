# step1_pqc_ssh_baseline

Provision the RHEL 10 client/server baseline for the PQC SSH lab — create the rhel SSH user account, lay down a baseline sshd_config, and ensure the DEFAULT system-wide crypto policy so learners start from a clean classical baseline.

## Requirements

None.

## Role Variables

| Variable | Default | Description |
|----------|---------|-------------|
| | | |

## Dependencies

None.

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: zt_security_pqc_ssh.ansible.step1_pqc_ssh_baseline
```

## License

GPL-2.0-or-later
