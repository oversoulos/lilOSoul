# bat — Notes (AI-assistant observations, not acted on)

config.nix currently has environment.etc."bat/config".text defined twice — the second definition silently wins in Nix (last one set), so the first `settings`-driven block never actually takes effect. Flagging it here since it's a real bug carried over from the original file, not something introduced by this rewrite.
