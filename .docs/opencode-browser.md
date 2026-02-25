# opencode-browser

`opencode-browser` is a combination of an `opencode` plugin, a Chrome extension, and a Chrome Native Messaging Host (through a unix socket). It sounds complicated, and sorta is, but it works pretty well out of the box. But because we're in `docker`, we need to do some slight modification to get things working correctly.

## Install

### Guided Install

You can find an easy to follow guided script at [.scripts/opencode_browser_setup](../.scripts/opencode_browser_setup).

Ensure your `opencode-agent` container is running, and run the script in your *host* terminal:

```sh
.scripts/opencode_browser_setup
```

This will run the `opencode-browser` setup process for your system, and automate the rest for you!

### Manual Install

Again, you really should use the supplied script, but if you *must* manually set it up, we got you covered.

#### Install the Package

The container comes pre-setup with the package itself, but it needs to further establish more configuration files and setup.

Install *inside* the running container:

```sh
docker exec -it opencode-agent bunx @different-ai/opencode-browser@latest install
```

#### Native Messaging Host

The extension uses a Native Messaging Host (NMH) that wraps a nodejs script to establish a socket connection to opencode. This typically works fine as expected, except our runtimes are in `docker` and Chrome is on our host. To alleviate this, we need to manually configure an NMH *wrapper* in place of the automated/supplied version. This wrapper simply executes the supplied NMH script inside the container. 

```sh
vim ~/.config/google-chrome/NativeMessagingHosts/com.opencode.browser_automation.json
```

and paste/edit the contents:

> Be sure the path is an *absolute* path!

```
{
  "name": "com.opencode.browser_automation",
  "description": "OpenCode Browser native messaging host",
  "path": "/absolute/path/to/.scripts/opencode_browser_wrapper",
  "type": "stdio",
  "allowed_origins": [
    "chrome-extension://ncfalpcdanbcccbaakenefpokeioldgd/"
  ]
}
```

Reload the extension in Chrome to initiate the NMH, and you should see the extension icon say `ON` in green. If not, the extension ID doesn't match, or something isn't mounted properly.