#!/bin/bash
# ovrOS-resume – Auto-generate resume from character cards

CARD="$1"

# Load card data
NAME=$(yq '.name' ~/.config/ovrOS/cards/$CARD/card.yaml)
SKILLS=$(yq '.skills[]' ~/.config/ovrOS/cards/$CARD/card.yaml)
TOOLS=$(yq '.tools[]' ~/.config/ovrOS/cards/$CARD/card.yaml)
HOURS=$(yq '.hours' ~/.config/ovrOS/cards/$CARD/experience.yaml)
QUESTS=$(yq '.quests[]' ~/.config/ovrOS/cards/$CARD/quests.yaml)

# Generate markdown resume
cat << EOF > ~/Documents/Resume_$NAME.md
# $NAME – Resume

## Skills
$SKILLS

## Tools
$TOOLS

## Experience
$HOURS hours logged

## Projects
$QUESTS

---
*Auto-generated from ovrOS character card data*
*Last updated: $(date)*
EOF

echo "✅ Resume generated: ~/Documents/Resume_$NAME.md"