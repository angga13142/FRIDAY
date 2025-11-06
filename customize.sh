#!/bin/bash

# AI Assistant Template - Customization Script
# This script helps you quickly customize the template for your project

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎨 AI Assistant Template - Customization Wizard"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Collect project information
echo "Let's customize your AI assistant configuration!"
echo ""

read -p "📝 Project Name (e.g., My Awesome Project): " PROJECT_NAME
read -p "🏷️  Project Type (web/mobile/api/cli/chatbot): " PROJECT_TYPE
read -p "🛠️  Tech Stack (e.g., Node.js + Express): " TECH_STACK
read -p "💻 Primary Language (JavaScript/TypeScript/Python/etc): " PRIMARY_LANGUAGE
read -p "🎯 Framework (e.g., Express/FastAPI/Next.js): " FRAMEWORK

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

read -p "✅ Looks good? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "❌ Customization cancelled"
    exit 1
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

---

**Last Updated:** $(date +"%B %d, %Y")
EOF

echo "  ✅ current-state.md created"

# Remove template README
echo ""
echo "🧹 Cleaning up template README..."
rm -f README.md
echo "  ✅ Template README removed"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Customization Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Create your project README:"
echo "   echo '# $PROJECT_NAME' > README.md"
echo ""
echo "2. Review customized files:"
echo "   - .github/copilot-instructions.md"
echo "   - .github/memory/INDEX.md"
echo "   - .github/memory/current-state.md"
echo ""
echo "3. Start coding! The AI will:"
echo "   ✅ Auto-load your project configuration"
echo "   ✅ Understand your tech stack"
echo "   ✅ Follow your patterns & guidelines"
echo "   ✅ Remember context across sessions"
echo ""
echo "4. Update memory as you progress:"
echo "   - Add implementations to memory/implementations/"
echo "   - Document decisions in memory/decisions/"
echo "   - Track issues in memory/issues/"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Happy Coding!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
