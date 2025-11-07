#!/bin/bash

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🤖 FRIDAY - AI Assistant Template Customization
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Your intelligent AI assistant for professional development
# Inspired by Tony Stark's FRIDAY from Iron Man
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

# Parse arguments
AUTO_MODE=false
PROJECT_NAME=""
PROJECT_TYPE=""
TECH_STACK=""
PRIMARY_LANGUAGE=""
FRAMEWORK=""

show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Customize FRIDAY AI Assistant template for your project.

OPTIONS:
    --auto                  Non-interactive mode (requires all flags below)
    --name <name>          Project name
    --type <type>          Project type (web/mobile/api/cli/chatbot)
    --stack <stack>        Tech stack (e.g., "Node.js + Express")
    --lang <language>      Primary language (JavaScript/TypeScript/Python/etc)
    --framework <fw>       Framework (Express/FastAPI/Next.js/etc)
    -h, --help             Show this help message

EXAMPLES:
    # Interactive mode (default)
    bash customize.sh

    # Non-interactive mode
    bash customize.sh --auto \\
      --name "MyApp" \\
      --type "web" \\
      --stack "Next.js + TypeScript" \\
      --lang "TypeScript" \\
      --framework "Next.js"

EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --auto)
            AUTO_MODE=true
            shift
            ;;
        --name)
            PROJECT_NAME="$2"
            shift 2
            ;;
        --type)
            PROJECT_TYPE="$2"
            shift 2
            ;;
        --stack)
            TECH_STACK="$2"
            shift 2
            ;;
        --lang)
            PRIMARY_LANGUAGE="$2"
            shift 2
            ;;
        --framework)
            FRAMEWORK="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Validate auto mode has all required args
if [ "$AUTO_MODE" = true ]; then
    if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_TYPE" ] || [ -z "$TECH_STACK" ] || [ -z "$PRIMARY_LANGUAGE" ] || [ -z "$FRAMEWORK" ]; then
        echo "❌ Error: --auto mode requires all flags (--name, --type, --stack, --lang, --framework)"
        show_help
        exit 1
    fi
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖 FRIDAY AI Assistant - Project Customization"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Good day! I'm FRIDAY, your AI development assistant."
echo "Let me help you customize this template for your project."
echo ""

# Interactive mode: collect information
if [ "$AUTO_MODE" = false ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎨 AI Assistant Template - Customization Wizard"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Let's customize your AI assistant configuration!"
    echo ""

    read -p "📝 Project Name (e.g., My Awesome Project): " PROJECT_NAME
    read -p "🏷️  Project Type (web/mobile/api/cli/chatbot): " PROJECT_TYPE
    read -p "🛠️  Tech Stack (e.g., Node.js + Express): " TECH_STACK
    read -p "💻 Primary Language (JavaScript/TypeScript/Python/etc): " PRIMARY_LANGUAGE
    read -p "🎯 Framework (e.g., Express/FastAPI/Next.js): " FRAMEWORK
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Configuration Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Project Name:     $PROJECT_NAME"
echo "Project Type:     $PROJECT_TYPE"
echo "Tech Stack:       $TECH_STACK"
echo "Language:         $PRIMARY_LANGUAGE"
echo "Framework:        $FRAMEWORK"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Skip confirmation in auto mode
if [ "$AUTO_MODE" = false ]; then
    read -p "✅ Looks good? (y/n): " CONFIRM

    if [ "$CONFIRM" != "y" ]; then
        echo "❌ Customization cancelled"
        exit 1
    fi
else
    echo "✅ Auto mode: Proceeding with configuration..."
fi

echo ""
echo "🔄 Applying customizations..."

# Function to replace placeholders in a file
customize_file() {
    local file=$1
    if [ -f "$file" ]; then
        sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$file"
        sed -i "s/{{PROJECT_TYPE}}/$PROJECT_TYPE/g" "$file"
        sed -i "s/{{TECH_STACK}}/$TECH_STACK/g" "$file"
        sed -i "s/{{PRIMARY_LANGUAGE}}/$PRIMARY_LANGUAGE/g" "$file"
        sed -i "s/{{FRAMEWORK}}/$FRAMEWORK/g" "$file"
        echo "  ✅ $file"
    fi
}

# Customize main configuration
echo ""
echo "📝 Customizing copilot-instructions.md..."
customize_file ".github/copilot-instructions.md"

# Customize memory INDEX
echo ""
echo "📚 Customizing memory/INDEX.md..."
customize_file ".github/memory/INDEX.md"

# Customize instructions
echo ""
echo "📖 Customizing instruction files..."
for file in .github/instructions/*.md; do
    customize_file "$file"
done

# Create current-state.md
echo ""
echo "📋 Creating memory/current-state.md..."
cat > .github/memory/current-state.md << EOF
# Project Current State

**Project:** $PROJECT_NAME  
**Type:** $PROJECT_TYPE  
**Tech Stack:** $TECH_STACK  
**Language:** $PRIMARY_LANGUAGE  
**Framework:** $FRAMEWORK

---

## 🎯 Current Focus

**Status:** Initial Setup  
**Phase:** Development

---

## ✅ Features Implemented

- [x] AI Assistant Configuration
- [ ] Initial Project Structure
- [ ] Core Features

---

## 📊 Statistics

**Files:** TBD  
**Tests:** TBD  
**Coverage:** TBD  

---

## 🚧 Known Issues

None yet - fresh start!

---

## 📝 Notes

Project initialized with AI Assistant Template on $(date +"%B %d, %Y")
EOF

#############################################
# GitHub Copilot CLI (optional installation) #
#############################################

# Skip interactive prompts in auto mode
if [ "$AUTO_MODE" = false ]; then
    echo ""
    echo "🧰 Installing GitHub Copilot CLI (optional)"
    echo "-----------------------------------------"

    install_copilot_cli() {
        if command -v npm >/dev/null 2>&1; then
            echo "Attempting to install @githubnext/github-copilot-cli globally via npm..."
            if npm install -g @githubnext/github-copilot-cli >/dev/null 2>&1; then
                echo "  ✅ Copilot CLI installed (github-copilot-cli)"
            else
                echo "  ⚠️  Failed to install Copilot CLI via npm. You can retry later: npm i -g @githubnext/github-copilot-cli"
                return 1
            fi
        else
            echo "  ⚠️  npm not found. Skipping Copilot CLI installation."
            return 1
        fi
    }

    if install_copilot_cli; then
        echo ""
        echo "🔐 Copilot CLI authentication"
        echo "You'll be prompted to authenticate in your browser."
        read -p "Proceed to login now? (y/n): " DO_COPILOT_LOGIN
        if [ "$DO_COPILOT_LOGIN" = "y" ]; then
            if command -v github-copilot-cli >/dev/null 2>&1; then
                github-copilot-cli auth login || true
            else
                echo "  ⚠️  Copilot CLI binary not found after install. Skipping login."
            fi
        fi
    fi

    #############################################
    # GitHub CLI Copilot (optional, if available)
    #############################################

    echo ""
    echo "🧰 Checking GitHub CLI (gh) and Copilot extension"
    if command -v gh >/dev/null 2>&1; then
        echo "  ✅ gh detected"
        echo "  Installing gh copilot extension (if missing)..."
        gh extension install github/gh-copilot >/dev/null 2>&1 || true
        echo "  You may run: gh auth login    # to authenticate GitHub CLI"
    else
        echo "  ℹ️  GitHub CLI (gh) not found. Skipping gh copilot setup."
    fi
else
    echo ""
    echo "⏩ Auto mode: Skipping optional Copilot CLI installation"
fi

############################################################
# Auto-update .github/copilot-instructions.md (via gh copilot)
############################################################

echo ""
echo "🛠️  Setting up auto-update script for .github/copilot-instructions.md"

mkdir -p .github/scripts
cat > .github/scripts/auto-update-copilot-instructions.sh << 'BASH'
#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
OUT_FILE="$REPO_ROOT/.github/copilot-instructions.md"
TMP_DIR="${TMPDIR:-/tmp}"
GEN_FILE="$TMP_DIR/copilot_instructions_generated_$$.md"

PROMPT=$(cat << 'PROMPT'
Analyze this codebase to generate or update `.github/copilot-instructions.md` for guiding AI coding agents.

Focus on discovering the essential knowledge that would help an AI agents be immediately productive in this codebase. Consider aspects like:
- The "big picture" architecture that requires reading multiple files to understand - major components, service boundaries, data flows, and the "why" behind structural decisions
- Critical developer workflows (builds, tests, debugging) especially commands that aren't obvious from file inspection alone
- Project-specific conventions and patterns that differ from common practices
- Integration points, external dependencies, and cross-component communication patterns

Source existing AI conventions from `**/{.github/copilot-instructions.md,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,README.md}` (do one glob search).

Guidelines (read more at https://aka.ms/vscode-instructions-docs):
- If `.github/copilot-instructions.md` exists, merge intelligently - preserve valuable content while updating outdated sections
- Write concise, actionable instructions (~20-50 lines) using markdown structure
- Include specific examples from the codebase when describing patterns
- Avoid generic advice ("write tests", "handle errors") - focus on THIS project's specific approaches
- Document only discoverable patterns, not aspirational practices
- Reference key files/directories that exemplify important patterns

Update `.github/copilot-instructions.md` for the user, then ask for feedback on any unclear or incomplete sections to iterate.
PROMPT
)

if ! command -v gh >/dev/null 2>&1; then
    echo "gh CLI not found. Please install GitHub CLI to enable auto-updates." >&2
    exit 0
fi

# Try to generate content using gh copilot
if gh extension list | grep -q "github/gh-copilot"; then
    gh copilot suggest -p "$PROMPT" > "$GEN_FILE" || {
        echo "gh copilot suggest failed; aborting this run." >&2
        exit 0
    }
else
    echo "gh copilot extension not installed; skipping generation." >&2
    exit 0
fi

STAMP=$(date -u +"%Y-%m-%d %H:%M UTC")
START_MARK="<!-- AUTO-GENERATED: COPILOT-ANALYSIS START -->"
END_MARK="<!-- AUTO-GENERATED: COPILOT-ANALYSIS END -->"

insert_block() {
    {
        echo ""
        echo "$START_MARK"
        echo "> Last updated: $STAMP"
        echo ""
        cat "$GEN_FILE"
        echo ""
        echo "$END_MARK"
    } >> "$OUT_FILE"
}

replace_block() {
    awk -v start="$START_MARK" -v end="$END_MARK" -v stamp="$STAMP" \
        'BEGIN{inblock=0}
         $0 ~ start {print start; print "> Last updated: " stamp; system("cat '"$GEN_FILE"' "); inblock=1; next}
         $0 ~ end && inblock==1 {print end; inblock=0; next}
         inblock==0 {print $0}' "$OUT_FILE" > "$OUT_FILE.tmp" && mv "$OUT_FILE.tmp" "$OUT_FILE"
}

if [ -f "$OUT_FILE" ]; then
    if grep -q "$START_MARK" "$OUT_FILE" && grep -q "$END_MARK" "$OUT_FILE"; then
        replace_block
    else
        insert_block
    fi
else
    mkdir -p "$REPO_ROOT/.github"
    echo "# Copilot Instructions" > "$OUT_FILE"
    insert_block
fi

echo "Auto-update complete: $OUT_FILE"
BASH

chmod +x .github/scripts/auto-update-copilot-instructions.sh

if [ "$AUTO_MODE" = false ]; then
    echo ""
    read -p "⏱️  Setup daily auto-update at 01:00 using cron? (y/n): " SET_CRON
    if [ "$SET_CRON" = "y" ]; then
        SCRIPT_PATH="$(pwd)/.github/scripts/auto-update-copilot-instructions.sh"
        # Remove previous entries for this script, then add new
        ( crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH" ; echo "0 1 * * * bash $SCRIPT_PATH >> $(pwd)/.github/scripts/auto-update.log 2>&1" ) | crontab -
        echo "  ✅ Cron installed: daily at 01:00"
    fi

    echo ""
    read -p "▶️  Run the auto-update once now? (y/n): " RUN_NOW
    if [ "$RUN_NOW" = "y" ]; then
        bash .github/scripts/auto-update-copilot-instructions.sh || true
    fi
else
    # Auto mode: setup cron silently
    echo ""
    echo "⏩ Auto mode: Setting up daily auto-update cron..."
    SCRIPT_PATH="$(pwd)/.github/scripts/auto-update-copilot-instructions.sh"
    ( crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH" ; echo "0 1 * * * bash $SCRIPT_PATH >> $(pwd)/.github/scripts/auto-update.log 2>&1" ) | crontab - 2>/dev/null || echo "  ⚠️  Cron setup skipped (not available)"
    echo "  ✅ Daily auto-update scheduled at 01:00"
fi


echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Customization Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🤖 FRIDAY: Perfect! Your project is now configured."
echo ""
echo "📦 Project: $PROJECT_NAME"
echo "🛠️  Tech Stack: $TECH_STACK"
echo "💻 Language: $PRIMARY_LANGUAGE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖 FRIDAY's Recommended Workflow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "I've prepared these prompts to get you started efficiently."
echo "Simply copy and paste them to GitHub Copilot Chat."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 STEP 1: Initialize Project Structure"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
cat << 'EOF'
FRIDAY Protocol - Project Initialization
───────────────────────────────────────────────────────
Hello! I'm FRIDAY, your AI development assistant.

Initialize a $PROJECT_TYPE project with $TECH_STACK.

Mission Parameters:
1. Create industry-standard $PRIMARY_LANGUAGE project structure
2. Configure package manager with essential dependencies
3. Setup $FRAMEWORK with best practices
4. Follow architectural patterns from .github/copilot-instructions.md
5. Update .github/memory/current-state.md with setup summary

Request: Keep architecture modular and maintainable.
Shall we proceed with initialization?
───────────────────────────────────────────────────────
EOF
echo ""
echo "🤖 FRIDAY: This will set up your project foundation properly."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 STEP 2: Create First Feature"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
cat << 'EOF'
FRIDAY Protocol - Feature Development
───────────────────────────────────────────────────────
FRIDAY here. Ready to implement your first feature.

Develop [FEATURE_NAME] with the following specifications:

Quality Standards:
1. Architecture: Follow patterns in .github/instructions/architecture.md
2. Testing: Minimum 80% code coverage required
3. Documentation: Comprehensive inline comments and README updates
4. Memory: Document implementation in .github/memory/implementations/
5. Style: Adhere to .prettierrc and .eslintrc.json configurations

Recommendation: Start with a simple but complete feature 
to establish development patterns.

What feature would you like to build first?
───────────────────────────────────────────────────────
EOF
echo ""
echo "🤖 FRIDAY: I'll ensure best practices are followed throughout."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 STEP 3: Code Quality Review"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
cat << 'EOF'
FRIDAY Protocol - Quality Assurance
───────────────────────────────────────────────────────
Running comprehensive code review protocols.

Review Parameters:
1. Configuration Compliance: .github/copilot-instructions.md
2. Test Coverage: Verify >80% threshold
3. Security Scan: Check for hardcoded secrets and vulnerabilities
4. Code Style: Validate .editorconfig and .prettierrc adherence
5. Best Practices: Cross-reference .github/instructions/patterns.md

Analysis: I'll provide actionable recommendations for improvements.

Ready to review your code?
───────────────────────────────────────────────────────
EOF
echo ""
echo "🤖 FRIDAY: Quality assurance is crucial for maintainability."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💡 FRIDAY's Additional Protocols"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
cat << 'EOF'
🔍 Debug Protocol:
───────────────────────────────────────────────────────
FRIDAY: Initiating debug sequence.

Analyze and resolve this issue using troubleshooting protocols 
from .github/instructions/gotchas.md. Cross-reference similar 
issues in .github/memory/issues/ for efficient resolution.
───────────────────────────────────────────────────────

📝 Documentation Protocol:
───────────────────────────────────────────────────────
FRIDAY: Generating comprehensive documentation.

Document [FEATURE] following standards in 
.github/instructions/development-workflow.md
Update CHANGELOG.md with versioned changes.
───────────────────────────────────────────────────────

🧪 Testing Protocol:
───────────────────────────────────────────────────────
FRIDAY: Implementing test suite.

Generate comprehensive tests for [FEATURE] following 
.github/instructions/patterns.md. Target minimum 80% coverage.
Use test framework specified in copilot-instructions.md
───────────────────────────────────────────────────────

🚀 Deployment Protocol:
───────────────────────────────────────────────────────
FRIDAY: Preparing deployment sequence.

Configure deployment following .github/instructions/integration.md
Update .github/workflows/ci.yml for automated testing.
Document deployment process in memory/implementations/
───────────────────────────────────────────────────────
EOF
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎓 FRIDAY's Pro Tips"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🤖 FRIDAY: Here are some best practices I've learned:"
echo ""
echo "✅ Always reference configuration files in your prompts"
echo "   Example: \"Follow patterns in .github/instructions/patterns.md\""
echo ""
echo "✅ Request memory updates after significant work"
echo "   Example: \"Update .github/memory/implementations/ with summary\""
echo ""
echo "✅ Use precise file path references"
echo "   Example: \"Create UserService following architecture.md patterns\""
echo ""
echo "✅ Leverage memory for context continuity"
echo "   Example: \"Check .github/memory/ for similar implementations\""
echo ""
echo "✅ Request documentation proactively"
echo "   Example: \"Add JSDoc comments per copilot-instructions.md\""
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📚 Quick Access Commands"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "# Initialize repository"
echo "git init && git add . && git commit -m \"feat: initialize $PROJECT_NAME with FRIDAY AI assistant\""
echo ""
echo "# View AI configuration"
echo "cat .github/copilot-instructions.md"
echo ""
echo "# Check memory index"
echo "cat .github/memory/INDEX.md"
echo ""
echo "# Review project state"
echo "cat .github/memory/current-state.md"
echo ""
echo "# Create project README"
echo "echo '# $PROJECT_NAME' > README.md"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 FRIDAY: All Systems Ready!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Your project is configured and ready for development."
echo ""
echo "🤖 FRIDAY's Recommendation:"
echo "   1. Open GitHub Copilot Chat"
echo "   2. Copy-paste the Step 1 protocol above"
echo "   3. Let me guide you through professional development"
echo ""
echo "I'll be here to assist you throughout your development journey."
echo "Together, we'll build something remarkable."
echo ""
echo "Ready when you are! 🚀"
echo ""
