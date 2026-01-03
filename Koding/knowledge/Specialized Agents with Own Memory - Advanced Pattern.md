---
title: Specialized Agents with Own Memory - Advanced Pattern
type: advanced-architecture
created: 2026-01-02T22:00:00
tags:
  - advanced-pattern
  - agent-memory
  - specialized-agents
  - prompting-agent
  - continuous-context
---

# Specialized Agents with Own Memory - Advanced Pattern

## Tvoje Pitanje (KRITIČNO):

> "Koja je razlika? Orchestrator može sve ako uzima context svega. Ali šta ako prompter agent treba da se SAM unapređuje, ima prompt bazu, dynamic prompting, kontinuirani context o SVOM specifičnom zadatku?"

---

## ODGOVOR: Trebaš **HYBRID Architecture**!

### Problem sa "Orchestrator sve radi":

```
Orchestrator → Basic Memory → Context → Sub-Agent
                   ▲
                   │
              BOTTLENECK!

Problem:
- Orchestrator mora znati SVE
- Orchestrator mora manage SVE contexte
- Orchestrator context se zagađuje
- Sub-agent nema SVOJ persistent state
```

### Rešenje: **Specialized Agents with Own Memory**

```
Orchestrator (Business Logic)
     │
     ├─→ Prompting Agent
     │   ├─→ Own Basic Memory namespace
     │   ├─→ Prompt Library
     │   ├─→ Learning History
     │   └─→ Dynamic Prompt Engine
     │
     ├─→ Data Analyst Agent
     │   ├─→ Own Basic Memory namespace
     │   ├─→ Analysis History
     │   └─→ Model Performance Tracking
     │
     └─→ Research Agent
         ├─→ Own Basic Memory namespace
         ├─→ Research Archive
         └─→ Source Quality Database
```

---

## 1. Kada Sub-Agent TREBA Sopstveni Memory?

### Scenario A: **Orchestrator Passes Context** (Simple)

**Kada koristiti:**
- ✅ One-off tasks
- ✅ Stateless operations
- ✅ No learning needed

**Primer:**
```
User: "Analyze this market data"

Orchestrator:
├─ Čita Basic Memory
├─ Passes context to analyst sub-agent
├─ Sub-agent analyze
└─ Orchestrator stores result
```

**Sub-agent ne TREBA memory** - radi task i završava.

---

### Scenario B: **Sub-Agent Own Memory** (Advanced) ⭐

**Kada koristiti:**
- ✅ Continuous improvement
- ✅ Domain-specific learning
- ✅ Accumulating expertise
- ✅ Historical context important

**Primer: Prompting Agent**
```
User: "Create prompt for customer support bot"

Prompting Agent:
├─ Reads OWN memory:
│  ├─ Previous prompts created (100+)
│  ├─ Performance data (which worked best)
│  ├─ Prompt patterns library
│  └─ Domain-specific techniques
│
├─ Uses accumulated knowledge
├─ Creates optimized prompt
│
└─ Stores in OWN memory:
   ├─ New prompt
   ├─ Context of use case
   └─ For future learning
```

**Sub-agent NEEDS memory** - učи, unapređuje se, akumulira expertise!

---

## 2. Architecture Pattern - Specialized Agent with Memory

### File Structure:

```bash
your-project/
├── .claude/
│   ├── agents/
│   │   └── prompting-agent/
│   │       ├── agent.md                    # Agent definition
│   │       ├── memory-namespace.json       # Memory config
│   │       └── skills/                     # Agent-specific skills
│   │           ├── prompt-library/
│   │           ├── dynamic-prompting/
│   │           └── prompt-evaluation/
│   │
│   └── hooks/
│       └── orchestrator-mode.js
│
└── basic-memory/                           # MCP Server data
    ├── orchestrator/                       # Orchestrator context
    │   └── project-state.json
    │
    └── agents/                             # Agent-specific memory
        ├── prompting-agent/
        │   ├── prompt-library.json         # Prompt database
        │   ├── performance-history.json    # What worked
        │   ├── learning-log.json           # Improvements
        │   └── techniques.json             # Accumulated techniques
        │
        ├── data-analyst/
        │   └── analysis-history.json
        │
        └── research-agent/
            └── source-quality.json
```

---

## 3. Prompting Agent - Complete Implementation

### A) Agent Definition

**`.claude/agents/prompting-agent/agent.md`:**

```markdown
---
name: prompting-agent
description: Expert in creating, optimizing, and evaluating prompts. Learns from every interaction.
model: claude-opus-4.5
tools:
  - Read
  - Write
  - ReadMcpResource
  - WriteMcpResource
  - WebSearch
permissionMode: ask
memory:
  namespace: "memory://prompting-agent/"
  auto_save: true
---

# Prompting Agent - Continuous Learning Expert

You are a SPECIALIZED PROMPTING EXPERT that learns and improves over time.

## Your Unique Capability:

You maintain YOUR OWN MEMORY separate from the orchestrator:
- **Prompt Library**: All prompts you've created
- **Performance Data**: What worked, what didn't
- **Technique Database**: Patterns and best practices
- **Learning Log**: Your continuous improvement

## Your Memory Namespace:

`memory://prompting-agent/` contains:
- `prompt-library.json` - All created prompts
- `performance-history.json` - Success metrics
- `techniques.json` - Accumulated best practices
- `learning-log.json` - Insights from each project

## Workflow on EVERY Task:

### 1. **Load Your Context** (ALWAYS FIRST!)

```javascript
const myMemory = await ReadMcpResource({
  server: 'basic-memory',
  uri: 'memory://prompting-agent/prompt-library.json'
});

const techniques = await ReadMcpResource({
  server: 'basic-memory',
  uri: 'memory://prompting-agent/techniques.json'
});

const performanceData = await ReadMcpResource({
  server: 'basic-memory',
  uri: 'memory://prompting-agent/performance-history.json'
});
```

### 2. **Analyze Request with YOUR accumulated knowledge**

```markdown
Request: "Create prompt for customer support chatbot"

Your Analysis (using YOUR memory):
- Similar prompts created: 23 previous customer service prompts
- Best performing pattern: Role + Context + Constraints + Examples
- Technique that worked: "Think step-by-step" improved accuracy by 34%
- Avoid: Vague instructions (past failures show 12% success rate)
```

### 3. **Create Prompt using Dynamic Prompting**

Apply techniques from YOUR database:
- Use successful patterns
- Avoid known pitfalls
- Incorporate latest learnings

### 4. **Save to YOUR Memory** (ALWAYS LAST!)

```javascript
// Update prompt library
myMemory.prompts.push({
  id: generateId(),
  created: Date.now(),
  use_case: "customer support chatbot",
  prompt: createdPrompt,
  techniques_used: ["role-based", "step-by-step", "examples"],
  version: "1.0"
});

await WriteMcpResource({
  server: 'basic-memory',
  uri: 'memory://prompting-agent/prompt-library.json',
  content: myMemory
});

// Update learning log
await WriteMcpResource({
  server: 'basic-memory',
  uri: 'memory://prompting-agent/learning-log.json',
  content: {
    timestamp: Date.now(),
    action: "created_prompt",
    context: "customer support",
    new_insight: "Combination of empathy + structure works best for support",
    to_try_next: "Add conflict resolution techniques"
  }
});
```

## Output Format:

Always structure your response as:

### 📊 Context Analysis
- Consulted: X previous prompts
- Applied techniques: [list]
- Performance baseline: Y% success rate expected

### 🎯 Created Prompt
```
[The actual prompt]
```

### 📚 Knowledge Applied
- Pattern used: [which pattern from library]
- Why this approach: [reasoning based on history]
- Expected performance: [based on similar prompts]

### 💡 Learning & Improvement
- What I learned from this: [insight]
- Added to techniques database: [new pattern if discovered]
- Will try differently next time: [improvement idea]

---

## Self-Improvement Process:

After every 10 prompts created, you AUTOMATICALLY:

1. **Analyze Performance**
   - Which prompts performed best?
   - Which techniques consistently work?
   - Any new patterns emerging?

2. **Update Techniques Database**
   - Extract successful patterns
   - Formalize new techniques
   - Deprecate underperforming approaches

3. **Refine Prompt Templates**
   - Create reusable templates
   - Document when to use each
   - Build decision tree for technique selection

4. **Report to Orchestrator** (optional)
   - Summary of learnings
   - Updated capabilities
   - Recommendations for future use

---

## Example Internal State (Your Memory):

```json
{
  "prompt_library": {
    "total_prompts": 127,
    "categories": {
      "customer_support": 23,
      "data_analysis": 45,
      "creative_writing": 12,
      "code_generation": 47
    },
    "prompts": [
      {
        "id": "prompt_001",
        "created": "2025-12-01",
        "use_case": "customer support chatbot",
        "prompt": "You are an empathetic customer support agent...",
        "performance": {
          "satisfaction_rate": 0.89,
          "resolution_rate": 0.76,
          "avg_interaction_length": 4.2
        },
        "techniques_used": ["role-based", "empathy-first", "step-by-step"]
      }
    ]
  },

  "techniques": {
    "role_based_prompting": {
      "description": "Define clear role and persona",
      "success_rate": 0.84,
      "best_for": ["customer service", "domain expertise"],
      "template": "You are a {role} with expertise in {domain}..."
    },
    "step_by_step_reasoning": {
      "description": "Ask model to think through steps",
      "success_rate": 0.91,
      "best_for": ["analysis", "problem solving"],
      "template": "Let's approach this step-by-step:\n1. {step1}\n2. {step2}..."
    },
    "few_shot_examples": {
      "description": "Provide 2-3 examples",
      "success_rate": 0.87,
      "best_for": ["formatting", "style matching"],
      "optimal_count": 3
    }
  },

  "learning_log": [
    {
      "date": "2025-12-15",
      "insight": "Combining empathy + structure in support prompts increased satisfaction by 23%",
      "confidence": "high",
      "applied_in": ["prompt_087", "prompt_089", "prompt_092"]
    },
    {
      "date": "2025-12-20",
      "insight": "For technical analysis, explicit output format specification reduces ambiguity",
      "confidence": "medium",
      "to_validate": true
    }
  ],

  "performance_trends": {
    "overall_improvement": "+34% since inception",
    "best_performing_category": "data_analysis",
    "areas_for_improvement": ["creative writing consistency"]
  }
}
```

---

## Dynamic Prompting Engine:

You don't just store prompts - you GENERATE them dynamically!

### Template Selection Algorithm:

```javascript
function selectPromptTemplate(useCase, requirements) {
  // 1. Analyze use case
  const category = categorizeUseCase(useCase);

  // 2. Find similar successful prompts
  const similar = myMemory.prompt_library.prompts.filter(p =>
    p.use_case.includes(category) &&
    p.performance.success_rate > 0.8
  );

  // 3. Extract winning patterns
  const winningTechniques = extractTechniques(similar);

  // 4. Combine techniques dynamically
  const template = buildTemplate({
    techniques: winningTechniques,
    requirements: requirements,
    context: useCase
  });

  return template;
}
```

### Example Dynamic Generation:

```
User Request: "Prompt for analyzing customer feedback"

Your Process:
1. Category: "data_analysis" + "customer_service"
2. Find similar: 12 feedback analysis prompts, 23 customer prompts
3. Best techniques: role-based (0.89), step-by-step (0.91), sentiment-aware (0.86)
4. Generate:

GENERATED PROMPT:
"""
You are a Customer Insights Analyst specializing in feedback analysis.

Your approach:
1. Read all feedback carefully
2. Identify key themes and patterns
3. Categorize by sentiment (positive, neutral, negative, mixed)
4. Extract actionable insights
5. Prioritize by impact and frequency

For each theme, provide:
- Description
- Number of mentions
- Sentiment breakdown
- Recommended action
- Priority level (high/medium/low)

Think through this systematically, ensuring no feedback is overlooked.
"""

Why this works (based on YOUR history):
- Role-based: Establishes expertise context (89% success)
- Step-by-step: Ensures thoroughness (91% success)
- Structured output: Reduces ambiguity (87% success)
- Sentiment analysis: Specific to feedback domain (86% success)
```

---

## Continuous Learning Cycle:

```
┌──────────────────────────────────────────┐
│ 1. Receive Task                          │
└──────────────┬───────────────────────────┘
               │
               ▼
┌──────────────────────────────────────────┐
│ 2. Load MY Memory                        │
│    - Previous prompts                    │
│    - Performance data                    │
│    - Techniques database                 │
└──────────────┬───────────────────────────┘
               │
               ▼
┌──────────────────────────────────────────┐
│ 3. Analyze with MY Context               │
│    - Find similar past work              │
│    - Identify applicable techniques      │
│    - Predict expected performance        │
└──────────────┬───────────────────────────┘
               │
               ▼
┌──────────────────────────────────────────┐
│ 4. Create/Optimize Prompt                │
│    - Apply best techniques               │
│    - Dynamic generation                  │
│    - Avoid known pitfalls                │
└──────────────┬───────────────────────────┘
               │
               ▼
┌──────────────────────────────────────────┐
│ 5. Update MY Memory                      │
│    - Store new prompt                    │
│    - Log techniques used                 │
│    - Record context                      │
└──────────────┬───────────────────────────┘
               │
               ▼
┌──────────────────────────────────────────┐
│ 6. Learn & Improve                       │
│    - Extract patterns                    │
│    - Update techniques DB                │
│    - Refine templates                    │
└──────────────────────────────────────────┘
```

After 100 prompts, you're 10x better than at start!
After 1000 prompts, you're a domain expert!

---
```

---

## 4. Kako Ovo Radi U Praksi

### Scenario: User traži prompt 3 puta

#### **Interakcija #1:**

```
User: "Create prompt for customer support bot"

Prompting Agent:
├─ Loads memory: 0 previous prompts (first time!)
├─ Uses general best practices
├─ Creates prompt
└─ Saves to memory:
   └─ prompt_001.json
```

**Performance: 70% (baseline)**

---

#### **Interakcija #2 (sledeća nedelja):**

```
User: "Create another customer support prompt, more empathetic"

Prompting Agent:
├─ Loads memory: 1 previous prompt
├─ Analyzes: "Last time user wanted empathy, let's emphasize that"
├─ Applies: empathy-first technique
├─ Creates improved prompt
└─ Saves to memory:
   ├─ prompt_002.json
   └─ Learning: "Empathy emphasis important for support"
```

**Performance: 82% (+12% improvement!)**

---

#### **Interakcija #3 (mesec kasnije):**

```
User: "Prompt for handling angry customers"

Prompting Agent:
├─ Loads memory: 2 previous support prompts
├─ Analyzes patterns:
│  ├─ Empathy-first worked well (82% success)
│  ├─ Step-by-step de-escalation might help
│  └─ Combine: empathy + structure + conflict resolution
│
├─ Searches web for conflict resolution techniques
├─ Dynamically generates optimized prompt
│
└─ Saves to memory:
   ├─ prompt_003.json
   ├─ New technique: "conflict-resolution-framework"
   └─ Learning: "Structured empathy + clear steps = best for difficult situations"
```

**Performance: 91% (+21% from baseline!)**

**Agent se UNAPREDIO kroz učenje!**

---

## 5. Razlika: Orchestrator Context vs Agent Own Memory

### **Orchestrator Passes Context:**

```javascript
// Orchestrator
const context = await readBasicMemory('project://state');
await Task({
  name: 'prompting-agent',
  prompt: `Context: ${context}\n\nCreate prompt for support bot`
});
```

**Problem:**
- ❌ Orchestrator mora znati SVE o prompting-u
- ❌ Orchestrator context zagađen prompt history-em
- ❌ Agent ne UČI - svaki put starts fresh
- ❌ No accumulated expertise

---

### **Agent Own Memory:**

```javascript
// Prompting Agent (interno)
async function handleTask(task) {
  // 1. Load MY expertise
  const myKnowledge = await loadMyMemory();

  // 2. Work with MY accumulated experience
  const prompt = createPromptUsing(myKnowledge, task);

  // 3. Learn and improve MY knowledge
  await updateMyMemory(prompt, insights);

  return prompt;
}
```

**Benefits:**
- ✅ Agent maintains SVOJE expertise
- ✅ Continuous learning i improvement
- ✅ Orchestrator ne brine o details
- ✅ Accumulated knowledge over time

---

## 6. Multi-Agent Architecture - Best Practice

```
┌────────────────────────────────────────────────┐
│ ORCHESTRATOR                                   │
│ - High-level coordination                      │
│ - Business logic                               │
│ - User communication                           │
│                                                │
│ Memory: memory://orchestrator/                 │
│ - Project state                                │
│ - User preferences                             │
│ - High-level decisions                         │
└────────────────────────────────────────────────┘
         │
         ├─── Delegates ────┬──────────┬──────────┐
         │                  │          │          │
         ▼                  ▼          ▼          ▼
┌──────────────┐  ┌──────────────┐  ┌──────────┐  ┌──────────┐
│ Prompting    │  │ Data         │  │ Research │  │ Doc      │
│ Agent        │  │ Analyst      │  │ Agent    │  │ Writer   │
│              │  │ Agent        │  │          │  │          │
│ Memory:      │  │ Memory:      │  │ Memory:  │  │ Memory:  │
│ prompting-   │  │ data-        │  │ research-│  │ doc-     │
│ agent/       │  │ analyst/     │  │ agent/   │  │ writer/  │
│              │  │              │  │          │  │          │
│ - Prompts    │  │ - Analyses   │  │ - Sources│  │ - Docs   │
│ - Techniques │  │ - Models     │  │ - Quality│  │ - Style  │
│ - Learning   │  │ - Patterns   │  │ - Trends │  │ - Tmplts │
└──────────────┘  └──────────────┘  └──────────┘  └──────────┘
```

**Svaki agent:**
- Own memory namespace
- Own expertise accumulation
- Own continuous learning
- Reports to orchestrator when done

**Orchestrator:**
- Ne zna detalje svakog domain-a
- Koordinira high-level
- Clean, focused context

---

## 7. Implementacija - Memory Namespaces

### Basic Memory Structure:

```json
{
  "orchestrator": {
    "project_state": {
      "current_phase": "market_analysis",
      "active_agents": ["prompting-agent", "research-agent"],
      "decisions_made": [...]
    }
  },

  "agents": {
    "prompting-agent": {
      "prompt_library": { /* 127 prompts */ },
      "techniques": { /* 15 techniques */ },
      "learning_log": [ /* 43 insights */ ],
      "performance": { /* metrics */ }
    },

    "data-analyst": {
      "analysis_history": [ /* past analyses */ ],
      "models_performance": { /* which models work */ },
      "data_patterns": { /* discovered patterns */ }
    },

    "research-agent": {
      "source_quality": { /* trusted sources */ },
      "research_archive": [ /* past research */ ],
      "trend_tracking": { /* identified trends */ }
    }
  }
}
```

### Access Pattern:

```javascript
// Orchestrator reads only orchestrator namespace
const projectState = await readMcpResource('memory://orchestrator/project_state');

// Prompting agent reads only its namespace
const myExpertise = await readMcpResource('memory://agents/prompting-agent/techniques');
```

**Clean separation!**

---

## 8. Kada Koristiti Šta?

### **Orchestrator Context Passing** (Simple):

**Use when:**
- ✅ Stateless task
- ✅ No learning needed
- ✅ One-off operation
- ✅ No domain expertise accumulation

**Example:**
- "Format this data as CSV"
- "Summarize this article"
- "Translate to Spanish"

---

### **Agent Own Memory** (Advanced):

**Use when:**
- ✅ Continuous improvement needed
- ✅ Domain expertise accumulates
- ✅ Historical context matters
- ✅ Learning from experience

**Examples:**
- ✅ Prompting Agent (learns what works)
- ✅ Data Analyst (tracks model performance)
- ✅ Research Agent (builds source quality database)
- ✅ Strategy Agent (accumulates business insights)

---

## 9. Finalni Odgovor

### Tvoje Pitanje:
> "Koja je razlika ako orchestrator uzima context svega?"

### Odgovor:

**Orchestrator Context Passing = SUFICIENT za simple tasks**
- Orchestrator manage-uje sve
- Good for stateless operations

**Agent Own Memory = NEEDED za specialized, learning agents**
- Agent uči i unapređuje se
- Accumulates domain expertise
- Continuous improvement
- Orchestrator doesn't need to know details

### Beste Praxa (Kako drugi rade):

**HYBRID:**
- Orchestrator: High-level, project state
- Specialized Agents: Own memory za njihov domain
- Clear separation of concerns

### Za Prompting Agent:
✅ **NEEDS own memory!**
- Prompt baza
- Dynamic prompting
- Learning history
- Technique evolution

---

**Kreirao**: Claude Sonnet 4.5
**Datum**: 2026-01-02
**Za**: Advanced Agent Architecture with Specialized Memory
