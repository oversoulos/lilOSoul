-- Dropdown & Scratchpad Window Rules
hl.windowrule({
  "float, class:^(ghostty-dropterm)$",
  "workspace special:dropdown silent, class:^(ghostty-dropterm)$",
  "size 85% 50%, class:^(ghostty-dropterm)$",
  "move 7.5% 4%, class:^(ghostty-dropterm)$",

  "float, class:^(ghostty-sysmon)$",
  "workspace special:sysmon silent, class:^(ghostty-sysmon)$",
  "size 80% 60%, class:^(ghostty-sysmon)$",
  "move 10% 20%, class:^(ghostty-sysmon)$"
})
