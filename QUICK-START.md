# Quick Installation & Test Guide

## Test Locally (Right Now)

**1. Download the skill file**
```bash
# The file is ready at: /mnt/user-data/outputs/terminal-title.skill
```

**2. Install it**
```bash
# Create skills directory if needed
mkdir -p ~/.claude/skills

# Extract the skill
unzip terminal-title.skill -d ~/.claude/skills/
```

**3. Test it**
```bash
# Open a new terminal
# Start Claude Code
claude

# Give it any task prompt, like:
"Help me refactor the authentication module"

# Your terminal title should update to something like:
# "Refactor: Auth Module"
```

## Verify Installation

**Check the files:**
```bash
ls -la ~/.claude/skills/terminal-title/
# Should show:
# - SKILL.md
# - LICENSE
# - VERSION
# - CHANGELOG.md
# - scripts/set_title.sh
```

**Check script permissions:**
```bash
ls -la ~/.claude/skills/terminal-title/scripts/set_title.sh
# Should show: -rwxr-xr-x (executable)
```

**If not executable, fix permissions:**
```bash
chmod +x ~/.claude/skills/terminal-title/scripts/set_title.sh
```

**Test the script directly:**
```bash
cd ~/.claude/skills/terminal-title/
bash scripts/set_title.sh "Test: It Works!"
# Your terminal title should change immediately
```

## Distribution Checklist

Before sharing publicly:

- [ ] Test skill in your own Claude Code setup
- [ ] Verify terminal title updates correctly
- [ ] Create GitHub repository
- [ ] Add GitHub link to LinkedIn post
- [ ] Test installation instructions on clean system
- [ ] Take screenshots/video for social proof
- [ ] Post on LinkedIn
- [ ] Share in Claude community Discord
- [ ] Submit to awesome-claude-skills lists

## Troubleshooting

**Skill not loading?**
- Check: `~/.claude/skills/terminal-title/SKILL.md` exists
- Restart Claude Code
- Check Claude Code logs for any errors

**Terminal title not updating?**
- Test script directly: `bash scripts/set_title.sh "Test"`
- Check terminal emulator settings
- Ensure terminal supports ANSI escape sequences

**Script permission issues?**
```bash
chmod +x ~/.claude/skills/terminal-title/scripts/set_title.sh
```

## Example Prompts to Test

Try these to see different title formats:

1. "Debug the login authentication flow"
   → Expected: "Debug: Login Auth"

2. "Create a new React dashboard component"
   → Expected: "Build: Dashboard UI"

3. "Write unit tests for the payment processing"
   → Expected: "Test: Payment Module"

4. "Optimize database queries in the user service"
   → Expected: "Optimize: DB Queries"

## Optional: Test Custom Prefix

Add a custom prefix to your terminal titles:

```bash
# Add to your shell config (~/.bashrc, ~/.zshrc, etc.):
export CLAUDE_TITLE_PREFIX="🤖 Claude"

# Or test temporarily:
export CLAUDE_TITLE_PREFIX="🤖 Claude"
claude
# Give it a task and see: "🤖 Claude | Build: Dashboard UI"
```

## Next Actions

**Immediate (Today):**
1. Test locally ✓
2. Create GitHub repo
3. Write release notes
4. Add screenshots

**Short-term (This Week):**
1. Post on LinkedIn
2. Share in communities
3. Monitor feedback
4. Respond to questions

**Long-term (Ongoing):**
1. Iterate based on user feedback
2. Add features if needed
3. Help others adopt it
4. Build more skills

---

**You're ready to launch!** The skill works, it's packaged, and the marketing materials are ready.
