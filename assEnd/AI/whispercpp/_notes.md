# whispercpp — Notes (AI-assistant observations, not acted on)

Model accuracy vs speed is the main lever for getting dictation quality close to what you described (something as accurate as a good phone dictation feature). `base` (the default) is fast but noticeably less accurate than `small` or `medium` — worth testing `small` first as a middle ground, especially since your Vega 7 iGPU handles Vulkan-accelerated inference reasonably well and you'll have 32GB RAM to work with.
