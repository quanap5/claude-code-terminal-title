# Terminal Title Skill for Claude Code

Automatically update terminal window titles based on your current Claude Code task. Stop playing "which terminal is which?" with multiple AI coding sessions.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Version](https://img.shields.io/badge/version-1.1.0-green)
![Size](https://img.shields.io/badge/size-~2KB-blue)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey)

## Why This Exists

When running multiple Claude Code instances, terminal windows all look the same. You waste time clicking between tabs, trying to remember which session is handling what task.

This skill solves that by automatically updating your terminal title to reflect the current high-level task:

- `API Integration: Auth Flow`
- `Debug: Login Bug`
- `Build: Dashboard UI`
- `Test: Payment Module`

## Features

- ✅ **Zero Configuration** - Install and forget, works automatically
- 🤖 **AI-Powered** - Claude extracts task context from your prompts
- 🚀 **Lightweight** - 2KB package, no dependencies
- 🔄 **Automatic Updates** - Title changes when you switch tasks
- 🖥️ **Cross-Platform** - Works with iTerm2, Terminal, Alacritty, and more
- 📦 **Easy Distribution** - Single .skill file, standard installation

## Installation

### Quick Install

```bash
# Download terminal-title.skill, then:
claude-code install terminal-title.skill
```

### Manual Install

```bash
# Create skills directory
mkdir -p ~/.claude/skills

# Extract the skill
unzip terminal-title.skill -d ~/.claude/skills/
```

## Usage

That's it! The skill works automatically when you use Claude Code.

### Examples

| Your Prompt | Terminal Title |
|------------|----------------|
| "Help me debug the authentication API" | `Debug: Auth API Flow` |
| "Create a React dashboard component" | `Build: Dashboard UI` |
| "Write tests for payment processing" | `Test: Payment Module` |
| "Optimize database queries" | `Optimize: DB Queries` |

### Optional Customization

Add a custom prefix to all terminal titles:

```bash
# Add to your ~/.bashrc, ~/.zshrc, or shell config:
export CLAUDE_TITLE_PREFIX="🤖 Claude"
```

**Result:** `🤖 Claude | Build: Dashboard UI`

This is perfect for:
- Distinguishing Claude terminals from other work
- Adding personality to your terminal titles
- Team environments where multiple people use Claude Code

## How It Works

1. You start Claude Code and give it a prompt
2. The skill analyzes your request and extracts the high-level task
3. It generates a concise title (max 40 characters)
4. Your terminal window title updates automatically
5. No interruption to your workflow

## Compatibility

**Terminal Emulators:**
- ✅ macOS Terminal
- ✅ iTerm2
- ✅ Alacritty
- ✅ Most terminals supporting ANSI escape sequences

**Operating Systems:**
- ✅ macOS
- ✅ Linux
- ⚠️ Windows (WSL/Git Bash should work)

## Technical Details

### What's Inside

```
terminal-title/
├── SKILL.md                 # Skill instructions for Claude Code
├── LICENSE                  # MIT License
├── VERSION                  # Semantic version number
├── CHANGELOG.md             # Version history and changes
└── scripts/
    └── set_title.sh         # Terminal title update script
```

### How the Skill Triggers

The skill automatically activates:
- At the start of every new Claude Code session (first prompt)
- When switching to a substantially different task (e.g., frontend → backend, debugging → new feature)

**Triggers on:**
- Moving from debugging to new feature development
- Changing from one module to a completely different one
- Starting work on a different part of the system

**Does NOT trigger for:**
- Follow-up questions on the same task ("Can you add a comment?")
- Small refinements ("Make it blue instead of red")
- Debugging the same feature you just built
- Clarifications or status updates

## Comparison with Existing Solutions

| Feature | Zsh Config Solution | This Skill |
|---------|-------------------|-----------|
| Installation | Manual shell config | One command |
| Task Detection | N/A | AI-powered |
| Shell Support | Zsh only | Any shell |
| Updates | Manual | Automatic |
| Learning Curve | Medium | None |

## Troubleshooting

### Terminal title not updating?

**Check installation:**
```bash
ls -la ~/.claude/skills/terminal-title/
```

**Test the script directly:**
```bash
cd ~/.claude/skills/terminal-title/
bash scripts/set_title.sh "Test: It Works!"
```

**Verify permissions:**
```bash
chmod +x ~/.claude/skills/terminal-title/scripts/set_title.sh
```

### Still having issues?

1. Ensure your terminal supports ANSI escape sequences
2. Restart Claude Code after installation
3. Check Claude Code logs for errors
4. [Open an issue](../../issues) with details

## Contributing

Contributions welcome! Whether it's:
- Bug reports
- Feature requests
- Code improvements
- Documentation updates

Please [open an issue](../../issues) or submit a pull request.

## Future Enhancements

**Recently Added (v1.1.0):**
- ✅ Custom title prefixes via `CLAUDE_TITLE_PREFIX`
- ✅ Enhanced error handling and terminal detection
- ✅ Better documentation with troubleshooting guide

**Considering based on community feedback:**
- [ ] Custom title format templates
- [ ] Project-specific auto-detection (from directory name)
- [ ] Git branch integration
- [ ] Status indicators (🟢/🔴/🟡)
- [ ] Title history logging
- [ ] macOS notification integration

Vote for features by commenting on [issues](../../issues).

## License

MIT License - see [LICENSE](LICENSE) file for details.

Free to use, modify, and share. Commercial use allowed.

## Acknowledgments

Built to solve a real productivity pain point. Thanks to:
- Anthropic for creating Claude Code
- The awesome-claude-skills community
- Everyone who provided feedback

## Support

- 🐛 [Report a bug](../../issues/new?labels=bug)
- 💡 [Request a feature](../../issues/new?labels=enhancement)
- 💬 [Start a discussion](../../discussions)
- ⭐ Star this repo if it helps you!

## Related Projects

- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)
- [awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills)
- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)

---

**Made by developers, for developers.** If you're using Claude Code in production, this is a small quality-of-life improvement that compounds quickly.

[⬇️ Download the latest release](../../releases/latest)
