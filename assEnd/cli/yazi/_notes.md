# yazi — Notes (AI-assistant observations, not acted on)

This module already pulls in zoxide as a dependency package for fast directory jumping inside yazi. That's separate from the old atomic/cli/tmux/zoxide/default.nix module, which you asked to scrap — this yazi-bundled zoxide package stays since it's part of yazi's own preview/navigation dependencies, not a standalone zoxide module.
