# Template Sterilization Protocol

## 🎯 Purpose

Ensure FRIDAY template contains **ONLY generic files** before:

- Creating GitHub releases
- Sharing template publicly
- Pushing to main branch after major changes
- Distributing to team members

## 🧹 What is "Sterilization"?

Removing ALL project-specific code, configs, and content to ensure template is **100% reusable**.

---

## 📋 Pre-Release Checklist

### Before Every Release:

```bash
# 1. Run sterilization check
bash .github/scripts/template-sterilization-check.sh

# 2. If PASS → Proceed with release
# 3. If FAIL → Fix issues and re-run
```

### Manual Verification (if script unavailable):

- [ ] No `src/`, `public/`, `tests/` folders
- [ ] No `package.json`, `*.config.js`, framework configs
- [ ] All placeholders intact (`{{PROJECT_NAME}}`, etc.)
- [ ] `.gitignore` blocks project files
- [ ] No hardcoded project names in docs
- [ ] No secrets or API keys
- [ ] All required persona files present

---

## 🔍 Automated Checks (Script)

The script performs **8 automated checks**:

### ✅ Check 1: Project-specific directories

**FAIL if found:**

- `src/`, `public/`, `tests/`, `lib/`, `dist/`, `build/`
- `node_modules/`, `venv/`, `__pycache__/`
- `.next/`, `.nuxt/`, `out/`

### ✅ Check 2: Project-specific configs

**FAIL if found:**

- `package.json`, `*.lock` files
- Framework configs (astro, next, vite, nuxt, etc.)
- `tsconfig.json`, `tailwind.config.*`, `postcss.config.*`
- Language-specific: `requirements.txt`, `go.mod`, `Cargo.toml`

### ⚠️ Check 3: Placeholder integrity

**WARN if missing:**

- `{{PROJECT_NAME}}`
- `{{PROJECT_TYPE}}`
- `{{TECH_STACK}}`
- `{{PRIMARY_LANGUAGE}}`
- `{{FRAMEWORK}}`

**Checked in:**

- `.github/copilot-instructions.md`
- `.github/memory/INDEX.md`
- `README.md`

### ⚠️ Check 4: Hardcoded content

**WARN if found:** Searches for project-specific terms:

- "Portfolio", "CRM Dashboard"
- "chatbot", "WhatsApp"
- Framework-specific app names

**Excludes:**

- `.github/memory/` (examples allowed)
- `docs/` (documentation examples)
- `CHANGELOG.md` (version history)

### ✅ Check 5: Required template files

**FAIL if missing:**

- Persona files (modes, guardrails, fewshots, etc.)
- Instruction files (architecture, patterns, workflow, etc.)
- Scripts (persona-validate.js, auto-update, sterilization)
- Core files (README, LICENSE, CHANGELOG, .gitignore)

### ✅ Check 6: .gitignore configuration

**FAIL if missing patterns:**

- `src/`, `public/`, `tests/`
- `package.json`
- `*.config.mjs`, `*.config.cjs`, `*.config.js`

### ⚠️ Check 7: Secrets detection

**WARN if found:** Scans for secret patterns:

- API_KEY, SECRET_KEY, PASSWORD
- `xnd_production`, `sk-*`, `ghp_*`

**Excludes:** `.env.example` (safe)

### ⚠️ Check 8: Git history cleanliness

**WARN if found:**

- Files > 1MB in git history
- Suggests cleanup if needed

---

## 🚨 Failure Response

### If Script Returns FAIL:

```bash
❌ TEMPLATE IS NOT STERILE - DO NOT RELEASE!

Critical issues found. Fix failures before releasing template.
```

**Actions:**

1. Review failure messages
2. Remove/fix flagged files
3. Re-run script: `bash .github/scripts/template-sterilization-check.sh`
4. Repeat until PASS

### If Script Returns WARNINGS:

```bash
⚠️  TEMPLATE HAS WARNINGS - Review recommended
```

**Actions:**

1. Review warnings (may be acceptable)
2. If warnings are intentional (e.g., examples in docs) → Proceed
3. If warnings are mistakes → Fix and re-run

---

## ✅ Success Criteria

```bash
✅ TEMPLATE IS STERILE - Safe for release!

🎉 All checks passed. Template contains only generic files.
```

**Safe to:**

- Create GitHub release
- Share publicly
- Distribute to team
- Push to main

---

## 🔄 Integration with Workflow

### Option 1: Manual (Recommended for now)

Before every release:

```bash
bash .github/scripts/template-sterilization-check.sh
```

### Option 2: Git Hook (Pre-commit)

Create `.git/hooks/pre-commit`:

```bash
#!/bin/bash
bash .github/scripts/template-sterilization-check.sh
exit $?
```

Blocks commits if template not sterile.

### Option 3: GitHub Actions (CI)

Create `.github/workflows/sterilization-check.yml`:

```yaml
name: Sterilization Check

on: [push, pull_request]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0 # Full history for Check 8
      - name: Run Sterilization Check
        run: bash .github/scripts/template-sterilization-check.sh
```

Runs automatically on every push.

---

## 🛠️ Manual Cleanup Process

### If automated checks not available:

#### 1. Remove Project Files

```bash
rm -rf src/ public/ tests/
rm -f package*.json *.config.{js,mjs,cjs,ts}
rm -f tsconfig.json vitest.config.js
```

#### 2. Verify Placeholders

```bash
# Check copilot-instructions.md
grep -c "{{PROJECT_NAME}}" .github/copilot-instructions.md
# Should return 1+ matches

# Check all placeholders present
for placeholder in PROJECT_NAME PROJECT_TYPE TECH_STACK PRIMARY_LANGUAGE FRAMEWORK; do
  echo -n "$placeholder: "
  grep -c "{{$placeholder}}" .github/copilot-instructions.md
done
```

#### 3. Update .gitignore

Ensure these patterns exist:

```
src/
public/
tests/
*.config.mjs
*.config.cjs
package.json
```

#### 4. Search for Hardcoded Content

```bash
# Search main docs (exclude memory/changelog)
git grep -i "portfolio\|crm\|chatbot" -- ':!.github/memory/' ':!CHANGELOG.md'

# Should return minimal/no results
```

#### 5. Check Required Files

```bash
# Verify persona files exist
ls -1 .github/instructions/persona-*.md
# Should show: modes, guardrails, fewshots, evals, instrumentation

# Verify scripts exist
ls -1 .github/scripts/*.{sh,js}
# Should show: persona-validate.js, auto-update, sterilization-check
```

---

## 📊 Checklist Summary

**Critical (MUST fix):**

- [ ] No project directories (src, public, tests)
- [ ] No project configs (package.json, _.config._)
- [ ] All required template files present
- [ ] .gitignore properly configured

**Recommended (SHOULD fix):**

- [ ] All placeholders intact
- [ ] No hardcoded project names
- [ ] No secrets in code
- [ ] No large files in git history

---

## 🎯 Success Indicators

**Template is sterile when:**

1. ✅ Clone → Only see `.github/`, `customize.sh`, `README`, configs
2. ✅ Run `customize.sh` → Creates fresh project structure
3. ✅ No references to specific projects (Portfolio, CRM, etc.)
4. ✅ All placeholders prompt for replacement
5. ✅ Sterilization script returns 0 failures

---

## 📝 Version History

- **v1.0** (Nov 7, 2025) - Initial sterilization protocol
  - Created automated check script
  - Defined 8 verification checks
  - Integrated with release workflow

---

## 🔗 Related Docs

- [Template Sterilization Script](.github/scripts/template-sterilization-check.sh)
- [Persona Validator](.github/scripts/persona-validate.js)
- [Customize Wizard](../../customize.sh)
- [Template README](../../README.md)

---

**Remember:** A sterile template is a reusable template! 🧹✨
