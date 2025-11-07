# Persona & Memory Assistant Template

> 🚀 Dibangun dengan Astro + React (Islands) + Tailwind + Framer Motion

[![GitHub Template](https://img.shields.io/badge/Template-Ready-brightgreen)](https://github.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![AI Assistant](https://img.shields.io/badge/AI-FRIDAY-blue)](https://github.com)

---

## ✨ Ringkasan

FRIDAY is a configurable AI persona + memory system template. It ships reusable instruction files,
persona behavior artifacts, and a durable project memory protocol you can adapt to ANY domain.

[![GitHub Template](https://img.shields.io/badge/Template-Ready-brightgreen)](https://github.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🎯 What Is This?

This is a **project-agnostic AI persona configuration template** that gives you:

- ✅ **Consistent AI behavior** across all projects
- ✅ **Zero context loss** between sessions
- ✅ **Enterprise-grade memory system**
- ✅ **Modular documentation structure**
- ✅ **Best practices built-in**
- ✅ **One-click project setup**

---

## 🚀 Cara Menjalankan

```bash
# Instal dependency
npm install

# Jalankan lokal
npm run dev

# Build produksi
npm run build
npm run preview
```

---

## 📂 Struktur Proyek

```
.github/
├── copilot-instructions.md       # Main AI configuration (customize this!)
├── instructions/                 # Modular instruction files
│   ├── architecture.md          # System architecture template
│   ├── development-workflow.md  # Commands, testing, deployment
│   ├── patterns.md              # Code patterns & best practices
│   ├── integration.md           # Integration guidelines
│   ├── common-tasks.md          # Common modifications
│   ├── gotchas.md               # Critical issues & troubleshooting
│   ├── file-reference.md        # File-specific notes
│   ├── recent-features.md       # Changelog / phase roadmap template
│   ├── persona-modes.md         # Persona response modes
│   ├── persona-guardrails.md    # Persona guardrails & tooling protocol
│   ├── persona-evals.md         # Persona evaluation rubric
│   ├── tooling-matrix.md        # Task→tool decision guide
│   ├── persona-instrumentation.md # Feedback loop & logging template
│   └── persona-fewshots.md      # Canonical examples per mode
└── memory/                       # Persistent memory system
    ├── INDEX.md                  # Memory overview (customize this!)
    ├── implementations/          # Feature implementations
    ├── decisions/                # Architecture decisions
    ├── issues/                   # Bugs & troubleshooting
    └── archive/                  # Completed items
```

---

## 🎨 Teknologi

### Step 1: Update Main Configuration

Edit `.github/copilot-instructions.md` (main entrypoint loaded by Copilot sessions):

```markdown
# Replace placeholders:

{{PROJECT_NAME}} → Your project name {{PROJECT_TYPE}} → web/mobile/api/cli/chatbot {{TECH_STACK}} →
Node.js/Python/React/Vue/etc {{PRIMARY_LANGUAGE}} → JavaScript/TypeScript/Python {{FRAMEWORK}} →
Express/FastAPI/Next.js/etc
```

### Step 2: Customize Instructions (Pick only what you need)

Update files in `.github/instructions/`:

- **architecture.md** - Your project structure
- **patterns.md** - Your code patterns
- **development-workflow.md** - Your commands & workflows
- **persona-modes.md** - Adjust default mode (concise) & when to produce docs
- **persona-guardrails.md** - Enforce safety, accuracy, and tooling protocol
- **persona-fewshots.md** - Tune style using examples per mode
- **persona-evals.md** - Define how you’ll evaluate persona quality
- **tooling-matrix.md** - Decide which tools to use for which tasks
- **persona-instrumentation.md** - Set up repo-local feedback loop

### Step 3: Initialize Memory

Create `.github/memory/current-state.md`:

```markdown
# Project Current State

**Project:** {{PROJECT_NAME}} **Type:** {{PROJECT_TYPE}} **Tech Stack:** {{TECH_STACK}}

## Features Implemented

- [ ] Feature 1
- [ ] Feature 2

## Current Focus

Working on: Initial setup

## Known Issues

None yet
```

### Step 4: Replace Template Content

### Optional: Validate Persona Setup (Persona integrity check)

Run the persona validator (Node.js required):

```bash
node .github/scripts/persona-validate.js || true
```

It checks required persona files exist and are referenced by `.github/copilot-instructions.md`.

After customizing, replace this README with your project-specific one (keep persona sections if
useful).

---

## 🧪 Checklist Fungsional

- Responsif (mobile/tablet/desktop)
- Toggle tema (persist)
- Animasi scroll (reveal)
- Hover states di tombol/kartu
- Filter proyek berfungsi
- Form kontak mengirim sukses

## 🔎 SEO & Aksesibilitas (Quick Wins)

1. **INDEX.md** - Quick overview & lookup
2. **implementations/** - Recent work
3. **decisions/** - Architecture choices
4. **issues/** - Known bugs

### Instruction Hierarchy

```
Priority 0: Memory Protocol (always check memory first)
Priority 1: Critical Rules (test framework, file size limits)
Priority 2: Project-specific patterns
Priority 3: Best practices & guidelines
```

### Auto-Loading

GitHub Copilot automatically reads `.github/copilot-instructions.md` in every chat session, giving
the AI full project context without manual prompting.

---

## 🔧 Konfigurasi Tambahan

### Works For (Examples)

✅ Web apps (React, Vue, Next.js)  
✅ Backend APIs (Node, Python, Go)  
✅ Mobile apps (React Native, Flutter)  
✅ CLI & tooling projects  
✅ Data / ML workflows (Jupyter, scripts)  
✅ DevOps / infra-as-code repositories  
✅ Chat / messaging bots (optional – not assumed)

- Sumber gambar sementara: Unsplash (lisensi bebas pakai, atribusi dihargai)
- Chatbot: https://unsplash.com/photos/photo-1603354350317-6f7aaa591d35
- Finansial: https://unsplash.com/photos/photo-1559526324-593bc073d938
- Potret profesional: https://unsplash.com/photos/photo-1544005313-94ddf0286df2

---

### DO:

✅ Update memory after major implementations ✅ Document decisions in `decisions/` ✅ Keep
instructions modular and focused ✅ Use placeholders for reusability ✅ Commit memory changes to git

### DON'T:

❌ Hardcode project-specific values in template ❌ Skip memory updates (causes context loss) ❌ Mix
multiple concerns in one instruction file ❌ Forget to customize after cloning

---

## 🔄 Updating Template

To get latest improvements:

```bash
# Add template as remote
git remote add template https://github.com/YOUR_USERNAME/ai-assistant-template.git

# Fetch updates
git fetch template

# Merge updates (resolve conflicts if any)
git merge template/main --allow-unrelated-histories

# Review changes
git diff HEAD~1

# Commit
git commit -m "chore: update AI assistant template"
```

---

## 📊 Features

| Feature              | Status | Description                        |
| -------------------- | ------ | ---------------------------------- |
| Memory System        | ✅     | Persistent context across sessions |
| Modular Instructions | ✅     | Organized by topic                 |
| Auto-Loading         | ✅     | Zero manual setup needed           |
| Customizable         | ✅     | Placeholder-based                  |
| Version Controlled   | ✅     | Git-friendly                       |
| Team-Ready           | ✅     | Share across team                  |
| Language Agnostic    | ✅     | Works with any stack               |

---

## 🤝 Contributing

Improvements welcome! To contribute:

1. Fork this repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'feat: add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open Pull Request

---

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details

---

## 🎓 Learn More

### Resources

- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [Agent Memory Extension](https://marketplace.visualstudio.com/items?itemName=digitarald.agent-memory)
- [AI Prompt Engineering](https://platform.openai.com/docs/guides/prompt-engineering)

### Example Adaptations (Replace with yours)

- Full-stack monorepo: Add module-specific persona extensions (`persona-module-<name>.md`).
- Data science repo: Add `persona-notebooks-guidelines.md` for cell hygiene & experiment logging.
- API service: Add `persona-api-review.md` for endpoint contract validation workflow.

---

## 💬 Support

- **Issues:** [GitHub Issues](https://github.com/YOUR_USERNAME/ai-assistant-template/issues)
- **Discussions:**
  [GitHub Discussions](https://github.com/YOUR_USERNAME/ai-assistant-template/discussions)

---

## ⭐ Show Your Support

If this template helps you, please give it a star! ⭐

---

**Created by:** Your Name  
**Version:** 1.0.0  
**Last Updated:** November 7, 2025
