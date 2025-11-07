# FRIDAY MCP Server - Vision & Architecture

**Created:** November 8, 2025  
**Status:** Vision Document  
**Goal:** Personal AI Agent with One-Command Setup

---

## 🎯 Vision

**Problem with Current Approach:**
- Template repository requires manual cloning
- Manual configuration for each new project
- Redis setup is manual
- Persona/instructions need copy-paste
- Not portable across projects

**FRIDAY MCP Server Solution:**
```bash
# In any new project:
User: "#friday-setup web"

# Everything configured automatically:
✅ .github/memory/ created
✅ Copilot instructions deployed
✅ Redis auto-detected & configured
✅ FRIDAY persona activated
✅ Ready to code in seconds!
```

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│         FRIDAY MCP Server (Centralized)         │
├─────────────────────────────────────────────────┤
│  Persona Engine                                 │
│  ├── Copilot Instructions (built-in)            │
│  ├── Memory Instructions (built-in)             │
│  ├── Guardrails (built-in)                      │
│  └── Response Modes (built-in)                  │
├─────────────────────────────────────────────────┤
│  Memory System (Hybrid)                         │
│  ├── Git Memory Manager                         │
│  │   ├── Auto-create .github/memory/            │
│  │   ├── Initialize INDEX.md                    │
│  │   ├── Setup current-state.md                 │
│  │   └── Lifecycle management                   │
│  │                                               │
│  └── Redis Memory Client (Optional)             │
│      ├── Auto-detect Redis server               │
│      ├── Semantic search & retrieval            │
│      ├── Session persistence                    │
│      └── Cross-project context                  │
├─────────────────────────────────────────────────┤
│  MCP Tools (Model Context Protocol)             │
│  ├── friday-setup           (Initialize)        │
│  ├── friday-memory-check    (Health check)      │
│  ├── friday-context-load    (Load context)      │
│  ├── friday-context-update  (Update memory)     │
│  └── friday-config          (Show config)       │
├─────────────────────────────────────────────────┤
│  Configuration                                   │
│  ├── Redis connection settings                  │
│  ├── Project templates (web, api, cli, etc)     │
│  ├── Memory lifecycle rules                     │
│  └── Persona customization                      │
└─────────────────────────────────────────────────┘
```

---

## 🛠️ Project Structure

```
friday-mcp-server/
├── src/
│   ├── index.ts                    # MCP server entry point
│   ├── server.ts                   # MCP protocol handler
│   │
│   ├── tools/                      # MCP Tools
│   │   ├── setup.ts                # friday-setup
│   │   ├── memory.ts               # Memory operations
│   │   ├── context.ts              # Context loading
│   │   └── config.ts               # Configuration
│   │
│   ├── persona/                    # Built-in Persona
│   │   ├── instructions.ts         # Copilot instructions
│   │   ├── memory-instructions.ts  # Memory protocol
│   │   ├── guardrails.ts           # Safety rules
│   │   └── modes.ts                # Response modes
│   │
│   ├── memory/                     # Memory Managers
│   │   ├── git-manager.ts          # Git memory operations
│   │   ├── redis-client.ts         # Redis integration
│   │   └── hybrid.ts               # Git + Redis hybrid
│   │
│   ├── templates/                  # Project Templates
│   │   ├── web-app.ts              # Web application
│   │   ├── api-server.ts           # API/Backend
│   │   ├── cli-tool.ts             # CLI application
│   │   └── generic.ts              # Generic project
│   │
│   └── utils/
│       ├── detector.ts             # Auto-detect project type
│       ├── redis-finder.ts         # Auto-find Redis
│       └── validator.ts            # Validation helpers
│
├── tests/
│   ├── tools/                      # Tool tests
│   ├── memory/                     # Memory tests
│   └── integration/                # E2E tests
│
├── templates/                      # File templates
│   ├── copilot-instructions.md
│   ├── memory-instructions.md
│   └── INDEX.md.template
│
├── package.json
├── tsconfig.json
└── README.md
```

---

## 🎮 MCP Tools Specification

### 1. **friday-setup**

**Purpose:** Initialize FRIDAY in current project

**Input:**
```typescript
{
  projectType?: "web" | "api" | "cli" | "auto-detect",
  enableRedis?: boolean,
  memoryCapacity?: number  // Max memory files
}
```

**Actions:**
1. Detect/confirm project type
2. Create `.github/memory/` structure:
   - implementations/
   - decisions/
   - issues/
   - archive/
3. Deploy copilot-instructions.md
4. Deploy memory-instructions.md
5. Initialize INDEX.md with project context
6. Create current-state.md
7. Detect & configure Redis (if available)
8. Activate FRIDAY persona

**Output:**
```
✅ FRIDAY Setup Complete

Project: my-awesome-app
Type: Web Application
Memory: Hybrid (Git + Redis)
Redis: localhost:6379

Files created:
  .github/memory/INDEX.md
  .github/memory/current-state.md
  .github/copilot-instructions.md
  .github/instructions/memory.instructions.md

FRIDAY is now active! 🤖
```

---

### 2. **friday-memory-check**

**Purpose:** Check memory health & statistics

**Input:** None

**Actions:**
1. Check INDEX.md freshness
2. Check current-state.md age
3. Count files by category
4. Identify stale files (>30 days)
5. Check Redis connection (if enabled)

**Output:**
```
📊 Memory Health Report

Files:
  Implementations: 5
  Decisions: 3
  Issues: 2
  Archived: 8

Freshness:
  INDEX.md: ✅ 2 days old
  current-state.md: ✅ 1 day old
  Stale files: ⚠️  2 files (>30 days)

Redis: ✅ Connected (localhost:6379)
```

---

### 3. **friday-context-load**

**Purpose:** Load project context for AI

**Input:**
```typescript
{
  sources?: "git" | "redis" | "hybrid",
  maxDepth?: number  // How far back to load
}
```

**Actions:**
1. Load INDEX.md
2. Load current-state.md
3. Load recent implementations (last 7 days)
4. Load from Redis (if enabled)
5. Merge & deduplicate context

**Output:** Context object for AI consumption

---

### 4. **friday-context-update**

**Purpose:** Update memory after work

**Input:**
```typescript
{
  type: "implementation" | "decision" | "issue",
  title: string,
  content: string,
  updateCurrentState?: boolean
}
```

**Actions:**
1. Create memory file in appropriate directory
2. Update current-state.md (if requested)
3. Update INDEX.md
4. Store in Redis (if enabled)
5. Run lifecycle check

**Output:**
```
✅ Memory Updated

Created: .github/memory/implementations/auth-feature-nov8-2025.md
Updated: current-state.md
Synced: Redis

Memory is fresh!
```

---

### 5. **friday-config**

**Purpose:** Show/update FRIDAY configuration

**Input:**
```typescript
{
  action: "show" | "update",
  settings?: {
    redisUrl?: string,
    memoryCapacity?: number,
    lifecycleRules?: object
  }
}
```

**Output:**
```
🔧 FRIDAY Configuration

Project: my-awesome-app
Persona: Active

Memory:
  Mode: Hybrid (Git + Redis)
  Git: .github/memory/
  Redis: localhost:6379
  Capacity: 100 files

Lifecycle:
  Stale: >30 days
  Archive: >90 days
  Cleanup: >180 days
```

---

## 🔄 Memory System (Hybrid)

### **Git Memory** (Structured Documentation)
```
.github/memory/
├── INDEX.md               # Project overview
├── current-state.md       # Current status
├── implementations/       # Feature implementations
├── decisions/            # Architecture decisions
├── issues/               # Bug fixes & solutions
└── archive/              # Old files
```

**Characteristics:**
- ✅ Version controlled
- ✅ Team visible
- ✅ Structured & reviewable
- ✅ Free (no cost)

**Best For:**
- Architecture decisions
- Implementation details
- Known issues & solutions

---

### **Redis Memory** (Semantic & Fast)
```
Redis Keys:
- friday:project:{id}:index
- friday:project:{id}:state
- friday:project:{id}:memory:{type}:{id}
- friday:session:{id}:context
```

**Characteristics:**
- ✅ Fast semantic search
- ✅ Session persistence
- ✅ Cross-project context
- ✅ Recency-aware ranking

**Best For:**
- User preferences
- Session context
- Quick notes
- Semantic search

---

### **Hybrid Strategy**

```
READ:
1. Load from Git (structure)
2. Enhance with Redis (semantic)
3. Merge & rank by relevance + recency

WRITE:
1. Save to Git (structured file)
2. Index in Redis (semantic search)
3. Update both in sync
```

---

## 🚀 User Experience

### **Scenario 1: New Web Project**

```bash
# User starts new project
mkdir my-web-app && cd my-web-app
npm init -y
code .

# In VS Code chat:
User: "#friday-setup web"

FRIDAY:
  🔍 Detected: Node.js web application
  📁 Creating memory structure...
  📝 Deploying copilot instructions...
  🔌 Redis detected at localhost:6379
  ✅ FRIDAY activated!
  
  Project: my-web-app
  Type: Web Application
  Memory: Hybrid (Git + Redis)
  
  Ready to assist! What would you like to build?

User: "Let's add authentication with JWT"

FRIDAY:
  [Loads context silently]
  [Knows: new project, web app, no auth yet]
  
  I'll implement JWT authentication. Here's the plan:
  1. Install dependencies (jsonwebtoken, bcryptjs)
  2. Create auth middleware
  3. Add login/register routes
  4. Setup token validation
  
  [Implements feature]
  [Updates memory automatically]
```

---

### **Scenario 2: Returning to Project**

```bash
# User opens existing project
code my-web-app/

# FRIDAY auto-loads context from Git + Redis
# No need to re-explain project

User: "How's the authentication coming along?"

FRIDAY:
  [Loads from memory]
  
  Authentication is implemented! ✅
  
  Last update: Nov 7, 2025
  Implementation: JWT-based auth
  Status: Tested & working
  
  Files:
  - src/middleware/auth.js
  - src/routes/auth.js
  - tests/auth.test.js
  
  What would you like to improve?
```

---

## 📊 Benefits

### **For Developers:**
✅ **Zero manual setup** - One command, everything ready  
✅ **Portable** - Works in any project  
✅ **Consistent** - Same FRIDAY experience everywhere  
✅ **No copy-paste** - Persona & configs built-in  
✅ **Centralized updates** - Update MCP once, all projects benefit  

### **For FRIDAY:**
✅ **Always has persona** - Never forgets how to behave  
✅ **Memory ready instantly** - Git + Redis configured  
✅ **Context never lost** - Persistent across sessions  
✅ **Semantic search** - Find relevant context fast  
✅ **Cross-project learning** - Share knowledge between projects  

---

## 🎯 Implementation Roadmap

### **Phase 1: MCP Server Foundation** (Week 1-2)
- [ ] Setup MCP server boilerplate (TypeScript)
- [ ] Implement `friday-setup` tool
- [ ] Bundle copilot-instructions
- [ ] Git memory auto-creation
- [ ] Basic tests (20+ tests)

### **Phase 2: Redis Integration** (Week 3-4)
- [ ] Redis auto-detection
- [ ] Hybrid memory implementation
- [ ] Semantic search integration
- [ ] Session persistence
- [ ] Integration tests

### **Phase 3: Advanced Features** (Week 5-6)
- [ ] Project templates (web, api, cli)
- [ ] Context migration between projects
- [ ] Memory lifecycle automation
- [ ] Performance optimization

### **Phase 4: Polish & Documentation** (Week 7-8)
- [ ] Complete documentation
- [ ] Usage examples
- [ ] Video tutorials
- [ ] Package & publish (npm)

---

## 🔧 Technical Stack

**Server:**
- TypeScript
- @modelcontextprotocol/sdk
- Node.js 18+

**Memory:**
- Git (local filesystem)
- Redis (optional, via ioredis)

**Testing:**
- Jest
- Supertest (for MCP protocol)

**Packaging:**
- npm (public or private)
- Docker (optional for Redis)

---

## 📝 Configuration Example

**~/.config/friday-mcp/config.json**
```json
{
  "version": "1.0.0",
  "redis": {
    "enabled": true,
    "url": "localhost:6379",
    "autoDetect": true
  },
  "memory": {
    "maxFiles": 100,
    "lifecycle": {
      "staleThreshold": 30,
      "archiveThreshold": 90,
      "cleanupThreshold": 180
    }
  },
  "persona": {
    "mode": "concise",
    "autoUpdate": true
  },
  "templates": {
    "default": "generic",
    "web": "web-app",
    "api": "api-server"
  }
}
```

---

## 🔐 Security Considerations

**Git Memory:**
- ✅ No secrets in memory files
- ✅ .gitignore for sensitive data
- ✅ Review before commit

**Redis:**
- ✅ Local only by default
- ✅ Authentication required for remote
- ✅ Encryption in transit (TLS)
- ✅ No PII without consent

**MCP Server:**
- ✅ Sandboxed execution
- ✅ No network access (unless configured)
- ✅ File access limited to project dir

---

## 🌟 Future Enhancements

**Team Collaboration:**
- Shared Redis for team context
- Multi-user memory permissions
- Conflict resolution

**Advanced Memory:**
- Vector embeddings for semantic search
- Auto-summarization of old files
- Cross-project pattern detection

**AI Capabilities:**
- Fine-tuned FRIDAY model
- Domain-specific expertise
- Code generation templates

---

## 📚 References

**Related Documents:**
- `docs/SMART_MEMORY_ENFORCEMENT.md` - Current memory system
- `docs/POWERFUL_AI_MEMORY_SOLUTIONS.md` - Redis research
- `.github/copilot-instructions.md` - Current persona

**External:**
- [Model Context Protocol Spec](https://modelcontextprotocol.io)
- [Redis Agent Memory Server](https://github.com/redis/agent-memory-server)
- [MCP SDK Documentation](https://github.com/modelcontextprotocol/sdk)

---

## ✅ Next Steps

1. **Finalize current branch** - Merge `feat/smart-memory-enforcement`
2. **Create new branch** - `feat/friday-mcp-server`
3. **Implement Phase 1** - Basic MCP server with friday-setup
4. **Test thoroughly** - 50+ tests covering all tools
5. **Document & publish** - npm package + documentation

---

**Status:** Vision Document  
**Last Updated:** November 8, 2025  
**Author:** FRIDAY Development Team  

**Ready to build the future of AI-assisted development! 🚀**
