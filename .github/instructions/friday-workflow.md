# FRIDAY Workflow - Quick Start Trigger

## Trigger Command: "hey friday"

When you say **"hey friday"**, I'll initiate the complete template setup workflow automatically.

---

## What Happens After "hey friday"

### Phase 1: Project Discovery (1-2 minutes)

I'll ask you a few quick questions:

1. **Project Name**: What's this project called?
2. **Project Type**: web/mobile/api/cli/data-science/chatbot/other?
3. **Tech Stack**: Main technologies (e.g., Node.js + Express, Python + FastAPI)
4. **Primary Language**: JavaScript/TypeScript/Python/Go/etc.
5. **Framework** (if applicable): Express/React/Next.js/Django/etc.

### Phase 2: Template Customization (automatic)

I'll:

- Replace all `{{PLACEHOLDERS}}` in config files
- Create initial `current-state.md` with your project info
- Update `INDEX.md` with your project name
- Generate project-specific `.env.example` if needed

### Phase 3: Persona Setup (automatic)

I'll:

- Run persona validator to ensure all artifacts are linked
- Initialize memory structure
- Create placeholder implementation/decision files

### Phase 4: Quick Wins (automatic)

I'll:

- Scan your existing codebase (if any) to understand architecture
- Generate initial architecture.md overview
- Suggest 3-5 quick improvements based on patterns found
- Create initial roadmap in recent-features.md

### Phase 5: Verification (automatic)

I'll:

- Run validator script
- Check that memory protocol is working
- Verify persona modes are accessible
- Confirm all placeholders replaced

### Phase 6: Next Steps (guidance)

I'll provide:

- Summary of what was set up
- Recommended first commands to run
- Link to key instruction files for your project type
- Optional: GitHub Copilot CLI setup instructions

---

## Example Conversation Flow

**You:** hey friday

**Me:**

```
🤖 FRIDAY: Initializing template setup workflow...

Let's get your project configured! I need a few details:

1. **Project Name**: (e.g., "E-Commerce API")
2. **Project Type**: Choose one:
   - web (frontend/fullstack web app)
   - api (backend REST/GraphQL API)
   - mobile (React Native/Flutter)
   - cli (command-line tool)
   - data-science (Jupyter/ML pipeline)
   - chatbot (messaging bot)
   - other (describe briefly)

Please provide these details and I'll configure everything automatically.
```

**You:** Project Name: CRM Dashboard, Type: web, Stack: React + TypeScript + Tailwind, Language:
TypeScript, Framework: Next.js

**Me:**

```
✅ Got it! Setting up CRM Dashboard...

[Automatic execution of Phases 2-6]

🎉 Template setup complete!

📊 What I configured:
- ✅ Replaced placeholders in all config files
- ✅ Created memory structure (.github/memory/current-state.md)
- ✅ Generated architecture overview from existing code
- ✅ Validated persona setup (all checks passed)
- ✅ Created initial roadmap template

📁 Key Files Ready:
- .github/copilot-instructions.md (AI behavior config)
- .github/memory/current-state.md (project status)
- .github/instructions/architecture.md (Next.js app structure)

🚀 Recommended Next Steps:
1. Review: cat .github/memory/current-state.md
2. Customize: Edit architecture.md with your specific modules
3. Install: npm install (if not already done)
4. Develop: I'm ready to assist with your first feature!

💡 Try these commands:
- "Show me the architecture overview"
- "Help me add a new feature: user authentication"
- "Review my recent code changes"
- "Update memory with what we just built"
```

---

## Workflow Shortcuts

After initial setup, you can use these quick triggers:

- **"hey friday"** → Full setup (first time only)
- **"friday status"** → Show current project state from memory
- **"friday help"** → List available persona modes and common tasks
- **"friday update"** → Trigger auto-update of copilot-instructions.md
- **"friday validate"** → Run persona validator
- **"friday memory"** → Show memory index and recent items

---

## What Makes This Special

Traditional approach:

- User reads README → runs customize.sh → edits files manually → hopes AI understands context

**FRIDAY approach:**

- User says "hey friday" → AI handles everything → provides immediate guidance → ready to work

---

## Customization Options

You can skip phases if needed:

**Quick setup (minimal):**

> "hey friday, quick setup: MyApp, web, React+TypeScript"

**Skip questions (use defaults):**

> "hey friday, auto-setup with project name: TaskManager"

**Expert mode (no guidance):**

> "hey friday, setup only, skip recommendations"

---

## Technical Implementation

When you say "hey friday", I execute this workflow:

```javascript
// Pseudo-code for FRIDAY workflow
async function handleHeyFriday(userInput) {
  // Phase 1: Collect info (interactive or parse from message)
  const projectInfo = await collectProjectInfo(userInput);

  // Phase 2: Customize template
  await replaceAllPlaceholders(projectInfo);
  await generateInitialMemory(projectInfo);

  // Phase 3: Persona setup
  await runValidator();
  await initializeMemoryStructure();

  // Phase 4: Quick wins
  const codebase = await scanCodebase();
  await generateArchitectureDoc(codebase);
  await suggestImprovements(codebase);

  // Phase 5: Verify
  const checks = await runAllChecks();

  // Phase 6: Report
  return formatSetupSummary(checks, projectInfo);
}
```

---

## What Gets Created/Modified

Files created:

- `.github/memory/current-state.md`
- `.github/memory/implementations/.gitkeep`
- `.github/memory/decisions/.gitkeep`
- `.github/memory/issues/.gitkeep`

Files modified:

- `.github/copilot-instructions.md` (placeholders replaced)
- `.github/memory/INDEX.md` (project name added)
- `.github/instructions/architecture.md` (generated overview)
- `.github/instructions/recent-features.md` (initial roadmap)

Files NOT modified (you customize later):

- `patterns.md`, `integration.md`, `common-tasks.md`, etc.

---

## Success Criteria

Setup is complete when:

- ✅ All `{{PLACEHOLDERS}}` replaced
- ✅ `current-state.md` exists with project info
- ✅ Validator passes (all persona files linked)
- ✅ At least 1 architecture pattern documented
- ✅ Memory protocol initialized

You'll know it worked when:

- I can reference your project by name
- Memory lookups return project-specific info
- Architecture questions get relevant answers
- Suggestions align with your tech stack

---

## Troubleshooting

**Issue:** "hey friday" doesn't trigger workflow

- **Solution:** Make sure message starts with exactly "hey friday" (case-insensitive)

**Issue:** Setup asks too many questions

- **Solution:** Use quick setup format with all info in one line

**Issue:** Generated architecture is wrong

- **Solution:** I'll scan your codebase; if it doesn't exist yet, I'll use defaults based on tech
  stack

**Issue:** Want to re-run setup

- **Solution:** Say "hey friday, reset and re-setup" (preserves existing memory)

---

## Next Evolution Ideas

Future enhancements to "hey friday":

- Voice command support (via Copilot Voice)
- Visual setup wizard in VS Code sidebar
- GitHub Actions integration (setup on push)
- Team onboarding mode (multi-user setup)
- Project templates library (pre-configured setups)

---

Ready to try? Just say: **"hey friday"** 🚀
