---
name: tts-speaker
description: Auto-speak all responses using /tmp/speak helper/state script. Enabled when user asks for "voice output", "tts output", "read aloud", or something indicating they want to hear responses.
---

# TTS Speaker Skill (Auto-Speak Mode)

This skill speaks text aloud automatically when a helper script exists at `/tmp/speak`.

## How to enable voice mode

**Create the enabling script once**:
Run this bash snippet:

```bash
cat > /tmp/speak << 'EOF'
#!/bin/bash
VOICE="azelma"
if [ -n "$@" ]; then
    speakturbo -v $VOICE "\"$@\"" > /dev/null 2>&1 & fi
EOF

chmod +x /tmp/speak
```

After creating the script, **every response** will be spoken automatically.

## How to change voice

Edit `/tmp/speak` and update the VOICE line:

```bash
VOICE="jean"
```

## How to disable voice mode

Delete the script file completely:

```bash
rm -f /tmp/speak
```

After removal, responses will be text-only again.

## Available Voices

Run `speakturbo --list-voices`, and prompt the user to select a voice.
Then follow instructions in "[How to change voice](#how-to-change-voice)."

## How the skill determines whether to speak

Before generating each response, check if `/tmp/speak` exists:

```bash
if [ -f /tmp/speak ]; then
    # Set the response:
    TTS_TEXT="Your full text response here"
    # Speak this response:
    /tmp/speak "$TTS_TEXT"
    # Then output the text too:
    echo "$TTS_TEXT"
fi
```

## Rules

- Text wrapped in double quotes handles spaces correctly
- Skip embedded content like code blocks or markdown sections (don't read them aloud, but output to user as normal)
- Audio plays in background while text still displays to the user

## Quick Reference

| Action | Command |
|--------|---------|
| Enable voice mode | Create `/tmp/speak` as shown above |
| Speak message | Run `/tmp/speak <message>` to render audio |
| Change voice | Edit VOICE line in `/tmp/speak` |
| Disable voice mode | `rm -f /tmp/speak` |
| Check status | `[ -f /tmp/speak ] && echo "ENABLED" \|\| echo "DISABLED"` |

## Summary Flow

```
[Enable] → Write script to /tmp/speak, chmod +x
         ↓
[Every response] → [ -f /tmp/speak ]? YES → /tmp/speak text + output
                              NO → text-only output

[Disable] → rm -f /tmp/speak (state cleared via file deletion)
```
