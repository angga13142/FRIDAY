# Memory Index - {{PROJECT_NAME}}

**Last Updated:** {{DATE}}  
**Project Type:** {{PROJECT_TYPE}}  
**Total Files:** {{TOTAL_FILES}} organized in 4 categories

---

## 📂 Directory Structure

```
.github/memory/
├── implementations/     # Feature implementations & technical work
├── decisions/          # Architecture & design decisions
├── issues/            # Bugs, pitfalls, troubleshooting
├── archive/           # Completed/outdated items
└── [root files]       # Active project docs
```

---

## 🚀 Recent Implementations

### Example: Feature Implementation Template

**Date:** YYYY-MM-DD  
**Status:** Complete / In Progress  
**Summary:** Brief description of what was implemented

**Key Components:**
- Component 1 - Description
- Component 2 - Description

**Files Changed:**
- `path/to/file.ext` - Description of changes

**Tests Added:** X tests (all passing)  
**Impact:** Description of impact / metrics

---

## 📋 Template Usage Guide

This is a **template memory index**. After running `customize.sh` or "hey friday":

1. **Replace placeholders:**
   - `{{PROJECT_NAME}}` → Your project name
   - `{{DATE}}` → Current date (YYYY-MM-DD)
   - `{{PROJECT_TYPE}}` → web/api/mobile/cli/data-science/etc
   - `{{TOTAL_FILES}}` → Actual file count
   - `{{TECH_STACK}}` → Your technologies
   - `{{PRIMARY_LANGUAGE}}` → Main language
   - `{{FRAMEWORK}}` → Framework used

2. **Remove this template usage section**

3. **Add your actual implementations** using template format above

---

## 📚 Core Documentation (Customize After Setup)

### Project References

| File | Purpose | Status |
|------|---------|--------|
| `current-state.md` | Current features & roadmap | Create after setup |
| `PROJECT_DOCUMENTATION.md` | Complete overview | Optional |

### Persona Configuration (Pre-configured)

| File | Purpose |
|------|---------|
| `../.github/instructions/persona-modes.md` | Response modes |
| `../.github/instructions/persona-guardrails.md` | Safety & tooling protocol |
| `../.github/instructions/persona-evals.md` | Evaluation rubric |
| `../.github/instructions/tooling-matrix.md` | Task→tool decision guide |

---

## 🗂️ Memory Organization Tips

### When to Create Files

**implementations/**
- After completing a feature
- File naming: `feature-name-YYYY-MM-DD.md`
- Include: what, how, tests, impact

**decisions/**
- After making architecture choices
- File naming: `decision-topic-YYYY-MM-DD.md`
- Include: context, options, choice, rationale, consequences

**issues/**
- When fixing bugs
- File naming: `bug-description-YYYY-MM-DD.md`
- Include: problem, root cause, fix, test, prevention

**archive/**
- Move completed items here monthly
- Keeps INDEX clean and focused

---

## 🔍 Quick Lookup Template

| Need Info About... | Check File |
|-------------------|-----------|
| Project status | `current-state.md` |
| Recent work | `INDEX.md` (this file) |
| How X was built | `implementations/x-*.md` |
| Why we chose Y | `decisions/y-*.md` |
| Bug Z fix | `issues/z-*.md` |

---

## 📝 Maintenance Schedule

**Weekly:** Review and update `current-state.md`  
**Monthly:** Archive old implementations  
**Quarterly:** Prune outdated decisions

Keep INDEX focused on **last 5-10 items** per category.

---

## 🎯 Success Indicators

**Memory is working when:**
- ✅ AI remembers past decisions
- ✅ New team members understand "why"
- ✅ No repeated mistakes
- ✅ Context survives session resets
- ✅ Debugging is faster (known issues doc)

---

**Remember:** Good memory = Good AI assistance! 🧠✨
