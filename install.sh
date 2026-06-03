#!/usr/bin/env bash
# Installation script for Super Saiyan Bug Bounty Skill (Linux/macOS)

SKILL_DIR="$HOME/.claude/skills/super-saiyan"

echo "🌟 Installing Super Saiyan Bug Bounty Skill..."

# Check if directory already exists
if [ -d "$SKILL_DIR" ]; then
    echo "⚠️ Skill directory already exists at $SKILL_DIR"
    echo "Updating existing installation..."
    cd "$SKILL_DIR" || exit
    git pull
else
    echo "Creating directory $SKILL_DIR..."
    mkdir -p "$HOME/.claude/skills"
    
    echo "Cloning repository..."
    git clone https://github.com/mridulrastogimrt02-svg/-super-saiyan-skill.git "$SKILL_DIR"
fi

echo "✅ Installation complete!"
echo "To use this skill, simply type '/skill super-saiyan' in your Claude/AI assistant interface."
