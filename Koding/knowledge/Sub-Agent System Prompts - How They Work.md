---
title: Sub-Agent System Prompts - How They Work
type: technical-deep-dive
created: 2026-01-02T21:15:00
tags:
  - sub-agents
  - system-prompts
  - architecture
  - claude-code
---

# Sub-Agent System Prompts - Odgovor na Pitanje

## Pitanje:
> Da li sub-agenti imaju onaj isti Antropic sys koji trebamo editovati, ili oni dolaze goli sa sys-om koji im da orchestrator?

---

## TL;DR Odgovor:

**Sub-agenti imaju SVE SVOJE, ODVOJENE system prompte!**

❌ **NE naslеđuju** glavni Claude Code system prompt
❌ **NE dolaze "goli"** - imaju optimized prompts za svoju ulogu
✅ **Dobijaju CUSTOM prompt** specifičan za njihov tip

---

## 1. Kako to Funkcioniše - Arhitektura

### Built-in Sub-Agents (Claude Code):

```
Main Agent (Orchestrator)
└── System Prompt: ~12,000 tokens (full Claude Code prompt)

Explore Sub-Agent (spawned via Task)
└── System Prompt: 516 tokens (ODVOJEN, optimized za exploration)

Plan Sub-Agent (spawned via Task)
└── System Prompt: 633 tokens (ODVOJEN, optimized za planning)

General-Purpose Sub-Agent (spawned via Task)
└── System Prompt: 294 tokens (ODVOJEN, minimal task execution)
```

### Token Counts (iz Piebald-AI research):

- **Explore agent**: **516 tokens** - "System prompt for the Explore subagent"
- **Plan agent**: **633 tokens** - "Enhanced prompt for the Plan subagent"
- **Task/General-Purpose agent**: **294 tokens** - "System prompt for Task tool subagent"

**vs.**

- **Main Claude Code agent**: **~12,000-15,000 tokens**

---

## 2. Zašto Odvojeni Prompts?

### Antropic Design Philosophy:

> "Individual custom agent system prompts are scoped precisely, **avoiding the inheritance of redundant context** from the delegating agent."

### Prednosti:

#### ✅ **Optimized za specifičnu ulogu**
```markdown
# Explore Agent Prompt (516 tokens):
"You are a fast, read-only codebase explorer.
Focus on finding files and patterns quickly.
Report findings concisely."

# vs.

# Main Agent Prompt (12,000 tokens):
"You are Claude Code, an agentic coding tool...
[Git workflows, commit protocols, PR creation,
 task management, user communication, etc...]"
```

**Explore agent NE TREBA znati:**
- Kako kreirati PR
- Git commit protocols
- Task management rules
- User communication style

**Samo treba:**
- Pretraživati fajlove
- Identifikovati patterns
- Vratiti rezultate

#### ✅ **Manje tokena = brži odgovori**
- 516 tokens vs 12,000 tokens = **23x manje**
- Brže processing
- Jeftiniji API calls

#### ✅ **No context pollution**
- Sub-agent ne "misli" o nepotrebnim stvarima
- Fokusiran samo na svoj task

---

## 3. Context Inheritance - Šta SE Naslеđuje?

### Razlikuj: System Prompt vs Context

```
System Prompt = "Ko si i kako razmišljaš"
Context = "Šta se desilo do sad u konverzaciji"
```

### Inheritance Matrix:

| Sub-Agent Type | System Prompt | Conversation Context | Tools |
|----------------|---------------|----------------------|-------|
| **Explore** | ❌ Own (516t) | ❌ Fresh slate | 🔒 Read-only |
| **Plan** | ❌ Own (633t) | ✅ Inherits | 🔧 Planning tools |
| **General-Purpose** | ❌ Own (294t) | ✅ Inherits | ✅ All tools (default) |

### Objašnjenje:

#### **Explore Agent:**
- **System Prompt**: Svoj (optimized za search)
- **Context**: **NE naslеđuje** - počinje fresh
- **Zašto?** Brzi codebase search, ne treba conversation history

#### **Plan Agent:**
- **System Prompt**: Svoj (optimized za planning)
- **Context**: **Naslеđuje** - vidi šta se desilo
- **Zašto?** Mora razumeti request da bi planirao

#### **General-Purpose Agent:**
- **System Prompt**: Svoj (minimal execution prompt)
- **Context**: **Naslеđuje** - vidi full conversation
- **Zašto?** Universal worker, treba sav context

---

## 4. Praktičan Primer - Token Flow

### Scenario: User traži feature

```
User: "Add dark mode to the app"

┌─────────────────────────────────────────┐
│ Main Agent (Orchestrator)              │
│ System Prompt: 12,000 tokens           │
│ Context: 5,000 tokens (conversation)   │
│ Total: 17,000 tokens                   │
│                                         │
│ Razmišlja:                             │
│ "Need to explore codebase first..."    │
└─────────────────────────────────────────┘
         │
         │ Spawns Explore Sub-Agent
         ▼
┌─────────────────────────────────────────┐
│ Explore Sub-Agent                       │
│ System Prompt: 516 tokens (SVOJ!)      │
│ Context: 0 tokens (fresh start)        │
│ Total: 516 tokens                       │
│                                         │
│ Task: "Find all styling files"         │
│ - Uses Glob, Grep (read-only)          │
│ - Reports: "Found 12 CSS files..."     │
└─────────────────────────────────────────┘
         │
         │ Returns results
         ▼
┌─────────────────────────────────────────┐
│ Main Agent (Orchestrator)              │
│ Context += 500 tokens (Explore results)│
│ Total: 17,500 tokens                   │
│                                         │
│ Razmišlja:                             │
│ "Now need architecture plan..."        │
└─────────────────────────────────────────┘
         │
         │ Spawns Plan Sub-Agent
         ▼
┌─────────────────────────────────────────┐
│ Plan Sub-Agent                          │
│ System Prompt: 633 tokens (SVOJ!)      │
│ Context: 5,500 tokens (NASLЕĐUJE!)     │
│ Total: 6,133 tokens                    │
│                                         │
│ Task: "Design dark mode architecture"  │
│ - Reads Explore results                │
│ - Plans CSS variable approach          │
│ - Returns: Implementation plan         │
└─────────────────────────────────────────┘
         │
         │ Returns plan
         ▼
┌─────────────────────────────────────────┐
│ Main Agent (Orchestrator)              │
│ Context += 2,000 tokens (Plan)         │
│ Total: 19,500 tokens                   │
│                                         │
│ Razmišlja:                             │
│ "Now delegate implementation..."       │
└─────────────────────────────────────────┘
         │
         │ Spawns Code Sub-Agent
         ▼
┌─────────────────────────────────────────┐
│ Code Sub-Agent (General-Purpose)       │
│ System Prompt: 294 tokens (SVOJ!)      │
│ Context: 7,500 tokens (NASLЕĐUJE!)     │
│ Total: 7,794 tokens                    │
│                                         │
│ Task: "Implement dark mode"            │
│ - Writes CSS variables                 │
│ - Updates components                   │
│ - Tests implementation                 │
│ Context grows to: 50,000 tokens        │
└─────────────────────────────────────────┘
         │
         │ Returns summary
         ▼
┌─────────────────────────────────────────┐
│ Main Agent (Orchestrator)              │
│ Context += 1,000 tokens (summary only!)│
│ Total: 20,500 tokens                   │
│                                         │
│ Reports to user: "Dark mode added!"    │
└─────────────────────────────────────────┘
```

### Key Insight:

**Main Agent NIKAD ne vidi 50,000 tokena code details!**
- Sub-agent drži detalje u svom contextu
- Main agent dobija samo **summary** (1,000 tokens)
- **Context ostaje CLEAN!**

---

## 5. Custom Sub-Agents - Kako Radе?

### Dva scenarija:

#### **A) Custom Sub-Agent via Skills:**

```bash
.claude/skills/my-custom-agent/
├── skill.json
└── system-prompt.md          ← TVOJ CUSTOM PROMPT!
```

**skill.json:**
```json
{
  "name": "my-custom-agent",
  "subagent": true,
  "system_prompt": "system-prompt.md"  ← Ovo koristi!
}
```

**Rezultat:**
- ✅ Sub-agent dobija **TVOј prompt**
- ❌ NE dobija Claude Code default prompt
- ✅ Totalno custom ponašanje

---

#### **B) Custom Sub-Agent via Agent SDK:**

```javascript
import Anthropic from '@anthropic-ai/sdk';

async function spawnCustomAgent(task) {
  const client = new Anthropic({ apiKey: API_KEY });

  const response = await client.messages.create({
    model: 'claude-sonnet-4.5',

    // TVOJ CUSTOM SYSTEM PROMPT!
    system: `
You are a specialized business analyst agent.

Your role:
- Analyze data
- Propose strategies
- Identify risks
- Recommend actions

You are NOT a coder. Focus on business insights.
    `,

    messages: [{ role: 'user', content: task }]
  });

  return response;
}
```

**Rezultat:**
- ✅ Sub-agent dobija **TVOј prompt**
- ❌ NE dobija bilo šta od Claude Code-a
- ✅ Potpuna kontrola

---

## 6. Da li Moraš Editovati Sub-Agent Prompte?

### Odgovor: **Zavisi od slučaja!**

#### **Scenario 1: Koristiš Built-in Sub-Agente**

```javascript
// Spawning built-in Explore agent
await Task({
  subagent_type: 'Explore',
  prompt: 'Find all API endpoints'
});
```

**System Prompt:**
- ❌ **Ne možeš direktno editovati** Explore prompt
- ✅ Ali možeš modify preko **hook-a**

**Hook primer:**
```javascript
// .claude/hooks/modify-subagent.js
export default {
  async beforeToolUse({ toolName, toolInput }) {
    if (toolName === 'Task' && toolInput.subagent_type === 'Explore') {
      // Modifikuj prompt koji se šalje sub-agentu
      toolInput.prompt = `
${toolInput.prompt}

ADDITIONAL INSTRUCTION:
Focus on finding security vulnerabilities.
      `;
    }
    return { toolName, toolInput };
  }
};
```

---

#### **Scenario 2: Praviš Custom Sub-Agente**

```bash
.claude/skills/security-analyzer/
└── system-prompt.md
```

**system-prompt.md:**
```markdown
You are a SECURITY ANALYSIS agent.

Focus ONLY on security:
- Identify vulnerabilities
- Check for OWASP Top 10
- Review authentication/authorization
- Report findings with severity levels

Do NOT write code. Only analyze and report.
```

**Rezultat:**
- ✅ **Potpuna kontrola** nad system promptom
- ✅ Sub-agent dolazi sa **TVOјIM** instrukcijama
- ❌ Nema default Claude Code ponašanja

---

## 7. Orchestrator + Sub-Agent Prompt Strategy

### BEST PRACTICE za WUFF Orchestrator:

```
┌──────────────────────────────────────────────┐
│ WUFF Orchestrator (Main Agent)              │
│                                              │
│ System Prompt (Custom):                     │
│ - "You are business partner..."             │
│ - "Delegate coding to sub-agents..."        │
│ - "Think strategically..."                  │
│                                              │
│ Tools: Read, Grep, Glob, Task, TodoWrite    │
│ (NO Write, Edit - disabled via config)      │
└──────────────────────────────────────────────┘
         │
         ├─── Spawn ───────────────────────────┐
         │                                      │
         ▼                                      ▼
┌─────────────────────────┐    ┌─────────────────────────┐
│ Code Sub-Agent          │    │ Doc Sub-Agent           │
│                         │    │                         │
│ System Prompt:          │    │ System Prompt:          │
│ - "You write code..."   │    │ - "You write docs..."   │
│ - "Follow standards..." │    │ - "Follow style guide..." │
│ - "Test everything..."  │    │ - "Include examples..." │
│                         │    │                         │
│ Tools: Write, Edit,     │    │ Tools: Write, Read,     │
│        Bash, Read       │    │        Grep             │
└─────────────────────────┘    └─────────────────────────┘
```

### Key Points:

1. **Orchestrator prompt**: Business + coordination focus
2. **Sub-agent prompts**: Specialized, execution focus
3. **NO overlap**: Svako ima clear responsibility
4. **NO conflict**: Orchestrator NE kodira, sub-agenti NE koordiniraju

---

## 8. Token Optimization - Zašto je Ovo Važno?

### Scenario: Sve u jednom agentu (BAD)

```
Single Agent Context:
├── System Prompt: 12,000 tokens
├── Business conversation: 10,000 tokens
├── Code implementation: 50,000 tokens
├── Documentation: 20,000 tokens
├── Research notes: 30,000 tokens
└── Available: 78,000 tokens

Result: 61% context used!
- Slow responses
- Context window pressure
- Mixed concerns in thinking
```

### Scenario: Orchestrator + Sub-Agents (GOOD)

```
Orchestrator Context:
├── System Prompt: 3,000 tokens (custom, lean)
├── Business conversation: 10,000 tokens
├── Sub-agent summaries: 5,000 tokens
└── Available: 182,000 tokens (9% used!)

Code Sub-Agent Context (isolated):
├── System Prompt: 500 tokens (custom, minimal)
├── Implementation work: 50,000 tokens
└── Available: 149,500 tokens (25% used)

Doc Sub-Agent Context (isolated):
├── System Prompt: 400 tokens (custom, minimal)
├── Documentation: 20,000 tokens
└── Available: 179,600 tokens (10% used)

Result:
- Each agent has clean, focused context
- Fast responses
- Parallel execution
- Clear separation of concerns
```

---

## 9. Finalni Odgovor na Pitanje

### **Da li sub-agenti imaju Antropic sys koji trebamo editovati?**

**Odgovor u 3 dela:**

#### 1. **Built-in Sub-Agenti (Explore, Plan, Task):**
- ✅ Imaju **svoje, odvojene** Antropic prompte
- ✅ Optimized za svoju ulogu (516-633 tokena)
- ⚠️ Ne možeš **direktno** editovati (npm package)
- ✅ Ali možeš **modify preko hook-a**

#### 2. **Custom Sub-Agenti (Skills):**
- ✅ Dolaze sa **TVOјIM custom promptom**
- ❌ **NE naslеđuju** Claude Code default
- ✅ Potpuna kontrola nad ponašanjem

#### 3. **Custom Sub-Agenti (Agent SDK):**
- ✅ Dolaze sa **TVOјIM custom promptom**
- ❌ **NE naslеđuju** ništa od Claude Code-a
- ✅ Programmatic full control

### **Zaključak:**

**NE, sub-agenti NE dolaze sa istim velikim Antropic sys promptom!**

Oni dolaze sa:
- **Built-in agenti**: Lean, specialized prompti (294-633 tokena)
- **Custom agenti**: TVOJI prompti (koliko god hoćeš)

**To je FEATURE, ne bug!**
- Manje tokena
- Brži odgovori
- Fokusirani na task
- No context pollution

---

## 10. Praktična Preporuka za WUFF

### Setup:

```bash
your-project/
├── .claude/
│   ├── hooks/
│   │   └── orchestrator-mode.js    ← Modify main agent
│   │
│   └── skills/
│       ├── code-specialist/
│       │   ├── skill.json
│       │   └── system-prompt.md    ← Custom code agent prompt
│       │
│       ├── doc-specialist/
│       │   ├── skill.json
│       │   └── system-prompt.md    ← Custom doc agent prompt
│       │
│       └── business-analyst/
│           ├── skill.json
│           └── system-prompt.md    ← Custom analyst agent prompt
```

### orchestrator-mode.js:
```javascript
// Modify MAIN agent system prompt
export default {
  async beforeMessage({ systemPrompt }) {
    return {
      systemPrompt: `
${systemPrompt}

---
# ORCHESTRATOR MODE

You coordinate, you don't execute.
Delegate to specialized sub-agents.
      `
    };
  }
};
```

### code-specialist/system-prompt.md:
```markdown
You are a CODE SPECIALIST sub-agent.

Your ONLY job: Implement features with high-quality code.

Rules:
- Write clean, tested code
- Follow project conventions
- Report concisely
- Stay in your lane (no business decisions)
```

**Rezultat:**
- ✅ Main agent: Orchestrator prompt
- ✅ Code sub-agent: Specialist prompt
- ✅ Doc sub-agent: Documentation prompt
- ✅ All custom, all optimized, all isolated!

---

## Sources & References

- [Subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
- [Claude Code System Prompts Repository](https://github.com/Piebald-AI/claude-code-system-prompts)
- [Reverse-Engineering Claude Code Sub-Agents](https://www.sabrina.dev/p/reverse-engineering-claude-code-using)
- [How Sub-Agents Work - Complete Guide](https://medium.com/@kinjal01radadiya/how-sub-agents-work-in-claude-code-a-complete-guide-bafc66bbaf70)
- [Sub-agents Don't Inherit Model Config - GitHub Issue](https://github.com/anthropics/claude-code/issues/5456)

---

**Kreirao**: Claude Sonnet 4.5
**Datum**: 2026-01-02
**Za**: WUFF Orchestrator Architecture
