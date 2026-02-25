# Sync Tool Notes:

On Local/Dev Host:
```
.scripts/sync_tool -s remotehost.local -p .scripts 
```

On Remote/Docker Host:
```
# /tmp/sync is the default path of -t TARGET
./sync_tool -r ollama -p /tmp/sync -t /workspace
```

This will sync from the host to the remote at the default `tmp/sync`.
And on the Remote host it will sync from the path into the `ollama` container at `/workspace`




Modelfile Params:
https://github.com/ollama/ollama/blob/main/docs/modelfile.mdx
