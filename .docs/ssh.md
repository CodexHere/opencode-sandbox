## Overview
The `opencode-agent` container relies on SSH agent forwarding through the SSH_AUTH_SOCK environment variable. Most Linux distributions start SSH agent by default, but if it's not running, it must be bootstrapped manually.

## Key Requirements

### SSH Agent Bootstrapping
If SSH agent is not running on the host, it must be started with:
```bash
eval $(ssh-agent -s)
```

### Key Addition (if needed)
If the container requires SSH access, add the key using:
```bash
ssh-add ~/.ssh/id_rsa
```

### Verification
Check if SSH agent is running:
```bash
echo $SSH_AUTH_SOCK
```

## Critical Notes
- The container does NOT include or manage SSH keys
- Private keys remain on the host machine
- SSH agent is mounted via the SSH_AUTH_SOCK volume
- Keys must be manually removed using:
  - `ssh-add -d ~/.ssh/id_rsa` (to remove one key)
  - `ssh-add -D` (to remove all keys - caution: this removes all keys from the agent)
- The container will only work with properly configured SSH agent forwarding