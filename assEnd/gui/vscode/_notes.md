# vscode — Notes (AI-assistant observations, not acted on)

defaultEditor = true sets $EDITOR to `code`, which affects any CLI tool that shells out to $EDITOR (git commit messages, etc). If Neovim is meant to stay your default terminal editor, leave this option off/false so the two don't fight over $EDITOR.
