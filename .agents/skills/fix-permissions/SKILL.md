---
name: fix-permissions
description: Files written by opencode in the Docker container are created as root. This fixes permissions.
---

What to do:
Change permissions: chmod -R 1000:1000 .

When to use:
After any file has been written to by an agent.
