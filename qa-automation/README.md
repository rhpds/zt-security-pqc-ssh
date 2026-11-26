# Lab QA

Run from the lab repository in a runner that can reach the provisioned
bastion. The playbooks build their own inventory from `BASTION_HOST`,
`BASTION_PORT`, `BASTION_USER`, and `BASTION_PASSWORD` (the runner's
`ANSIBLE_USER` / `ANSIBLE_PASSWORD` are supported as fallbacks).
Provide credentials via the runner environment, not in Git or CLI arguments.
For a manual run, ensure the bastion's SSH host key is trusted.

```sh
ansible-playbook -i localhost, qa-automation/healthcheck.yml
ansible-playbook -i localhost, qa-automation/e2e.yml
```

Run E2E on a **fresh, disposable QA deployment** with these playbooks and
the same lab content/provisioning revision. Do not run concurrently on the
same deployment or use an active learner instance.

E2E follows the learner's `rhel` → `node1` SSH path rather than assuming a
second VM endpoint is exposed to the runner. It removes its temporary `sshd`
drop-in after testing and arms a timed rollback before the configuration change.
