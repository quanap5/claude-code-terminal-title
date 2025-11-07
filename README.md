# Terminal Title Skill for Claude Code

## What It Does

Automatically updates your terminal window title to reflect the current task Claude Code is working on. Perfect for developers managing multiple Claude Code instances across different terminals.

## The Problem It Solves

Running multiple Claude Code sessions? Constantly clicking between terminals trying to remember which one is handling your API integration vs database migration vs bug fix? This skill eliminates that frustration.

## How It Works

The skill automatically:
1. Analyzes your prompt when you start a new task
2. Generates a concise, descriptive title (e.g., "API Integration: Auth Flow")
3. Updates your terminal window title in the background
4. No manual configuration needed

## Installation

### Quick Install (Recommended)

```bash
# Download the skill file, then install it:
claude-code install terminal-title.skill
```

### Manual Install

```bash
# Create skills directory if it doesn't exist
mkdir -p ~/.claude/skills

# Extract the skill
unzip terminal-title.skill -d ~/.claude/skills/
```

## Usage

**That's it!** The skill works automatically. When you start Claude Code and give it a task, your terminal title will update.

### Examples

**User prompt:** "Help me debug the authentication API"
**Terminal title:** → "Debug: Auth API Flow"

**User prompt:** "Create a React dashboard component"
**Terminal title:** → "Build: Dashboard UI"

**User prompt:** "Write tests for payment processing"
**Terminal title:** → "Test: Payment Module"

### Optional Customization

You can add a custom prefix to all terminal titles:

```bash
# Add to your ~/.bashrc, ~/.zshrc, or shell config:
export CLAUDE_TITLE_PREFIX="🤖 Claude"
```

This produces titles like: `🤖 Claude | Build: Dashboard UI`

## Compatibility

Works with:
- macOS Terminal
- iTerm2
- Alacritty
- Most modern terminal emulators supporting ANSI escape sequences

## Technical Details

- **Size:** ~2KB
- **Dependencies:** None (uses standard bash)
- **Triggers:** First prompt in a new session, or when switching to a new high-level task
- **Privacy:** All processing happens locally, no external calls

## Troubleshooting

### Title Not Updating?

1. **Verify installation:**
   ```bash
   ls -la ~/.claude/skills/terminal-title/
   # Should show: SKILL.md, scripts/, LICENSE, VERSION, CHANGELOG.md
   ```

2. **Check script permissions:**
   ```bash
   ls -la ~/.claude/skills/terminal-title/scripts/set_title.sh
   # Should show: -rwxr-xr-x (executable)
   ```

3. **If not executable, fix permissions:**
   ```bash
   chmod +x ~/.claude/skills/terminal-title/scripts/set_title.sh
   ```

4. **Test manually:**
   ```bash
   bash ~/.claude/skills/terminal-title/scripts/set_title.sh "Test: It Works!"
   # Your terminal title should change
   ```

### Title Shows Escape Codes?

Your terminal may not support ANSI escape sequences. Try:
- **macOS:** Use iTerm2 or built-in Terminal.app
- **Linux:** Use GNOME Terminal, Alacritty, or Kitty
- **Windows:** Use Windows Terminal or WSL with a compatible terminal

### Skill Not Triggering Automatically?

- Restart Claude Code after installation
- Verify SKILL.md is properly formatted (YAML front matter at top)
- Check Claude Code version supports skills

### Title Too Generic?

Be more specific in your prompts about what you want to accomplish

## Contributing

Found a bug? Have a feature request? Open an issue on GitHub or reach out directly.

## License

MIT - Use freely, modify as needed, share with your team.

---

Created to solve a real pain point in multi-terminal Claude Code workflows. Hope it helps your productivity too!
