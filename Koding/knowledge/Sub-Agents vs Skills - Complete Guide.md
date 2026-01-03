---
title: Sub-Agents vs Skills - Complete Guide
type: technical-guide
created: 2026-01-02T21:00:00
tags:
  - sub-agents
  - skills
  - claude-code
  - context-management
  - orchestration
---

# Sub-Agents vs Skills - Odgovori na Pitanja

## Pitanja:
1. Da li sub-agenti imaju svoj context window?
2. Možemo li napraviti custom sub-agente?
3. Spawn agents vs Skills - koji su bolji?

---

## 1. Context Window Isolation - DA! ✅

### Kako Radi:

**Svaki sub-agent ima POTPUNO ODVOJEN context window!**

```
Orchestrator (Main Agent)
├── Context: 200,000 tokens
├── Conversation: High-level strategy, decisions
└── Ne vidi: Details iz sub-agent contextova

Code Sub-Agent (spawned via Task)
├── Context: 200,000 tokens (NOVI, PRAZAN)
├── Conversation: Samo coding task
└── Ne vidi: Orchestrator conversation

Research Sub-Agent (spawned via Task)
├── Context: 200,000 tokens (NOVI, PRAZAN)
├── Conversation: Samo research task
└── Ne vidi: Ostali sub-agenti ili orchestrator
```

### Key Points:

#### ✅ **Isolation Benefits:**
- **No context pollution** - Code details ne zagađuju orchestrator thinking
- **Parallel execution** - Svi sub-agenti rade istovremeno
- **Fresh context** - Svaki sub-agent počinje sa 0 tokena
- **Predictable** - Nema spillover-a između agenata

#### ⚠️ **Important Constraint:**
> "Subagents cannot spawn other subagents"

**Znači:**
```
Orchestrator → Code Sub-Agent ✅
Code Sub-Agent → Another Sub-Agent ❌
```

**No infinite nesting!**

---

## 2. Možemo li Napraviti Custom Sub-Agente? - DA! ✅

### Dve Metode:

#### **Metoda A: Built-in Sub-Agents** (Claude Code)

Claude Code već ima ugrađene sub-agent tipove:

```javascript
// Via Task tool
{
  name: "Task",
  description: "Spawn specialized sub-agent",
  input_schema: {
    subagent_type: "general-purpose" | "Explore" | "Plan"
  }
}
```

**Built-in tipovi:**
1. **general-purpose** - Opšti coding i research zadaci
2. **Explore** - Codebase exploration i analiza
3. **Plan** - Arhitektonsko planiranje

**Karakteristike:**
- ✅ Ready to use
- ✅ Optimized prompts
- ❌ Ne možeš customize system prompt
- ❌ Fixed tool set

---

#### **Metoda B: Custom Sub-Agents** (MOŽEŠ NAPRAVITI!)

**DVA načina:**

##### **B1) Custom Sub-Agent via Agent SDK**

```javascript
// custom-code-agent.js
import Anthropic from '@anthropic-ai/sdk';

export async function spawnCodeAgent(task) {
  const client = new Anthropic({
    apiKey: process.env.ANTHROPIC_API_KEY
  });

  const response = await client.messages.create({
    model: 'claude-sonnet-4.5',
    max_tokens: 8096,

    // CUSTOM SYSTEM PROMPT!
    system: `
You are a SPECIALIZED CODE AGENT.

Your ONLY job: Write clean, tested code.

Rules:
- Focus solely on implementation
- Write tests
- Follow project conventions
- Report back results concisely
    `,

    // CUSTOM TOOLS!
    tools: [
      { name: "Write", /* ... */ },
      { name: "Edit", /* ... */ },
      { name: "Bash", /* ... */ },
      { name: "Read", /* ... */ },
    ],

    messages: [
      { role: 'user', content: task }
    ]
  });

  return response;
}
```

**Karakteristike:**
- ✅ Full control nad system prompt
- ✅ Custom tool set
- ✅ Isolated context (200k tokens)
- ⚠️ Moraš sam implementirati tools

##### **B2) Custom Sub-Agent via Skills**

```bash
# .claude/skills/code-specialist/
├── skill.json              # Metadata
├── system-prompt.md        # Custom prompt
├── tools/                  # Custom tools (opciono)
└── resources/              # Supporting files
```

**skill.json:**
```json
{
  "name": "code-specialist",
  "description": "Specialized coding agent for complex implementations",
  "auto_invoke": true,
  "subagent": true,
  "system_prompt": "system-prompt.md",
  "tools": ["Write", "Edit", "Bash", "Read"]
}
```

**Karakteristike:**
- ✅ Easier setup (folder-based)
- ✅ Auto-invoked based on description
- ✅ Reusable across projects
- ✅ Version controlled (git)
- ⚠️ Mora biti compatible sa Claude Code

---

## 3. Skills vs Sub-Agents - Koji su Bolji?

### TL;DR: **KOMPLEMENTARNI, ne konkurentni!**

```
Skills     = "Knowledge & Capabilities"
Sub-Agents = "Independent Workers"
```

---

### **Skills - Šta su i kada koristiti?**

#### Definicija:
> "Skills are **folders containing instructions, scripts, and resources** that Claude discovers and loads dynamically when relevant to a task."

#### Karakteristike:
- **Auto-invoked** - Claude automatic loads based on description
- **Context providers** - Dodaju knowledge, ne izvršavaju samostalno
- **Portable** - Rade u Claude Code, Web, Mobile, API
- **Progressive disclosure** - Load samo kad treba

#### Primer Skill-a:
```bash
.claude/skills/database-expert/
├── skill.json
├── system-prompt.md        # "You know PostgreSQL best practices"
├── examples/               # SQL query examples
└── schemas/                # Database schema docs
```

**Kako radi:**
```
User: "Optimize this database query"

Claude (automatski):
1. Sees "database query" in message
2. Matches sa "database-expert" skill description
3. Loads skill context
4. Primenjuje znanje na problem
5. Odgovara sa PostgreSQL expertise
```

**Use Cases:**
- ✅ Domain expertise (SQL, DevOps, Security)
- ✅ Project conventions (coding style, naming)
- ✅ Supporting files (schemas, examples)
- ✅ Reusable knowledge across projects

---

### **Sub-Agents - Šta su i kada koristiti?**

#### Definicija:
> "Sub-agents are **specialized AI assistants with their own context windows, custom system prompts, and specific tool permissions**."

#### Karakteristike:
- **Independent execution** - Rade kao separate process
- **Isolated context** - Svoj 200k context window
- **Task-specific** - Fokusirani na jedan konkretan task
- **Parallel capable** - Više sub-agenata istovremeno

#### Primer Sub-Agenta:
```javascript
// Orchestrator spawns sub-agent
await spawnSubAgent({
  type: 'code-agent',
  task: 'Implement user authentication with JWT',
  context: {
    framework: 'Express.js',
    database: 'PostgreSQL'
  }
});

// Sub-agent radi NEZAVISNO:
// - Read existing code
// - Write new files
// - Run tests
// - Report results
```

**Use Cases:**
- ✅ Heavy implementation work (ne zagađuje main context)
- ✅ Parallel tasks (3 sub-agenta rade istovremeno)
- ✅ Isolated failures (sub-agent error ne krashi orchestrator)
- ✅ Specialized tooling (jedan sub-agent = subset of tools)

---

### **Comparison Table:**

| Feature | Skills | Sub-Agents |
|---------|--------|------------|
| **Context** | Share sa main agent | Isolated (200k svaki) |
| **Execution** | Passive (knowledge) | Active (izvršavaju tasks) |
| **Invocation** | Auto (based on description) | Manual (via Task tool) |
| **Parallel** | N/A (knowledge load) | ✅ Multiple simultaneous |
| **Portability** | ✅ Cross-platform | ❌ Claude Code only |
| **Custom System Prompt** | ✅ Yes | ✅ Yes |
| **Tools** | Share sa agent | ✅ Custom subset |
| **Use Case** | Add expertise | Delegate execution |

---

## 4. Hybrid Approach - BEST PRACTICE 🏆

### Kombinuj Skills + Sub-Agents!

```
Orchestrator
├── Skills:
│   ├── business-strategy (auto-loaded expertise)
│   ├── data-analysis (analytics knowledge)
│   └── project-conventions (coding standards)
│
└── Sub-Agents (spawned on demand):
    ├── Code Agent (implements features)
    ├── Research Agent (deep research tasks)
    └── Doc Agent (documentation updates)
```

### Primer Workflow:

```markdown
User: "Add payment processing to the app"

Orchestrator (sa Skills loaded):
1. **Skill: business-strategy** daje context:
   - Payment providers comparison
   - Security best practices
   - Compliance requirements

2. Orchestrator analyzes i odlučuje:
   - Preporučuje Stripe integration
   - Identifies security risks
   - Plans implementation approach

3. **Spawns Code Sub-Agent**:
   Task: "Implement Stripe payment integration"
   Context: Business requirements, security standards

4. Code Sub-Agent (isolated context):
   - Reads Stripe docs
   - Implements payment flow
   - Writes tests
   - Returns summary

5. Orchestrator synthesizes:
   - Reviews implementation
   - Updates business docs
   - Reports to user
```

**Benefits:**
- ✅ Orchestrator has expertise (Skills)
- ✅ Heavy lifting delegated (Sub-Agents)
- ✅ Clean context separation
- ✅ Parallel execution capable

---

## 5. Kako Napraviti Custom Sub-Agent - Praktično

### Setup: Custom "Documentation Agent"

#### **Fajl Struktura:**
```bash
your-project/
├── .claude/
│   ├── skills/
│   │   └── doc-specialist/
│   │       ├── skill.json
│   │       ├── system-prompt.md
│   │       └── templates/
│   │           └── api-doc-template.md
│   │
│   └── hooks/
│       └── orchestrator-delegator.js
```

#### **skill.json:**
```json
{
  "name": "doc-specialist",
  "version": "1.0.0",
  "description": "Specialized agent for creating and maintaining technical documentation",
  "subagent": true,
  "auto_invoke": false,
  "system_prompt": "system-prompt.md",
  "tools": ["Read", "Write", "Glob", "Grep"],
  "parameters": {
    "output_format": "markdown",
    "style_guide": "Google Developer Documentation Style"
  }
}
```

#### **system-prompt.md:**
```markdown
# Documentation Specialist Agent

You are a specialized documentation agent.

## Your ONLY Responsibilities:
1. Create clear, concise technical documentation
2. Update existing docs when code changes
3. Ensure consistency with style guide
4. Generate API references from code

## Rules:
- Follow Google Developer Documentation Style Guide
- Use active voice
- Include code examples
- Keep it concise
- Link related docs

## Output Format:
Always structure docs as:
1. Overview
2. Quick Start
3. Detailed Guide
4. API Reference (if applicable)
5. Examples
6. Troubleshooting

Report back: File paths created/updated + summary of changes.
```

#### **orchestrator-delegator.js (Hook):**
```javascript
export default {
  name: 'orchestrator-delegator',

  async beforeToolUse({ toolName, toolInput }) {
    // Intercept kada orchestrator bi koristio Write tool
    if (toolName === 'Write' && isDocumentation(toolInput.file_path)) {

      // DELEGATE to doc-specialist instead!
      return {
        toolName: 'Task',
        toolInput: {
          subagent_type: 'doc-specialist',
          description: 'Document creation task',
          prompt: `Create documentation: ${toolInput.file_path}\n\nContent guidelines: ${toolInput.content}`
        }
      };
    }

    // Other tools proceed normally
    return { toolName, toolInput };
  }
};

function isDocumentation(filePath) {
  return /\.(md|mdx|rst)$/i.test(filePath) ||
         filePath.includes('/docs/');
}
```

**Rezultat:**
```
User: "Document the new API endpoints"

Orchestrator:
- Vidi da treba dokumentacija
- Automatic delegate to doc-specialist sub-agent

Doc-Specialist Sub-Agent (isolated context):
- Reads API code
- Generates documentation
- Follows style guide
- Creates markdown files
- Reports back summary

Orchestrator:
- Receives summary
- Updates project status
- Informs user
```

---

## 6. Context Window Math - Zašto je Isolation Kritična?

### Scenario BEZ Sub-Agenata:

```
Main Agent Context (200k tokens):
├── Orchestrator thinking: 5,000 tokens
├── Business conversation: 10,000 tokens
├── Code implementation details: 50,000 tokens  ← POLLUTION!
├── Documentation drafts: 20,000 tokens         ← POLLUTION!
├── Research notes: 30,000 tokens               ← POLLUTION!
└── Available: 85,000 tokens (42.5% used!)
```

**Problem:**
- Orchestrator thinking zagađen technical details-ima
- Nema prostora za strategic analysis
- Slow responses (više context = duže processing)

### Scenario SA Sub-Agentima:

```
Orchestrator Context (200k tokens):
├── Strategic thinking: 5,000 tokens
├── Business conversation: 10,000 tokens
├── Delegation instructions: 3,000 tokens
├── Sub-agent summaries: 5,000 tokens
└── Available: 177,000 tokens (11.5% used!)

Code Sub-Agent Context (200k tokens):
├── Implementation work: 50,000 tokens
└── Available: 150,000 tokens

Doc Sub-Agent Context (200k tokens):
├── Documentation: 20,000 tokens
└── Available: 180,000 tokens
```

**Benefits:**
- ✅ Orchestrator context CLEAN
- ✅ Više prostora za strategic thinking
- ✅ Faster responses
- ✅ Sub-agenti rade parallel

---

## 7. Finalna Preporuka za WUFF Orchestrator

### Arhitektura:

```
WUFF Orchestrator (Main Agent)
├── Skills (Auto-Loaded Expertise):
│   ├── business-strategy.skill
│   ├── data-analytics.skill
│   ├── project-conventions.skill
│   └── security-best-practices.skill
│
├── Custom Sub-Agents (Spawned on Demand):
│   ├── code-agent.skill         ← Heavy coding work
│   ├── doc-agent.skill          ← Documentation
│   ├── research-agent.skill     ← Deep research
│   └── memory-agent.skill       ← Basic Memory CRUD
│
└── Hooks:
    └── orchestrator-delegator.js ← Auto-delegation logic
```

### Workflow:

1. **User Request** → Orchestrator
2. **Skills auto-load** → Add relevant expertise
3. **Orchestrator analyzes** → With business/strategy context
4. **Delegates to Sub-Agents** → Heavy execution work
5. **Sub-Agents work in parallel** → Isolated contexts
6. **Orchestrator synthesizes** → High-level summary
7. **Reports to user** → Strategic insights

---

## 8. Spawn Agents vs Skills - Final Verdict

### **Use Skills when:**
- ✅ Teaching expertise (SQL, DevOps, Security)
- ✅ Project conventions (sempre applicable)
- ✅ Supporting resources (schemas, examples)
- ✅ Auto-invoke patterns (relevance-based)

### **Use Sub-Agents when:**
- ✅ Heavy implementation work
- ✅ Need context isolation
- ✅ Parallel execution required
- ✅ Task-specific tool permissions

### **Use BOTH when:**
- 🏆 **Building complex orchestrator system**
- 🏆 Skills = Knowledge
- 🏆 Sub-Agents = Execution
- 🏆 **BEST PRACTICE!**

---

## Sources & References

### Official Documentation:
- [Subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
- [Subagents in the SDK - Claude Docs](https://platform.claude.com/docs/en/agent-sdk/subagents)
- [Skills Explained - Claude Blog](https://claude.com/blog/skills-explained)
- [Equipping Agents with Skills - Anthropic](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

### Guides & Tutorials:
- [Context Management with Subagents](https://www.richsnapp.com/article/2025/10-05-context-management-with-subagents-in-claude-code)
- [Claude Code Customization Guide](https://alexop.dev/posts/claude-code-customization-guide-claudemd-skills-subagents/)
- [Understanding Claude Code Full Stack](https://alexop.dev/posts/understanding-claude-code-full-stack/)
- [How Sub-Agents Work - Complete Guide](https://medium.com/@kinjal01radadiya/how-sub-agents-work-in-claude-code-a-complete-guide-bafc66bbaf70)

### Technical Articles:
- [Claude Code Subagents Enable Modular Workflows - InfoQ](https://www.infoq.com/news/2025/08/claude-code-subagents/)
- [Claude Code Frameworks & Sub-Agents Guide](https://www.medianeth.dev/blog/claude-code-frameworks-subagents-2025)
- [Skills vs Commands vs Subagents](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)

---

**Kreirao**: Claude Sonnet 4.5
**Datum**: 2026-01-02
**Za**: WUFF Orchestrator Architecture
