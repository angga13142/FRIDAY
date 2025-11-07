# Powerful AI Agent Memory Solutions - Technical Comparison

**Date:** November 7, 2025  
**Source:** Upstash Context7 Research  
**Purpose:** Evaluate enterprise-grade memory systems for FRIDAY template

---

## 🎯 Executive Summary

Dua solusi memory AI agent paling powerful saat ini:

1. **Redis Agent Memory Server** - Production-ready, self-hosted, Redis-based
2. **Letta (MemGPT)** - Managed platform, context-window optimization focus

**Recommendation for FRIDAY:** Hybrid approach - Git memory (current) + Redis Agent Memory Server
(semantic layer)

---

## 📊 Quick Comparison

| Aspect           | Redis Agent Memory   | Letta (MemGPT)    | Git Memory (FRIDAY Current) |
| ---------------- | -------------------- | ----------------- | --------------------------- |
| **Trust Score**  | 9.0/10               | 8.0/10            | N/A (Manual)                |
| **Deployment**   | Self-hosted (Docker) | Cloud/Self-hosted | Local filesystem            |
| **Search**       | Semantic + Filters   | Context-aware     | Manual grep/find            |
| **Cost**         | Free (self-host)     | Freemium          | Free                        |
| **Complexity**   | Medium               | High              | Low                         |
| **Integration**  | REST API + MCP       | Python SDK + API  | Direct file access          |
| **Persistence**  | Redis                | Database          | Git version control         |
| **Team Sharing** | API-based            | Cloud sync        | Git commits                 |

---

## 🔥 Solution 1: Redis Agent Memory Server

**Repository:** https://github.com/redis/agent-memory-server  
**Trust Score:** 9.0  
**Code Examples:** 141 snippets

### Architecture

```
┌─────────────────────────────────────────────┐
│          AI Agent / Application             │
└──────────────┬──────────────────────────────┘
               │
       ┌───────┴────────┐
       │                │
   REST API         MCP Tools
       │                │
┌──────┴────────────────┴──────┐
│   Agent Memory Server         │
│                               │
│  ┌─────────────────────────┐ │
│  │  Working Memory         │ │
│  │  (Session-scoped)       │ │
│  └─────────────────────────┘ │
│                               │
│  ┌─────────────────────────┐ │
│  │  Long-Term Memory       │ │
│  │  (Vector Search)        │ │
│  └─────────────────────────┘ │
│                               │
│  ┌─────────────────────────┐ │
│  │  Memory Compaction      │ │
│  │  (Background Task)      │ │
│  └─────────────────────────┘ │
└───────────────┬───────────────┘
                │
         ┌──────┴──────┐
         │    Redis    │
         └─────────────┘
```

### Core Features

**1. Dual Memory System**

- **Working Memory:** Session-scoped, ephemeral, conversation context
- **Long-Term Memory:** Persistent, semantic searchable, cross-session

**2. Memory Types**

```python
# Semantic Memory (facts, preferences, knowledge)
{
  "text": "User prefers dark mode interfaces",
  "memory_type": "semantic",
  "topics": ["preferences", "ui"],
  "entities": ["dark mode"]
}

# Episodic Memory (events, experiences, timeline)
{
  "text": "User visited Paris in March 2024",
  "memory_type": "episodic",
  "event_date": "2024-03-15T10:00:00Z",
  "topics": ["travel"],
  "entities": ["Paris"]
}

# Message Memory (conversation history)
{
  "text": "user: What's the weather like?",
  "memory_type": "message",
  "session_id": "chat_123"
}
```

**3. Advanced Search Capabilities**

```python
from agent_memory_client import create_memory_client
from agent_memory_client.filters import Topics, UserId, CreatedAt
from datetime import datetime, timezone

client = await create_memory_client(base_url="http://localhost:8000")

# Semantic search with filters
results = await client.search_long_term_memory(
    text="machine learning projects",
    topics=Topics(any=["ml", "ai"], none=["deprecated"]),
    user_id=UserId(eq="developer-123"),
    created_at=CreatedAt(gte=datetime(2024, 1, 1, tzinfo=timezone.utc)),
    distance_threshold=0.8,  # Similarity threshold
    limit=50
)

# Recency-aware search (boost recent + relevant)
from agent_memory_client.models import RecencyConfig

recency_config = RecencyConfig(
    recency_boost=True,
    semantic_weight=0.8,      # Relevance importance
    recency_weight=0.2,       # Time importance
    freshness_weight=0.6,     # Last accessed weight
    novelty_weight=0.4,       # Creation age weight
    half_life_last_access_days=7,
    half_life_created_days=30
)

results = await client.search_long_term_memory(
    text="project updates",
    recency=recency_config,
    limit=10
)
```

**4. Memory-Enriched Prompts**

```python
# Automatically retrieve relevant context for prompts
response = await client.memory_prompt({
    "query": "Help me plan dinner",
    "session": {
        "session_id": "current_chat",
        "model_name": "gpt-4o",
        "context_window_max": 4000
    },
    "long_term_search": {
        "text": "food preferences dietary restrictions",
        "filters": {"user_id": {"eq": "user_123"}},
        "limit": 5
    }
})

# Returns enriched prompt with relevant memories injected
```

**5. Automatic Memory Compaction**

```bash
# Scheduled task to merge duplicates and similar memories
uv run agent-memory schedule-task "agent_memory_server.long_term_memory.compact_long_term_memories"
```

### API Endpoints

```http
# Working Memory
PUT /v1/sessions/{id}/memory
GET /v1/sessions/{id}/memory

# Long-Term Memory
POST /v1/long-term-memory/
POST /v1/long-term-memory/search
GET /v1/long-term-memory/{id}

# Memory Prompt (context enrichment)
POST /v1/memory-prompt
```

### MCP (Model Context Protocol) Interface

Tools exposed untuk LLM agents:

- `set_working_memory` - Store session context
- `create_long_term_memories` - Persist knowledge
- `search_long_term_memory` - Semantic retrieval
- `memory_prompt` - Context-enriched prompts

### Deployment

**Docker Compose:**

```yaml
version: '3.8'
services:
  redis:
    image: redis:7-alpine
    ports:
      - '6379:6379'

  agent-memory:
    image: redis/agent-memory-server:latest
    ports:
      - '8000:8000'
    environment:
      - REDIS_URL=redis://redis:6379
      - OPENAI_API_KEY=${OPENAI_API_KEY}
    depends_on:
      - redis
```

**Start:**

```bash
docker-compose up -d
```

---

## 🧠 Solution 2: Letta (formerly MemGPT)

**Website:** https://www.letta.com  
**Trust Score:** 8.0  
**Code Examples:** 17,008 snippets

### Architecture

```
┌─────────────────────────────────────────────┐
│              LLM Agent                       │
│                                              │
│  ┌────────────────────────────────────────┐ │
│  │        Context Window                  │ │
│  │                                        │ │
│  │  ┌──────────────────────────────────┐ │ │
│  │  │ System Instructions              │ │ │
│  │  └──────────────────────────────────┘ │ │
│  │                                        │ │
│  │  ┌──────────────────────────────────┐ │ │
│  │  │ Core Memory (In-Context)         │ │ │
│  │  │  - Memory Blocks                 │ │ │
│  │  │  - Editable by Agent             │ │ │
│  │  └──────────────────────────────────┘ │ │
│  │                                        │ │
│  │  ┌──────────────────────────────────┐ │ │
│  │  │ File Blocks                      │ │ │
│  │  └──────────────────────────────────┘ │ │
│  │                                        │ │
│  │  ┌──────────────────────────────────┐ │ │
│  │  │ Recent Messages                  │ │ │
│  │  └──────────────────────────────────┘ │ │
│  └────────────────────────────────────────┘ │
│                                              │
│  ┌────────────────────────────────────────┐ │
│  │ Unified Recall (External Memory)      │ │
│  └────────────────────────────────────────┘ │
│                                              │
│  ┌────────────────────────────────────────┐ │
│  │ Data Sources (Documents, APIs)        │ │
│  └────────────────────────────────────────┘ │
│                                              │
│  ┌────────────────────────────────────────┐ │
│  │ Sleep-time Agent (Background)         │ │
│  │  - Memory Reorganization              │ │
│  │  - Knowledge Consolidation            │ │
│  └────────────────────────────────────────┘ │
└──────────────────────────────────────────────┘
```

### Core Concepts

**1. Core Memory (In-Context)**

- Always visible in context window
- Agent can edit via memory tools
- Limited by context window size
- Organized in blocks (e.g., "About User", "About Task")

**2. Memory Blocks**

- Templatable (initial state for new agents)
- Simulated (sandbox for testing)
- Agent-specific (deployed instances)

**3. Memory Management Tools**

```python
# Agent-callable tools
memory_insert()       # Add to memory block
memory_replace()      # Update memory content
memory_rethink()      # Reorganize memory structure
memory_finish_edits() # Commit memory changes

# Deprecated (v1 compatibility)
core_memory_replace()
core_memory_append()
```

**4. Unified Recall**

- External storage beyond context window
- Semantic search for retrieval
- Auto-summarization for long contexts

**5. Sleep-time Agent**

- Background process for memory consolidation
- Merges similar memories
- Optimizes memory structure
- Runs when main agent idle

### Example Usage

```python
from letta import Agent

# Initialize agent with memory
agent = Agent(
    memory_backend='redis',
    memory_config={
        'host': 'localhost',
        'port': 6379
    }
)

# Agent automatically manages core memory
agent.run("Remember that I prefer TypeScript for new projects")

# Retrieve context
context = agent.get_context()

# Manual memory update (if needed)
agent.update_memory("preferences", "User prefers TypeScript")
```

### API Endpoints

```http
# Core Memory Management
GET /api/v1/agents/core-memory/retrieve
PUT /api/v1/agents/core-memory/update

# Context Window
GET /api-reference/agents/context/retrieve

# Memory Blocks
GET /api/v1/agents/{id}/memory-blocks
POST /api/v1/agents/{id}/memory-blocks
```

### Deployment

**Cloud (Managed):**

- Sign up at https://app.letta.com
- API key based access
- No infrastructure management

**Self-Hosted:**

```bash
pip install letta
letta server start --port 8080
```

---

## 🔄 Hybrid Approach for FRIDAY

**Recommendation:** Combine Git + Redis Agent Memory Server

### Architecture

```
┌─────────────────────────────────────────────────────┐
│                   FRIDAY Agent                       │
└────────────┬────────────────────────────────────────┘
             │
      ┌──────┴────────┐
      │               │
 Git Memory      Redis Memory
 (Structured)    (Semantic)
      │               │
      │               │
┌─────▼────────┐ ┌───▼──────────────────┐
│ .github/     │ │ Redis Agent Memory   │
│ memory/      │ │ Server               │
│              │ │                      │
│ - INDEX.md   │ │ - Working Memory     │
│ - current-   │ │ - Long-Term Memory   │
│   state.md   │ │ - Semantic Search    │
│ - implemen-  │ │ - Recency Ranking    │
│   tations/   │ │                      │
│ - decisions/ │ │                      │
│ - issues/    │ │                      │
└──────────────┘ └──────────────────────┘
      │                     │
      │                     │
Version Control      Fast Retrieval
Team Visible         User Preferences
Audit Trail          Cross-Session Context
```

### Responsibility Split

| Memory Type                  | Storage                  | Use Case                                    |
| ---------------------------- | ------------------------ | ------------------------------------------- |
| **Architecture Decisions**   | Git (`decisions/`)       | Team-visible, permanent, version-controlled |
| **Implementation Summaries** | Git (`implementations/`) | Documentation, lessons learned, references  |
| **Known Issues**             | Git (`issues/`)          | Bug tracking, troubleshooting guides        |
| **Project Status**           | Git (`current-state.md`) | Current features, focus, statistics         |
| **User Preferences**         | Redis (semantic)         | "User prefers concise responses"            |
| **Session Context**          | Redis (working memory)   | Current conversation state                  |
| **Quick Notes**              | Redis (episodic)         | Temporary observations, progress tracking   |
| **Cross-Session Patterns**   | Redis (long-term)        | Recurring issues, common workflows          |

### Implementation Steps

**1. Setup Redis Agent Memory Server**

```bash
# Clone and run
git clone https://github.com/redis/agent-memory-server.git
cd agent-memory-server
docker-compose up -d

# Verify
curl http://localhost:8000/health
```

**2. Install Python Client (for FRIDAY scripts)**

```bash
pip install agent-memory-client
```

**3. Create FRIDAY Memory Adapter**

```python
# .github/scripts/friday-memory-adapter.py
import asyncio
from agent_memory_client import create_memory_client, ClientMemoryRecord, MemoryTypeEnum
from pathlib import Path
import json

class FridayMemoryAdapter:
    def __init__(self, redis_url="http://localhost:8000", git_memory_path=".github/memory/"):
        self.git_path = Path(git_memory_path)
        self.redis_client = None
        self.redis_url = redis_url

    async def init(self):
        """Initialize Redis client"""
        self.redis_client = await create_memory_client(
            base_url=self.redis_url,
            default_namespace="friday"
        )

    async def close(self):
        """Cleanup"""
        if self.redis_client:
            await self.redis_client.close()

    # Git Memory (Structured, Permanent)
    def read_git_memory(self, category="INDEX"):
        """Read from Git memory files"""
        file_path = self.git_path / f"{category}.md"
        if file_path.exists():
            return file_path.read_text()
        return None

    def write_git_memory(self, category, content):
        """Write to Git memory files"""
        file_path = self.git_path / f"{category}.md"
        file_path.write_text(content)

    # Redis Memory (Semantic, Fast Retrieval)
    async def store_preference(self, user_id, preference_text, topics=None):
        """Store user preference in Redis"""
        memory = ClientMemoryRecord(
            text=preference_text,
            memory_type=MemoryTypeEnum.SEMANTIC,
            topics=topics or ["preferences"],
            user_id=user_id
        )
        await self.redis_client.create_long_term_memory([memory])

    async def search_context(self, query, user_id=None, limit=10):
        """Search relevant context from Redis"""
        results = await self.redis_client.search_long_term_memory(
            text=query,
            user_id=user_id,
            limit=limit
        )
        return results.memories

    # Hybrid: Combine Both
    async def get_full_context(self, user_id, query):
        """Retrieve complete context (Git + Redis)"""
        # 1. Git memory (structured docs)
        git_context = {
            "index": self.read_git_memory("INDEX"),
            "current_state": self.read_git_memory("current-state"),
        }

        # 2. Redis memory (semantic search)
        redis_memories = await self.search_context(query, user_id, limit=5)

        return {
            "structured": git_context,
            "semantic": [{"text": m.text, "distance": m.dist} for m in redis_memories]
        }

    async def log_session_progress(self, session_id, summary, user_id=None):
        """Log progress to both systems"""
        # Redis: quick episodic note
        episodic = ClientMemoryRecord(
            text=summary,
            memory_type=MemoryTypeEnum.EPISODIC,
            topics=["progress", "session"],
            user_id=user_id
        )
        await self.redis_client.create_long_term_memory([episodic])

        # Git: structured implementation summary (if significant)
        # ... (delegate to manual process or template)

# Usage
async def main():
    adapter = FridayMemoryAdapter()
    await adapter.init()

    try:
        # Store user preference
        await adapter.store_preference(
            user_id="dev_123",
            preference_text="User prefers concise bullet-point responses",
            topics=["communication", "style"]
        )

        # Search context for question
        context = await adapter.get_full_context(
            user_id="dev_123",
            query="How should I respond to user questions?"
        )

        print("Git Context:", context["structured"]["index"][:100])
        print("Redis Memories:", context["semantic"])

    finally:
        await adapter.close()

if __name__ == "__main__":
    asyncio.run(main())
```

**4. Update `.env.example`**

```bash
# Redis Agent Memory (optional)
REDIS_MEMORY_URL=http://localhost:8000
REDIS_MEMORY_ENABLE=false  # Set true to use hybrid mode
```

**5. Update `copilot-instructions.md`**

```markdown
## Memory Protocol (Enhanced - Hybrid Mode)

**At session start:**

1. Load semantic context from Redis (if enabled)
2. Read `.github/memory/INDEX.md` (structured)
3. Combine both for comprehensive context

**During work:**

- Update Redis with preferences, quick notes, session context
- Update Git memory with structured docs (implementations, decisions)

**After completion:**

- Redis: Session summary (episodic memory)
- Git: Implementation doc (if significant)
```

---

## 💰 Cost Analysis

### Redis Agent Memory Server

**Infrastructure:**

- Docker container: Free (self-host)
- Redis instance: Free (docker) or $0.003/hr (Redis Cloud)
- Server: $5-20/month (DigitalOcean/Hetzner VPS)

**API Costs:**

- OpenAI embeddings: ~$0.0001 per 1K tokens
- Vector search: Free (Redis native)

**Estimated Monthly:** $5-25 (self-hosted) or $50-100 (managed Redis Cloud)

### Letta

**Cloud:**

- Free tier: Limited agents & memory
- Pro: $20-50/month (estimated)
- Enterprise: Custom pricing

**Self-Hosted:**

- Server: $10-30/month
- Database: $5-20/month
- LLM API: Variable (OpenAI/Anthropic)

**Estimated Monthly:** $15-100+

### Git Memory (Current FRIDAY)

**Cost:** $0 (completely free)

**Limitations:**

- No semantic search
- Manual organization required
- Slower retrieval for large repos

---

## 🎯 Recommendation for FRIDAY

### Phase 1: Keep Git Memory (Now)

- ✅ Free, version controlled, team visible
- ✅ Works great for structured docs
- ✅ No external dependencies

### Phase 2: Add Redis Memory (Optional Enhancement)

- Add when project needs:
  - Multi-user preference tracking
  - Fast semantic search across sessions
  - Automatic context retrieval
  - Recency-aware memory ranking

### Phase 3: Letta (Future Consideration)

- Consider if:
  - Need managed solution
  - Want advanced context optimization
  - Budget allows $50+/month

---

## 📚 Resources

**Redis Agent Memory Server:**

- GitHub: https://github.com/redis/agent-memory-server
- Docs: https://github.com/redis/agent-memory-server/tree/main/docs
- Examples: https://github.com/redis/agent-memory-server/tree/main/examples

**Letta (MemGPT):**

- Website: https://www.letta.com
- Docs: https://docs.letta.com
- GitHub: https://github.com/letta-ai/letta

**FRIDAY Current Memory:**

- Protocol: `.github/instructions/memory.instructions.md`
- Implementation: `docs/AI_AGENT_MEMORY_IMPLEMENTATION.md`

---

## 🚀 Quick Start (Redis Memory for FRIDAY)

```bash
# 1. Start Redis Agent Memory Server
git clone https://github.com/redis/agent-memory-server.git
cd agent-memory-server
docker-compose up -d

# 2. Test connection
curl http://localhost:8000/health

# 3. Install Python client (for scripts)
pip install agent-memory-client

# 4. Create adapter script
cp .github/scripts/friday-memory-adapter.py.example .github/scripts/friday-memory-adapter.py

# 5. Configure
echo "REDIS_MEMORY_URL=http://localhost:8000" >> .env
echo "REDIS_MEMORY_ENABLE=true" >> .env

# 6. Test hybrid memory
python .github/scripts/friday-memory-adapter.py
```

---

**Conclusion:** Redis Agent Memory Server is the most practical upgrade for FRIDAY - self-hosted,
free, powerful semantic search, and complements existing Git memory perfectly.
