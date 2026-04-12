# Quick Piper Voices

apt install -y git-lfs

mkdir /piper-voices && \
cd /piper-voices && \
git init && \
git remote add origin https://huggingface.co/rhasspy/piper-voices && \
git sparse-checkout init --cone && \
git sparse-checkout set en && \
git config --local lfs.fetchinclude "en/**" && \
git pull origin main

# JUNK, need to delete, don't document any further
Consider:
* Look at starting speakturbo-daemon behind the scenes
* Replacing speakturbo with Piper, and ability to clone voices locally.

Modelfile Params:
https://github.com/ollama/ollama/blob/main/docs/modelfile.mdx


# Model Review

## qwen3:8b-q4_K_M

Not bad, but tends to over think and then suddenly gets really dumb. Need to play more, but it's kinda slow.

## qwen3:8b-q8_0

I thought the q4_K_M variant was a thinker, this one is insanely big thinking.

`/no_think` doesn't seem to have any effect , which is annoying as hell.

## qwen3:4b-instruct-2507-q4_K_M

honestly, pretty trash. didn't really do anything i asked, even though it claimed it did.

## qwen3.5:9b-q8_0
