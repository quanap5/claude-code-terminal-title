# LinkedIn Post: Terminal Title Skill for Claude Code

---

I got tired of playing "which terminal is which?" with multiple Claude Code instances. So I built something to fix it.

**The Problem:**
Running 3+ Claude Code terminals simultaneously? You're constantly clicking through tabs trying to remember which one is handling your API integration, which is debugging authentication, and which is working on that UI component.

**The Solution:**
A Claude Code skill that automatically updates your terminal window title based on what Claude is actually working on.

No manual configuration. No shell scripts to add to your .zshrc. Just install and forget.

**How it works:**
• Claude reads your prompt
• Extracts the high-level task
• Updates the terminal title automatically
• Examples: "API Integration: Auth Flow" | "Debug: Login Bug" | "Build: Dashboard UI"

**Why it matters:**
When you're context-switching between multiple AI coding sessions, every second counts. Clear terminal titles = instant context awareness = faster workflows.

**Tech details:**
• 2KB skill package
• Zero dependencies
• Works with iTerm2, Terminal, Alacritty, etc.
• Cross-platform (macOS, Linux)
• MIT licensed

**Try it:**
1. Download: [link to GitHub/download location]
2. Install: `claude-code install terminal-title.skill`
3. Done. It just works.

Built this because I needed it. Sharing it because you might too.

If you're using Claude Code in production, this is a small quality-of-life improvement that compounds quickly.

---

📥 Get it: [Add your distribution link]
🐛 Issues/Ideas: [Add your contact/GitHub]

#ClaudeCode #DeveloperTools #Productivity #AITools #Anthropic

---

P.S. - This is the first Claude Code skill I've shared publicly. If it's useful, I have a few more workflow optimizations in the pipeline. Let me know if you want to see them.
