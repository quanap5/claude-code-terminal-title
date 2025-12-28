# Claude Code Terminal Title Skill - Project Workflow

## 1. Project Overview

This is a **Claude Code Skill** designed to automatically update terminal window titles based on the current task Claude Code is working on. It solves the productivity problem of managing multiple Claude Code instances across different terminal windows.

- **Current Version:** 1.2.0
- **Type:** Developer Productivity Tool
- **License:** MIT
- **Size:** ~2KB (lightweight)

## 2. Core Problem Solved

When developers run multiple Claude Code instances simultaneously, all terminal windows look identical. This leads to:
- Constant clicking between terminals trying to remember which handles which task
- Context switching confusion
- Workflow inefficiency
- Time wasted identifying the correct terminal

**Solution:** Automatically set descriptive terminal titles like "Build: Dashboard UI" or "Debug: Auth API Flow" to provide at-a-glance context.

## 3. Main Components & Architecture

### A. Skill Package Structure (`terminal-title.skill`)

A ZIP archive containing:

```
terminal-title/
├── SKILL.md              # Skill definition & trigger instructions
├── LICENSE               # MIT License
├── VERSION               # Semantic version (1.2.0)
├── CHANGELOG.md          # Version history
└── scripts/
    └── set_title.sh      # Core shell script that sets terminal titles
```

### B. Core Execution Script (`set_title.sh`)

**Purpose:** The actual script that updates terminal window titles using ANSI escape sequences.

**Key Functionality:**
- Accepts a task description as argument
- Sanitizes input (removes control characters, limits to 80 chars)
- Retrieves current folder name using `basename "$PWD"`
- Builds final title format: `[Folder Name] | [Task Description]` or with optional prefix
- Stores title persistently in `~/.claude/terminal_title` for shell hooks
- Uses ANSI escape sequence `\033]0;%s\007` to set terminal title
- Supports environment variable `CLAUDE_TITLE_PREFIX` for customization

**Terminal Support:**
- xterm, rxvt, screen, tmux (explicit support)
- macOS Terminal.app, iTerm2, Alacritty (fallback support)

### C. Skill Definition (`SKILL.md`)

**Purpose:** Tells Claude Code WHEN and HOW to trigger this skill.

**Triggers ON:**
- First prompt in a new Claude Code session
- Switching to substantially different tasks (frontend → backend, debugging → new feature)
- Moving from one module/component to a completely different one

**Does NOT trigger for:**
- Follow-up questions about the same task
- Small refinements ("Make it blue instead")
- Debugging the same feature just built
- Clarifications or status updates
- Iterating on the same component

**Title Format Guidelines:**
- Pattern: `[Action/Category]: [Specific Focus]`
- Max 40 characters for readability
- Examples: "API Integration: Auth Flow", "Fix: Login Bug", "Build: Dashboard UI"

## 4. Installation Workflow

### Three Installation Methods

**Method 1: Automated Install (Recommended)**
```bash
./install-and-test.sh
```

The script performs:
1. Checks prerequisites (unzip, mkdir, chmod, bash)
2. Extracts terminal-title.skill to ~/.claude/skills/
3. Sets script permissions (chmod +x)
4. Verifies all files present and executable
5. Tests basic functionality
6. Tests with custom prefix

**Method 2: Claude Code CLI**
```bash
claude-code install terminal-title.skill
```

**Method 3: Manual Install**
```bash
mkdir -p ~/.claude/skills
unzip terminal-title.skill -d ~/.claude/skills/
chmod +x ~/.claude/skills/terminal-title/scripts/set_title.sh
```

### macOS Terminal.app Special Setup (`setup-zsh.sh`)

**Problem:** macOS Terminal.app by default appends " – -zsh – 80x24" to titles.

**Solution:** `setup-zsh.sh` performs:
1. Backs up existing ~/.zshrc
2. Adds custom `update_terminal_cwd` function override to ~/.zshrc
3. Configures Terminal.app plist settings to disable title suffixes

## 5. Workflow From Start to Finish

```
1. USER INTERACTION PHASE
   ↓
   User opens Claude Code in terminal
   User provides first task prompt

2. SKILL TRIGGER PHASE
   ↓
   Claude Code receives user prompt
   SKILL.md evaluates: "Is this a new session or task switch?"
   If YES → Trigger terminal-title skill

3. TITLE GENERATION PHASE
   ↓
   Skill analyzes prompt to extract task summary
   Generates concise title (max 40 chars)
   Format: "[Action]: [Focus]"

4. EXECUTION PHASE
   ↓
   Execute: bash scripts/set_title.sh "Generated Title"

5. TITLE SETTING PHASE
   ↓
   Script sanitizes input (remove control chars, limit length)
   Gets current folder: basename "$PWD"
   Builds final title: "[Folder] | [Title]" + optional prefix
   Stores in ~/.claude/terminal_title (for shell hooks)
   Sends ANSI escape sequence \033]0;[TITLE]\007 to terminal

6. TERMINAL UPDATE PHASE
   ↓
   Terminal reads ANSI sequence
   Window title updates immediately
   (On macOS with zsh: precmd hook preserves title for session)

7. PERSISTENCE PHASE
   ↓
   macOS zsh: precmd hook in ~/.zshrc calls update_terminal_cwd()
   This function preserves Claude title if < 5 min old
   New terminals inherit title briefly (5 min window)
   Once Claude Code runs in new terminal, title is reclaimed
```

## 6. Interaction Flow Diagram

```
┌─────────────────────────────────────────────────────────┐
│              User Starts Claude Code                    │
│                                                         │
│          Provides first prompt or task                  │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│    Claude Code Framework Evaluates Trigger Rules        │
│                                                         │
│    From SKILL.md:                                       │
│    - New session? → YES ✓ TRIGGER                       │
│    - Task switch? → YES ✓ TRIGGER                       │
│    - Same task? → NO ✗ SKIP                             │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│         Claude Analyzes Prompt & Generates Title        │
│                                                         │
│    Input: "Help debug the authentication API"           │
│    Output: "Debug: Auth API Flow" (max 40 chars)        │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│     Execute: bash set_title.sh "Debug: Auth API Flow"   │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│              set_title.sh Processing:                   │
│                                                         │
│  1. Validate input (remove control chars)               │
│  2. Get folder: $(basename "$PWD")                      │
│  3. Check for CLAUDE_TITLE_PREFIX env var               │
│  4. Build final title with separators (|)               │
│  5. Store to ~/.claude/terminal_title                   │
│  6. Send ANSI: \033]0;[TITLE]\007 to terminal           │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│           Terminal Window Title Updates                 │
│                                                         │
│    Before: "user — -zsh — 80x24"                        │
│    After:  "my-api-project | Debug: Auth API Flow"      │
│                                                         │
│            (On macOS, zsh precmd hook                   │
│             preserves title across prompts)             │
└─────────────────────────────────────────────────────────┘
```

## 7. Key Files & Their Purposes

| File | Purpose |
|------|---------|
| `terminal-title.skill` | ZIP package containing skill for installation |
| `SKILL.md` | Skill trigger logic & title generation instructions for Claude |
| `set_title.sh` | Core bash script that sets terminal titles using ANSI codes |
| `install-and-test.sh` | Automated installation with 6-step verification |
| `setup-zsh.sh` | macOS Terminal.app configuration (zsh hook + plist settings) |
| `uninstall.sh` | Complete removal with backup of shell configs |
| `README.md` | Comprehensive user documentation |
| `GITHUB-README.md` | GitHub repository documentation |
| `PROJECT-SUMMARY.md` | Project overview & distribution strategy |
| `QUICK-START.md` | Minimal quick-start guide |
| `CHANGELOG.md` | Version history and changes |
| `VERSION` | Current version string (1.2.0) |

## 8. Deployment Architecture

```
PROJECT REPOSITORY
│
├── Source Files
│   ├── terminal-title.skill (distribution package)
│   ├── install-and-test.sh (installation tool)
│   ├── setup-zsh.sh (macOS configuration)
│   ├── uninstall.sh (removal tool)
│   └── Documentation (README, GITHUB-README, etc.)
│
├── User Installation
│   └── ~/.claude/skills/terminal-title/
│       ├── SKILL.md
│       ├── scripts/set_title.sh
│       ├── LICENSE
│       ├── VERSION
│       └── CHANGELOG.md
│
└── User Configuration
    ├── ~/.zshrc (if setup-zsh.sh runs)
    │   └── Custom update_terminal_cwd() function
    ├── ~/.claude/terminal_title (title cache)
    └── ~/Library/Preferences/com.apple.Terminal.plist (macOS)
```

## 9. Technical Highlights

### Strengths
- **Lightweight:** ~2KB package size
- **No Dependencies:** Uses only standard bash
- **Cross-Platform:** Works on macOS, Linux, Windows+WSL
- **Smart Triggering:** AI-driven task detection via Claude
- **Persistent Titles:** macOS zsh hook preserves titles across prompts
- **Fail-Safe:** Silent exit if no input provided
- **Input Sanitization:** Removes control characters, limits length
- **Atomic Writes:** Prevents race conditions with temp files
- **Customizable:** Optional prefix via environment variable

### Safety Features
- Input sanitization (control character removal, length limit)
- Atomic file writes to prevent race conditions
- Error suppression for unsupported terminals
- Backup creation before modifying shell config
- Clear uninstall with configuration restoration

### Version Evolution
- **v1.0.0:** Initial release with basic functionality
- **v1.1.0:** Added prefix customization, enhanced error handling, documentation
- **v1.2.0:** Added automatic folder name prefix to titles

## 10. Use Cases & Scenarios

**Scenario 1: Frontend & Backend Work**
```
Terminal A: "react-app | Build: Dashboard UI"
Terminal B: "api-server | Debug: Auth API Flow"
Terminal C: "database | Migrate: Users Table"
```

**Scenario 2: Debugging Multiple Systems**
```
Terminal A: "payment-service | Fix: Charge Processing Bug"
Terminal B: "notification-api | Debug: Email Delivery Issue"
Terminal C: "legacy-system | Refactor: Auth Module"
```

**Scenario 3: With Custom Prefix**
```bash
export CLAUDE_TITLE_PREFIX="Claude"
# Result: "Claude | my-app | Build: Login UI"
```

## 11. Installation Verification Checklist

The `install-and-test.sh` script verifies:
- [x] Prerequisites installed (unzip, mkdir, chmod, bash)
- [x] Skill file exists at correct location
- [x] Skill extracts successfully
- [x] Script permissions set to executable
- [x] All files present and correct
- [x] Basic functionality works
- [x] Prefix customization works
- [x] Fail-safe behavior (silent exit on no args)

## 12. Troubleshooting

### Title Not Updating?
1. Verify installation: `ls -la ~/.claude/skills/terminal-title/`
2. Check permissions: `ls -la ~/.claude/skills/terminal-title/scripts/set_title.sh`
3. Test directly: `bash ~/.claude/skills/terminal-title/scripts/set_title.sh "Test"`
4. Verify SKILL.md formatting
5. Restart Claude Code

### Title Shows Escape Codes?
- Terminal doesn't support ANSI sequences
- Use supported terminal (iTerm2, GNOME Terminal, Alacritty)

### Unwanted Prefix/Suffix (macOS)?
- Run: `./setup-zsh.sh`
- Open new terminal window

## 13. Target Users

- Developers using multiple Claude Code instances
- DevOps engineers managing complex workflows
- Teams coordinating on Claude Code projects
- Anyone context-switching between terminals
