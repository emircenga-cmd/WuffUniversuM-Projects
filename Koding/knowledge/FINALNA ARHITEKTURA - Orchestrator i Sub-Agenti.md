---
title: FINALNA ARHITEKTURA - Orchestrator i Sub-Agenti
type: final-architecture
created: 2026-01-02T21:45:00
tags:
  - architecture
  - final-design
  - orchestrator
  - sub-agents
  - basic-memory
---

# FINALNA ARHITEKTURA - Razjašnjenje

## Tvoje Pitanje (Kritično!):

> "Da li se sub-agenti prave na isti način kao orchestrator sa hooks? Ili orkestrator samo spawn kao trajne subagente? Mogu li biti povezani sa Basic Memory?"

---

## ODGOVOR - 3 Nivoa Setup-a:

### 1. **ORCHESTRATOR** (Main Agent)
### 2. **SUB-AGENTI** (Spawned Agents)
### 3. **BASIC MEMORY** (Shared State)

Hajde da razjasnim SVE!

---

## 1. ORCHESTRATOR Setup - Hook Modifikacija

### Šta JE Orchestrator?

**Orchestrator = MODIFIKOVAN Claude Code agent**

```
NE pravimo novog agenta!
Modifikujemo postojećeg Claude Code agenta (mene!)
Via hooks u projektu
```

### Setup:

```bash
your-project/
├── .claude/
│   └── hooks/
│       └── orchestrator-mode.js  # ← Menja MOJ system prompt
└── CLAUDE.md                      # ← Project context
```

### orchestrator-mode.js:

```javascript
// Ovo MODIFIKUJE mene (Claude Code agenta)
export default {
  async beforeMessage({ systemPrompt }) {
    return {
      systemPrompt: `
${systemPrompt}  // ← Moj original prompt

---
# ORCHESTRATOR MODE
Sada razmišljaš kao business partner...
Delegiraj sub-agentima...
      `
    };
  }
};
```

**Rezultat:**
- Ja (Claude Code) sam sada **orchestrator**
- Samo u OVOM projektu
- Ostali projekti = normalan Claude Code

---

## 2. SUB-AGENTI Setup - DVA Načina!

### ❓ **Koje Sub-Agente Treba Napraviti?**

**KRITIČNO PITANJE: Da li sub-agenti IMAJU HOOKS?**

**ODGOVOR: ZAVISI OD METODE!**

---

### **METODA A: Agent Files (`.claude/agents/`)** ⭐ RECOMMENDED

#### Šta JE ovo?

**Definicija permanentnih sub-agenata koje orchestrator SPAWN-uje**

```bash
your-project/
└── .claude/
    └── agents/
        ├── business-analyst/
        │   └── agent.md        # ← SUB-AGENT DEFINITION
        └── research-specialist/
            └── agent.md
```

#### `agent.md` Format:

```markdown
---
name: business-analyst
description: Business analysis
model: claude-sonnet-4.5
tools: [Read, WebSearch]
---

# Business Analyst Sub-Agent

[System prompt ZA SUB-AGENTA]
```

#### Kako Radi:

```
1. Orchestrator (ti) → Task tool
2. Claude Code → Reads .claude/agents/business-analyst/agent.md
3. Claude Code → Spawns NEW Claude instance
4. Sub-agent → Gets system prompt IZ agent.md
5. Sub-agent → Runs task
6. Sub-agent → Returns result
7. Orchestrator → Synthesizes
```

#### ❌ **Sub-Agent NEMA hooks!**

**Zašto?**
- Sub-agent je SPAWNED instance
- Ne učitava hooks iz projekta
- Dobija samo ono što je u `agent.md`

**Šta Sub-Agent Dobija:**
- ✅ System prompt iz `agent.md`
- ✅ Tools iz `tools: []` array
- ✅ Model iz `model: claude-sonnet-4.5`
- ❌ **NE dobija hooks**
- ❌ **NE dobija CLAUDE.md**
- ❌ **NE učitava project config**

---

### **METODA B: Skill-Based Sub-Agents** (Alternative)

#### Šta JE ovo?

**Skills koje se mogu koristiti i kao sub-agenti**

```bash
your-project/
└── .claude/
    └── skills/
        └── business-expert/
            └── skill.md
```

#### skill.md Format:

```markdown
---
name: business-expert
description: Business expertise
subagent: true           # ← Može biti spawned kao sub-agent
---

# Business Expert Skill

[Instructions...]
```

#### Razlika Skills vs Agents:

| Feature | Skills | Agents (.claude/agents/) |
|---------|--------|--------------------------|
| **Auto-load** | ✅ Always loaded | ❌ Only when spawned |
| **As Sub-Agent** | ✅ If `subagent: true` | ✅ Always |
| **Portable** | ✅ Cross-platform | ❌ Claude Code only |
| **Hooks** | ❌ No | ❌ No |

---

## 3. TRAJNI Sub-Agenti - Šta to Znači?

### ❓ "Trajni za projekat ili više projekata?"

**ODGOVOR:**

#### **Per-Project (Default):**
```bash
project-A/
└── .claude/agents/
    └── business-analyst/   # ← Samo za project-A
```

#### **Global (Svi projekti):**
```bash
~/.config/claude-code/agents/
└── business-analyst/       # ← Za SVE projekte
```

**Preporuka za WUFF:**
- **Project-specific** - Svaki projekat može imati custom sub-agente
- **Global shared** - Common sub-agenti (research, doc writer)

---

## 4. Basic Memory Integration - KO JE POVEZAN?

### ❓ "Mogu li sub-agenti biti povezani sa Basic Memory?"

**ODGOVOR: DA, ali zavisi kako!**

⚠️ **EXPERIMENTAL PATTERN** - Tool syntax needs hands-on verification

---

### **Scenario A: Via MCP Tools**

```markdown
---
name: memory-manager
description: Manages knowledge graph memory
tools:
  - mcp__memory__read_graph       # ✅ Verified from Anthropic docs
  - mcp__memory__search_nodes     # ✅ Verified from Anthropic docs
  - mcp__memory__create_entities  # ✅ Verified from Anthropic docs
  - mcp__memory__add_observations # ✅ Verified from Anthropic docs
  - mcp__memory__create_relations # ✅ Verified from Anthropic docs
---

# Memory Manager Sub-Agent

You manage persistent memory using knowledge graph structure.

## Verified MCP Memory Tools Available:
- mcp__memory__read_graph: Read entire knowledge graph
- mcp__memory__search_nodes: Search for specific entities/observations
- mcp__memory__create_entities: Create new knowledge entities
- mcp__memory__add_observations: Add observations to existing entities
- mcp__memory__create_relations: Link entities together

**Important**: Tool names use the format `mcp__<server_name>__<tool_name>` where `memory` is the server name from `.mcp.json`

When spawned:
1. Use mcp__memory__search_nodes to read current state
2. Perform task
3. Use mcp__memory__add_observations or mcp__memory__create_entities to update knowledge
```

**Kako radi (THEORETICAL - needs testing):**
```javascript
// Orchestrator spawns
await Task({
  name: 'memory-manager',
  prompt: 'Store business analysis results in knowledge graph'
});

// Sub-agent interno (based on MCP protocol spec):
// Search for existing project entity
const projectNode = await memory_search_nodes({
  query: 'current project context'
});

// Add observation to project
await memory_add_observations({
  entityName: projectNode.name,
  observations: ['European market analysis completed on 2026-01-03']
});
```

**Requirements:**
- ✅ MCP memory server running: `@modelcontextprotocol/server-memory`
- ✅ Sub-agent has MCP tools listed in `tools: []`
- ⚠️ Tool calling syntax needs practical verification
- 🔬 Namespace pattern (if needed) requires testing

**Verified Source**: [MCP Memory Server Docs](https://github.com/modelcontextprotocol/servers/tree/main/src/memory)

---

### **Scenario B: Via Orchestrator (Better!)** ⭐

```
Orchestrator (sa MCP access)
├── Reads Basic Memory
├── Passes context to sub-agent
├── Sub-agent works with context
└── Orchestrator writes results back to Basic Memory
```

**Workflow:**

```javascript
// 1. Orchestrator reads Basic Memory
const projectContext = await readBasicMemory('project://context');

// 2. Passes to sub-agent
const analysis = await Task({
  name: 'business-analyst',
  prompt: `
Context from Basic Memory:
${JSON.stringify(projectContext)}

Now analyze: European market expansion
  `
});

// 3. Orchestrator updates Basic Memory
await writeBasicMemory('project://context', {
  ...projectContext,
  lastAnalysis: analysis,
  timestamp: Date.now()
});
```

**Benefit:**
- ✅ Orchestrator = single source of truth
- ✅ Sub-agenti ne moraju znati za Basic Memory
- ✅ Cleaner separation of concerns

---

## 5. FINALNA ARHITEKTURA - Dijagram

```
┌────────────────────────────────────────────────────────┐
│ PROJECT ROOT                                           │
│                                                        │
│ ┌────────────────────────────────────────────────┐   │
│ │ .claude/                                       │   │
│ │                                                │   │
│ │ ├── hooks/                                     │   │
│ │ │   └── orchestrator-mode.js  ← Modifies MAIN │   │
│ │ │                                               │   │
│ │ ├── agents/                    ← SUB-AGENTS   │   │
│ │ │   ├── business-analyst/                      │   │
│ │ │   │   └── agent.md           (NO hooks!)     │   │
│ │ │   ├── research-specialist/                   │   │
│ │ │   │   └── agent.md           (NO hooks!)     │   │
│ │ │   └── memory-manager/                        │   │
│ │ │       └── agent.md           (MCP tools)     │   │
│ │ │                                               │   │
│ │ ├── settings.json              ← Config        │   │
│ │ └── commands/                  ← Slash cmds    │   │
│ │                                                │   │
│ └────────────────────────────────────────────────┘   │
│                                                        │
│ CLAUDE.md                         ← Project context   │
│                                                        │
└────────────────────────────────────────────────────────┘

RUNTIME FLOW:
═════════════

1. User: "Analyze market"

2. MAIN AGENT (Orchestrator - Modified by hook):
   ┌─────────────────────────────────────┐
   │ System Prompt: Original + Hook mod │
   │ Context: 200k tokens                │
   │ MCP: Connected to Basic Memory      │
   └─────────────────────────────────────┘
   │
   │ Reads Basic Memory
   │ Decides to delegate
   │
   ├─→ Spawns via Task tool ──────────────┐
   │                                       │
   ▼                                       ▼

3. SUB-AGENT #1:                  SUB-AGENT #2:
   ┌─────────────────────┐         ┌──────────────────┐
   │ business-analyst    │         │ research-spec.   │
   │ System: agent.md    │         │ System: agent.md │
   │ Context: 200k (new) │         │ Context: 200k    │
   │ NO hooks            │         │ NO hooks         │
   │ NO MCP (unless in   │         │ Has WebSearch    │
   │    tools: [])       │         │                  │
   └─────────────────────┘         └──────────────────┘
   │                                │
   │ Works independently            │ Works independently
   │                                │
   └────────┬───────────────────────┘
            │
            ▼

4. ORCHESTRATOR:
   ┌──────────────────────────────┐
   │ Receives results             │
   │ Synthesizes                  │
   │ Updates Basic Memory         │
   │ Responds to user             │
   └──────────────────────────────┘
```

---

## 6. Odgovori na Tvoja Pitanja - FINAL

### Q1: "Da li se sub-agenti prave na isti način kao orchestrator sa hooks?"

**ODGOVOR: NE!**

```
Orchestrator = Hook koji modifikuje Claude Code
Sub-Agenti  = agent.md fajlovi (definitions)

Orchestrator:
├── .claude/hooks/orchestrator-mode.js  ← Modifies MAIN agent
└── CLAUDE.md

Sub-Agenti:
└── .claude/agents/*/agent.md           ← Definitions, NO hooks
```

---

### Q2: "Ili orkestrator samo spawn kao trajne subagente?"

**ODGOVOR: DA, orchestrator spawn-uje!**

```
Sub-agenti = Definitions (.claude/agents/)
Orchestrator = Spawns them via Task tool

agent.md = "Blueprint" (recept)
Task tool = "Factory" (pravi instance)
Spawned agent = Actual running instance
```

**Trajni = Definitions uvek tu, instance spawn-uju po potrebi**

---

### Q3: "Da li za jedan projekat ili više projekata?"

**ODGOVOR: OBOJE!**

```bash
# Per-project (custom za projekat)
your-project/.claude/agents/

# Global (svi projekti)
~/.config/claude-code/agents/

# Orchestrator will find both!
```

---

### Q4: "Mogu li biti povezani sa Basic Memory?"

**ODGOVOR: DA, 2 načina!**

#### **Način 1: Direct MCP Access (Sub-Agent)**
```markdown
---
name: memory-manager
tools:
  - read_basic_memory
  - write_basic_memory
---
```

#### **Način 2: Via Orchestrator (Better!)** ⭐
```javascript
// Orchestrator:
const context = await readBasicMemory();
await Task({ name: 'analyst', prompt: context });
const result = ...;
await writeBasicMemory(result);
```

**Preporuka: Način 2**
- Orchestrator = source of truth
- Sub-agenti = workers, ne moraju znati za memory

---

## 7. Setup Koraci - TAČAN REDOSLED

### Korak 1: Kreiraj Projekat

```bash
mkdir wuff-orchestrator
cd wuff-orchestrator
```

---

### Korak 2: Setup Orchestrator (Main Agent Modification)

```bash
mkdir -p .claude/hooks

cat > .claude/hooks/orchestrator-mode.js << 'EOF'
export default {
  async beforeMessage({ systemPrompt, tools }) {
    const orchestratorPrompt = `
${systemPrompt}

---
# WUFF ORCHESTRATOR MODE

You are a business partner and coordinator.
Delegate to sub-agents via Task tool.
Think strategically, not tactically.
    `;

    const orchestratorTools = tools.filter(t =>
      !['Write', 'Edit'].includes(t.name)
    );

    return {
      systemPrompt: orchestratorPrompt,
      tools: orchestratorTools
    };
  }
};
EOF
```

---

### Korak 3: Setup Sub-Agenti (Definitions)

```bash
# Business Analyst
mkdir -p .claude/agents/business-analyst

cat > .claude/agents/business-analyst/agent.md << 'EOF'
---
name: business-analyst
description: Strategic business analysis and recommendations
model: claude-sonnet-4.5
tools: [Read, WebSearch, Grep]
permissionMode: ask
---

# Business Analyst Sub-Agent

You analyze business data and provide strategic insights.

Focus on:
- Market analysis
- Risk assessment
- Strategic recommendations

Output: Executive summary with actionable insights.
EOF

# Research Specialist
mkdir -p .claude/agents/research-specialist

cat > .claude/agents/research-specialist/agent.md << 'EOF'
---
name: research-specialist
description: Deep research and information synthesis
model: claude-sonnet-4.5
tools: [WebSearch, WebFetch, Read]
permissionMode: notify
---

# Research Specialist Sub-Agent

You conduct thorough research and synthesize findings.

Output: Structured report with sources.
EOF

# Memory Manager (with Basic Memory access)
mkdir -p .claude/agents/memory-manager

cat > .claude/agents/memory-manager/agent.md << 'EOF'
---
name: memory-manager
description: Manages project context in Basic Memory
model: claude-haiku
tools: [ReadMcpResource, WriteMcpResource]
permissionMode: auto
---

# Memory Manager Sub-Agent

You manage Basic Memory context.

Operations:
- Read current state
- Update with new info
- Maintain context history
EOF
```

---

### Korak 4: Config

```bash
cat > .claude/settings.json << 'EOF'
{
  "hooks": {
    "beforeMessage": ".claude/hooks/orchestrator-mode.js"
  },
  "model": "claude-opus-4.5",
  "thinking": {
    "enabled": true,
    "budget": "medium"
  }
}
EOF
```

---

### Korak 5: Project Context

```bash
cat > CLAUDE.md << 'EOF'
# WUFF Orchestrator Project

You are in ORCHESTRATOR mode for this project.

## Available Sub-Agents:
- business-analyst: Strategic analysis
- research-specialist: Deep research
- memory-manager: Basic Memory operations

## Workflow:
1. Think strategically
2. Delegate to sub-agents
3. Synthesize results
4. Provide recommendations
EOF
```

---

### Korak 6: Test

```bash
claude

> "What sub-agents are available?"

Expected: Lists business-analyst, research-specialist, memory-manager

> "Analyze SaaS market opportunity"

Expected:
- Orchestrator delegates to business-analyst
- Business analyst spawns with agent.md prompt
- Returns analysis
- Orchestrator synthesizes
```

---

## 8. Basic Memory Integration - Complete Flow

⚠️ **THEORETICAL PATTERN** - This is a conceptual example showing how orchestrator-managed memory COULD work. The exact tool calling syntax needs verification.

### Pattern 1: Theoretical (Needs Verification)

```javascript
// ORCHESTRATOR (Main Agent) - Has MCP access
// NOTE: Tool names and URI pattern are GUESSED, not verified

async function handleUserRequest(request) {
  // 1. Read context from memory (THEORETICAL syntax)
  const context = await readMcpResource({
    server: 'memory',
    uri: 'memory://wuff-project/context'  // ⚠️ URI pattern not verified
  });

  // 2. Decide which sub-agent to use
  const agentType = analyzeRequest(request);

  // 3. Spawn sub-agent with context
  const result = await Task({
    name: agentType,
    description: 'Market analysis',
    prompt: `
Project Context:
${JSON.stringify(context, null, 2)}

User Request: ${request}

Analyze and provide recommendations.
    `
  });

  // 4. Sub-agent works (NO memory access needed!)
  // Sub-agent just processes the context given

  // 5. Orchestrator updates memory (THEORETICAL syntax)
  await writeMcpResource({
    server: 'memory',
    uri: 'memory://wuff-project/context',  // ⚠️ URI pattern not verified
    content: {
      ...context,
      lastAnalysis: {
        timestamp: Date.now(),
        request: request,
        result: result,
        agent: agentType
      }
    }
  });

  // 6. Return to user
  return synthesize(result);
}
```

### Pattern 2: Verified MCP Tools (Recommended for Testing)

Based on verified MCP memory server tools:

```javascript
async function handleUserRequest(request) {
  // 1. Search for existing project context entity
  const contextNodes = await memory_search_nodes({
    query: 'wuff-project context'
  });

  let projectContext = contextNodes[0] || null;

  // 2. If no context exists, create entity
  if (!projectContext) {
    await memory_create_entities({
      entities: [{
        name: 'wuff-project',
        entityType: 'project',
        observations: ['Project context initialized']
      }]
    });
  }

  // 3. Decide which sub-agent to use
  const agentType = analyzeRequest(request);

  // 4. Spawn sub-agent with context
  const result = await Task({
    name: agentType,
    description: 'Market analysis',
    prompt: `
Project Context from Knowledge Graph:
${JSON.stringify(projectContext, null, 2)}

User Request: ${request}

Analyze and provide recommendations.
    `
  });

  // 5. Add observation to project entity
  await memory_add_observations({
    entityName: 'wuff-project',
    observations: [
      `Analysis completed: ${request}`,
      `Agent used: ${agentType}`,
      `Timestamp: ${new Date().toISOString()}`,
      `Key findings: ${result.summary}`
    ]
  });

  // 6. Return to user
  return synthesize(result);
}
```

**Verification Status:**
- ✅ Tool names verified from Anthropic docs
- ✅ In agent.md definition: Use `mcp__memory__create_entities` (with prefix)
- ✅ In code execution: Agent internally calls `memory_create_entities` (short name)
- ⚠️ Tool calling parameter syntax needs hands-on testing
- 🔬 Complete workflow needs practical validation

**Important Note on Tool Naming:**
- **In `.claude/agents/*/agent.md` tools list**: Use full prefix `mcp__memory__*`
- **In agent's code/prompts**: Agent sees and calls short names `memory_*`
- Claude Code handles the translation automatically

**Source**: [MCP Memory Server](https://github.com/modelcontextprotocol/servers/tree/main/src/memory) + [Anthropic Claude Code Docs](https://code.claude.com/docs/en/hooks.md#mcp-tool-naming)

**Key Insight:**
- ✅ **Orchestrator** = MCP access (reads/writes Basic Memory)
- ✅ **Sub-Agents** = Work with context passed to them
- ✅ Clean separation: Orchestrator manages state, sub-agents execute

---

## 9. Rezime - FINALNA ARHITEKTURA

### Slojevi:

```
┌─────────────────────────────────────────┐
│ BASIC MEMORY (MCP Server)               │
│ - Shared state across sessions          │
│ - Project context                        │
│ - Analysis history                       │
└─────────────────────────────────────────┘
                 ▲ ▼
┌─────────────────────────────────────────┐
│ ORCHESTRATOR (Modified Claude Code)     │
│ - Hook modifies system prompt           │
│ - Has MCP access                         │
│ - Coordinates sub-agents                 │
│ - Manages Basic Memory                   │
└─────────────────────────────────────────┘
         │
         ├─── Spawns ────────┬─────────┐
         │                   │         │
         ▼                   ▼         ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│ Business     │  │ Research     │  │ Memory       │
│ Analyst      │  │ Specialist   │  │ Manager      │
├──────────────┤  ├──────────────┤  ├──────────────┤
│ agent.md     │  │ agent.md     │  │ agent.md     │
│ NO hooks     │  │ NO hooks     │  │ MCP tools    │
│ NO MCP       │  │ NO MCP       │  │              │
│ (unless      │  │              │  │              │
│  specified)  │  │              │  │              │
└──────────────┘  └──────────────┘  └──────────────┘
```

### Odgovori FINAL:

1. **Orchestrator** = Hook u projektu (modifies Claude Code)
2. **Sub-Agenti** = agent.md definitions (NO hooks!)
3. **Trajni** = Definitions always there, spawn on demand
4. **Basic Memory** = Orchestrator manages, sub-agents use context

---

**Kreirao**: Claude Sonnet 4.5
**Datum**: 2026-01-02
**Status**: FINAL ARCHITECTURE DEFINED
