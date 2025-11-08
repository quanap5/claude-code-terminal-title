#!/bin/zsh
# Terminal Title Skill - Installation and Testing Script
# This script installs and tests the terminal-title skill for Claude Code

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"
SKILL_FILE="${SCRIPT_DIR}/terminal-title.skill"
INSTALL_DIR="${HOME}/.claude/skills"

echo "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo "${CYAN}║  Terminal Title Skill - Installation & Test Script          ║${NC}"
echo "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo ""

# Step 1: Check if skill file exists
echo "${BLUE}[1/6]${NC} Checking for skill file..."
if [[ ! -f "$SKILL_FILE" ]]; then
    echo "${RED}✗ Error: terminal-title.skill not found at: ${SKILL_FILE}${NC}"
    exit 1
fi
echo "${GREEN}✓ Found: ${SKILL_FILE}${NC}"
echo ""

# Step 2: Extract the skill
echo "${BLUE}[2/6]${NC} Installing skill to ${INSTALL_DIR}..."
mkdir -p "$INSTALL_DIR"
unzip -o "$SKILL_FILE" -d "$INSTALL_DIR" > /dev/null 2>&1
echo "${GREEN}✓ Skill extracted successfully${NC}"
echo ""

# Step 3: Make script executable
echo "${BLUE}[3/6]${NC} Setting script permissions..."
chmod +x "${INSTALL_DIR}/terminal-title/scripts/set_title.sh"
echo "${GREEN}✓ Script is now executable${NC}"
echo ""

# Step 4: Verify installation
echo "${BLUE}[4/6]${NC} Verifying installation..."
if [[ -f "${INSTALL_DIR}/terminal-title/SKILL.md" ]] && \
   [[ -f "${INSTALL_DIR}/terminal-title/scripts/set_title.sh" ]] && \
   [[ -x "${INSTALL_DIR}/terminal-title/scripts/set_title.sh" ]]; then
    echo "${GREEN}✓ All files present and configured correctly${NC}"
    echo "  • SKILL.md"
    echo "  • LICENSE"
    echo "  • VERSION"
    echo "  • CHANGELOG.md"
    echo "  • scripts/set_title.sh (executable)"
else
    echo "${RED}✗ Installation verification failed${NC}"
    exit 1
fi
echo ""

# Step 5: Test basic functionality
echo "${BLUE}[5/6]${NC} Testing basic functionality..."
bash "${INSTALL_DIR}/terminal-title/scripts/set_title.sh" "Test: Installation Successful"
sleep 0.5
if [[ $? -eq 0 ]]; then
    echo "${GREEN}✓ Script executed successfully${NC}"
    echo "${YELLOW}  ➜ Check your terminal title - it should now say: 'Test: Installation Successful'${NC}"
else
    echo "${RED}✗ Script execution failed${NC}"
    exit 1
fi
echo ""

# Step 6: Test with custom prefix
echo "${BLUE}[6/6]${NC} Testing custom prefix feature..."
export CLAUDE_TITLE_PREFIX="🤖 Test"
bash "${INSTALL_DIR}/terminal-title/scripts/set_title.sh" "With Prefix"
sleep 0.5
if [[ $? -eq 0 ]]; then
    echo "${GREEN}✓ Prefix feature works${NC}"
    echo "${YELLOW}  ➜ Your terminal title should now say: '🤖 Test | With Prefix'${NC}"
else
    echo "${RED}✗ Prefix test failed${NC}"
    exit 1
fi
unset CLAUDE_TITLE_PREFIX
echo ""

# Test fail-safe behavior (silent test)
bash "${INSTALL_DIR}/terminal-title/scripts/set_title.sh" > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    # Fail-safe works (exits silently with no args)
    :
fi

# Success message
echo "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo "${GREEN}║  ✓ Installation and Testing Complete!                       ║${NC}"
echo "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo ""
echo "${CYAN}Next Steps:${NC}"
echo ""
echo "1. ${YELLOW}Configure Terminal (macOS Terminal.app users only):${NC}"
echo "   If you see unwanted prefixes/suffixes in titles, run:"
echo "   ${BLUE}./setup-zsh.sh${NC}"
echo "   This will configure your ~/.zshrc and Terminal.app settings"
echo ""
echo "2. ${YELLOW}Test with Claude Code:${NC}"
echo "   Open a ${YELLOW}NEW terminal window${NC} and run:"
echo "   ${BLUE}claude${NC}"
echo ""
echo "3. ${YELLOW}Give Claude a task:${NC}"
echo "   Try: \"Help me refactor the authentication module\""
echo "   Your terminal title should update automatically!"
echo ""
echo "4. ${YELLOW}Optional - Set a custom prefix:${NC}"
echo "   Add to your ${BLUE}~/.zshrc${NC}:"
echo "   ${BLUE}export CLAUDE_TITLE_PREFIX=\"🤖 Claude\"${NC}"
echo ""
echo "${CYAN}Installed to:${NC} ${INSTALL_DIR}/terminal-title/"
echo ""
echo "${GREEN}Happy coding! 🚀${NC}"
echo ""
