This is an empty setup configuration for getting started with OpenCode and Ollama local hosted models.

## Calling Bash Tool

Always include a 'description' when calling the bash tool, or calls will fail validation.

For bash tool calls, use this exact structure: 
```json
{
    "command": "your shell command,
    "description": "5-10 word clear purpose of the command"
}
```

Example correct call: 
```
bash({"command": "git status, "description": "Check current repository status"})
```
    
NEVER call bash with only 'command' — always add 'description'.