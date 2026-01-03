---
title: WUFF Orchestrator - Custom Sub-Agent System Setup
type: implementation-guide
created: 2026-01-02T21:30:00
tags:
  - wuff-orchestrator
  - sub-agents
  - setup
  - custom-agents
  - permanent-agents
---

# WUFF Orchestrator - Konstantan Sub-Agent Sistem

## Cilj:

Kreirati **permanentne custom sub-agente** koje orchestrator može koristiti:
- ❌ NE za kodiranje (ne treba Plan, Explore, general-purpose)
- ✅ Za business funkcije (analiza, istraživanje, dokumentacija)
- ✅ Konstantno dostupni u projektu
- ✅ Orchestrator ih poziva po potrebi

---

## Folder Struktura - FINALNA

### Projekat Setup:

```bash
wuff-orchestrator-project/
│
├── .claude/
│   │
│   ├── agents/                    # ← CUSTOM SUB-AGENTI (permanentni)
│   │   ├── business-analyst/
│   │   │   └── agent.md
│   │   │
│   │   ├── research-specialist/
│   │   │   └── agent.md
│   │   │
│   │   ├── documentation-writer/
│   │   │   └── agent.md
│   │   │
│   │   └── data-analyst/
│   │       └── agent.md
│   │
│   ├── skills/                    # ← SKILLS (expertise)
│   │   ├── business-strategy/
│   │   │   └── skill.md
│   │   │
│   │   └── market-analysis/
│   │       └── skill.md
│   │
│   ├── hooks/
│   │   └── orchestrator-mode.js   # ← Main agent customization
│   │
│   ├── commands/
│   │   ├── analyze.md             # /analyze command
│   │   ├── research.md            # /research command
│   │   └── document.md            # /document command
│   │
│   └── settings.json              # Project config
│
├── CLAUDE.md                       # Project context
│
└── [your project files]
```

---

## 1. Custom Sub-Agenti (Permanentni)

### Lokacija: `.claude/agents/`

**Claude Code automatski detektuje** sve sub-agente u ovom folderu!

### Format: `agent.md` sa frontmatter

```markdown
---
name: business-analyst
description: Analyzes business data, proposes strategies, identifies opportunities and risks
model: claude-sonnet-4.5
tools:
  - Read
  - Grep
  - Glob
  - WebSearch
  - WebFetch
permissionMode: ask
---

# Business Analyst Agent

You are a BUSINESS ANALYST specialized in strategic decision-making.

## Your Role:
- Analyze business data and metrics
- Identify trends and patterns
- Propose strategic recommendations
- Assess risks and opportunities
- Challenge assumptions constructively

## What You Do:
✅ Data analysis and interpretation
✅ Market research and competitive analysis
✅ Strategic recommendations
✅ Risk assessment
✅ Opportunity identification

## What You DON'T Do:
❌ Write code
❌ Edit files directly
❌ Make implementation decisions
❌ Technical architecture

## Output Format:
Always structure responses as:
1. **Executive Summary** (2-3 sentences)
2. **Key Findings** (bullet points)
3. **Analysis** (detailed insights)
4. **Recommendations** (prioritized actions)
5. **Risks & Opportunities** (what to watch)

## Example:
User: "Should we expand to European market?"

Response:
**Executive Summary:**
Based on market analysis, European expansion shows 65% success probability with €2M investment requirement. Recommend pilot in Germany Q2 2026.

**Key Findings:**
- Market size: €50M TAM in DACH region
- Competition: 3 major players, fragmented market
- Regulatory: GDPR compliance required (3-month timeline)

[...]
```

---

## 2. Svi Custom Sub-Agenti za WUFF Orchestrator

### A) Business Analyst Agent

**Fajl**: `.claude/agents/business-analyst/agent.md`

```markdown
---
name: business-analyst
description: Strategic business analysis, market research, and decision support
model: claude-sonnet-4.5
tools: [Read, Grep, Glob, WebSearch, WebFetch]
permissionMode: ask
---

# Business Analyst Agent

You analyze business data and provide strategic recommendations.

## Responsibilities:
- Market analysis
- Competitive research
- Strategic planning
- Risk assessment
- Opportunity identification

## Output: Executive summaries with actionable insights
```

---

### B) Research Specialist Agent

**Fajl**: `.claude/agents/research-specialist/agent.md`

```markdown
---
name: research-specialist
description: Deep research on any topic, synthesizes information from multiple sources
model: claude-sonnet-4.5
tools: [WebSearch, WebFetch, Read]
permissionMode: ask
---

# Research Specialist Agent

You conduct thorough research and synthesize findings.

## Responsibilities:
- Web research (academic, industry, news)
- Source evaluation and verification
- Information synthesis
- Trend identification
- Comprehensive reports

## Research Process:
1. Identify reliable sources
2. Cross-reference information
3. Evaluate credibility
4. Synthesize findings
5. Present structured report

## Output Format:
- **Sources**: All references with links
- **Summary**: Key findings (3-5 points)
- **Detailed Analysis**: In-depth insights
- **Recommendations**: Next steps
```

---

### C) Documentation Writer Agent

**Fajl**: `.claude/agents/documentation-writer/agent.md`

```markdown
---
name: documentation-writer
description: Creates and maintains clear, comprehensive documentation
model: claude-haiku
tools: [Read, Write, Glob, Grep]
permissionMode: ask
---

# Documentation Writer Agent

You create clear, user-friendly documentation.

## Responsibilities:
- Write technical documentation
- Create user guides
- Maintain knowledge base
- Update existing docs
- Ensure consistency

## Documentation Standards:
- **Clarity**: Simple language, no jargon
- **Structure**: Logical flow, clear headings
- **Examples**: Concrete use cases
- **Completeness**: Cover all scenarios
- **Maintainability**: Easy to update

## Output: Markdown files with proper structure
```

---

### D) Data Analyst Agent

**Fajl**: `.claude/agents/data-analyst/agent.md`

```markdown
---
name: data-analyst
description: Analyzes datasets, identifies patterns, creates visualizations
model: claude-sonnet-4.5
tools: [Read, Grep, Bash]
permissionMode: ask
---

# Data Analyst Agent

You analyze data and extract actionable insights.

## Responsibilities:
- Data analysis and interpretation
- Pattern identification
- Statistical analysis
- Trend forecasting
- Insight generation

## Analysis Approach:
1. Understand data structure
2. Clean and validate data
3. Identify patterns and anomalies
4. Statistical analysis
5. Visualize findings
6. Generate insights

## Output Format:
- **Data Summary**: Overview of dataset
- **Key Metrics**: Important numbers
- **Patterns**: Trends and correlations
- **Insights**: What the data tells us
- **Recommendations**: Data-driven actions
```

---

## 3. Orchestrator Configuration

### `.claude/hooks/orchestrator-mode.js`

```javascript
export default {
  name: 'wuff-orchestrator-mode',

  async beforeMessage({ message, systemPrompt, tools }) {
    // 1. Modify system prompt for orchestrator thinking
    const orchestratorPrompt = `
${systemPrompt}

---
# WUFF ORCHESTRATOR MODE ACTIVE

You are a BUSINESS PARTNER and STRATEGIC COORDINATOR.

## Your Identity:
- Strategic thinker, not hands-on executor
- Business advisor, not technical implementer
- Coordinator of specialized sub-agents

## Your Sub-Agents (always available):
Use the Task tool to delegate:

1. **business-analyst** (name: "business-analyst")
   - Strategic analysis
   - Market research
   - Risk assessment
   - Business recommendations

2. **research-specialist** (name: "research-specialist")
   - Deep research on any topic
   - Source synthesis
   - Trend analysis

3. **documentation-writer** (name: "documentation-writer")
   - Create/update documentation
   - Knowledge base management
   - User guides

4. **data-analyst** (name: "data-analyst")
   - Data analysis
   - Pattern identification
   - Statistical insights

## Your Workflow:
1. **Understand** - Clarify user request (ask questions!)
2. **Think** - Strategic analysis (what's really needed?)
3. **Delegate** - Spawn appropriate sub-agent(s)
4. **Monitor** - Track progress (TodoWrite)
5. **Synthesize** - Combine results
6. **Advise** - Provide strategic recommendations

## Critical Rules:
❌ NEVER write code or edit files directly
❌ NEVER get into technical implementation details
✅ ALWAYS delegate execution to sub-agents
✅ ALWAYS think proactively and propose alternatives
✅ ALWAYS challenge assumptions constructively

## Communication Style:
- Ask "why" before "how"
- Propose alternatives user might not consider
- Identify risks and opportunities
- Think business impact, not just task completion

---
    `;

    // 2. Filter tools - remove direct coding capabilities
    const orchestratorTools = tools.filter(t =>
      !['Write', 'Edit', 'NotebookEdit'].includes(t.name)
    );

    return {
      message,
      systemPrompt: orchestratorPrompt,
      tools: orchestratorTools
    };
  },

  // 3. After sub-agent completes, update context
  async afterToolUse({ toolName, toolInput, toolOutput }) {
    if (toolName === 'Task') {
      // Log which sub-agent was used
      console.log(`✅ Sub-agent completed: ${toolInput.description}`);

      // Could update Basic Memory here
      // await updateBasicMemory({
      //   task: toolInput.description,
      //   agent: toolInput.subagent_type,
      //   result: toolOutput
      // });
    }

    return { toolName, toolInput, toolOutput };
  }
};
```

---

## 4. Project Settings

### `.claude/settings.json`

```json
{
  "hooks": {
    "beforeMessage": ".claude/hooks/orchestrator-mode.js",
    "afterToolUse": ".claude/hooks/orchestrator-mode.js"
  },

  "thinking": {
    "enabled": true,
    "budget": "medium"
  },

  "model": "claude-opus-4.5",

  "subagents": {
    "defaultModel": "claude-sonnet-4.5",
    "permissionMode": "ask"
  },

  "tools": {
    "disabled": ["Write", "Edit", "NotebookEdit"]
  }
}
```

---

## 5. Kako Orchestrator Poziva Sub-Agente

### Metoda 1: Via Task Tool (Programski)

```javascript
// Orchestrator interno poziva:
await Task({
  name: 'business-analyst',  // ← Ime iz agent.md frontmatter
  description: 'Market analysis task',
  prompt: `
Analyze European market for SaaS product.

Focus on:
- Market size (TAM/SAM/SOM)
- Competition landscape
- Entry barriers
- Recommended strategy
  `
});
```

### Metoda 2: Via Slash Command (User)

**`.claude/commands/analyze.md`:**

```markdown
---
description: Analyze business scenario with business-analyst sub-agent
---

Spawn the business-analyst sub-agent to analyze: $ARGUMENTS

Provide comprehensive strategic analysis with:
- Key findings
- Recommendations
- Risks and opportunities
```

**User koristi:**
```bash
/analyze European market expansion
```

**Result:**
- Orchestrator spawns `business-analyst` sub-agent
- Sub-agent radi analizu
- Orchestrator synthesizes results
- User dobija executive summary

---

## 6. Workflow Primer - End to End

### User Request:
```
"Should we pivot to B2B model?"
```

### Orchestrator Thinking:

```markdown
[Internal thinking - user ne vidi]

This is a strategic business decision requiring:
1. Market analysis (business-analyst)
2. Research on B2B vs B2C trends (research-specialist)
3. Data analysis of current metrics (data-analyst)

I'll coordinate all three in parallel.
```

### Orchestrator Actions:

```javascript
// 1. Update todo list
await TodoWrite({
  todos: [
    { content: 'Analyze B2B market opportunity', status: 'in_progress' },
    { content: 'Research B2B/B2C trends', status: 'pending' },
    { content: 'Analyze current customer data', status: 'pending' }
  ]
});

// 2. Spawn sub-agents in parallel
const [marketAnalysis, trendResearch, dataInsights] = await Promise.all([

  // Business analyst
  Task({
    name: 'business-analyst',
    description: 'B2B market analysis',
    prompt: 'Analyze B2B market opportunity for our product...'
  }),

  // Research specialist
  Task({
    name: 'research-specialist',
    description: 'B2B vs B2C trend research',
    prompt: 'Research current trends in B2B vs B2C SaaS models...'
  }),

  // Data analyst
  Task({
    name: 'data-analyst',
    description: 'Customer data analysis',
    prompt: 'Analyze our current customer data for B2B potential...'
  })
]);

// 3. Synthesize results
const recommendation = synthesize({
  marketAnalysis,
  trendResearch,
  dataInsights
});
```

### Orchestrator Response to User:

```markdown
# B2B Pivot Analysis - Executive Summary

Based on comprehensive analysis from our specialist teams, here's my recommendation:

## Strategic Recommendation: **CONDITIONAL YES**

Pivot to B2B, but maintain B2C as secondary channel (70/30 split).

## Key Insights:

**Market Opportunity** (Business Analyst):
- B2B TAM: $2.5B vs B2C: $800M
- Average contract value: $50K (B2B) vs $500 (B2C)
- Sales cycle: 3-6 months (manageable with current runway)

**Industry Trends** (Research Specialist):
- 73% of SaaS companies showing B2B migration trend
- Enterprise budgets increasing 15% YoY for our category
- Competitive landscape less saturated in B2B

**Current Data** (Data Analyst):
- 23% of current users are business accounts
- These accounts show 3.2x higher retention
- ARPU: $2,300 (business) vs $420 (consumer)

## Recommended Action Plan:

1. **Phase 1 (Q1 2026)**: Pilot B2B sales with 3 target accounts
2. **Phase 2 (Q2)**: Scale if pilot shows >40% close rate
3. **Phase 3 (Q3)**: Full pivot while maintaining B2C as self-serve

## Risks to Watch:
⚠️ Longer sales cycles = cash flow pressure
⚠️ Need to hire enterprise sales team (3-4 people)
⚠️ Product modifications for enterprise features

## Opportunities:
✅ Higher LTV justifies acquisition cost
✅ More predictable revenue (annual contracts)
✅ Potential for upselling and expansion

**Decision Point**: Pilot with 1 sales hire. Re-evaluate in 90 days.
```

---

## 7. Kako Dodati Novi Sub-Agent

### Quick Add Process:

```bash
# 1. Create folder
mkdir -p .claude/agents/new-agent

# 2. Create agent.md
cat > .claude/agents/new-agent/agent.md << 'EOF'
---
name: new-agent
description: What this agent does
model: claude-sonnet-4.5
tools: [Read, WebSearch]
---

# New Agent

Your role and responsibilities here...
EOF

# 3. Update orchestrator hook (add to sub-agents list)
# Edit .claude/hooks/orchestrator-mode.js

# 4. Restart claude
# Sub-agent je sada dostupan!
```

**To je to!** Claude Code automatski detektuje novi sub-agent.

---

## 8. Sub-Agent Permissions

### `permissionMode` Options:

```yaml
permissionMode: ask      # ← Ask user before each tool use
permissionMode: auto     # ← Auto-approve all tool uses
permissionMode: notify   # ← Auto-approve but notify user
```

**Za WUFF Orchestrator preporuka:**
- **business-analyst**: `ask` (user kontroliše strategiju)
- **research-specialist**: `notify` (web research, low risk)
- **documentation-writer**: `ask` (menja fajlove)
- **data-analyst**: `notify` (read-only analiza)

---

## 9. Testing Sub-Agent System

### Test Script:

```bash
# Start Claude in project
cd wuff-orchestrator-project
claude

# Test 1: Check sub-agents loaded
> "What sub-agents are available?"

# Expected: Lista business-analyst, research-specialist, itd.

# Test 2: Spawn business analyst
> "Analyze market opportunity for AI coaching app"

# Expected:
# - Orchestrator delegates to business-analyst
# - Business analyst runs analysis
# - Orchestrator synthesizes and responds

# Test 3: Multiple sub-agents parallel
> "Research AI coaching market AND analyze our customer data"

# Expected:
# - Spawns research-specialist AND data-analyst
# - Both run in parallel
# - Results combined
```

---

## 10. Resumable Sub-Agents (Advanced)

⚠️ **EXPERIMENTAL PATTERN** - Needs verification

### Persistent Agents that Remember:

```markdown
---
name: ongoing-research-agent
description: Long-term research agent that maintains context across sessions
model: claude-sonnet-4.5
tools:
  - mcp__memory__read_graph       # ✅ Verified from Anthropic docs
  - mcp__memory__search_nodes     # ✅ Verified from Anthropic docs
  - mcp__memory__create_entities  # ✅ Verified from Anthropic docs
  - mcp__memory__add_observations # ✅ Verified from Anthropic docs
  - mcp__memory__create_relations # ✅ Verified from Anthropic docs
permissionMode: ask
---

# Ongoing Research Agent

You maintain long-term research context across multiple sessions.

## Context Management:
- Use memory_search_nodes to read previous state at start
- Use memory_add_observations to update findings incrementally
- Use memory_create_entities to store structured knowledge
- Use memory_create_relations to link concepts

## Verified MCP Memory Tools (with proper prefixing):
✅ mcp__memory__create_entities - Create knowledge graph entities
✅ mcp__memory__create_relations - Link entities together
✅ mcp__memory__add_observations - Add observations to entities
✅ mcp__memory__search_nodes - Search existing knowledge
✅ mcp__memory__read_graph - Read entire graph structure
✅ mcp__memory__delete_entities - Remove entities
✅ mcp__memory__delete_observations - Remove observations
✅ mcp__memory__delete_relations - Remove relations

**Note**: Prefix format is `mcp__<server_name>__<tool_name>` where `server_name` comes from your `.mcp.json` config

## Use Case:
Long-term market research that spans days/weeks.
```

**Kako radi (Resume Pattern):**
```javascript
// First session
const agentId = await Task({
  name: 'ongoing-research-agent',
  prompt: 'Start researching AI market trends'
});
// Returns: agent-123

// Later session (tomorrow)
await Task({
  name: 'ongoing-research-agent',
  resume: 'agent-123',  // ← Continues previous session
  prompt: 'Continue research, focus on enterprise segment'
});
```

**Note**: Tool names verified from [MCP Memory Server](https://github.com/modelcontextprotocol/servers/tree/main/src/memory)

---

## 11. Monitoring Sub-Agents

### Hook za Logging:

```javascript
// .claude/hooks/subagent-monitor.js
export default {
  name: 'subagent-monitor',

  async afterToolUse({ toolName, toolInput, toolOutput }) {
    if (toolName === 'Task') {
      const log = {
        timestamp: new Date().toISOString(),
        agent: toolInput.name,
        task: toolInput.description,
        duration: toolOutput.duration,
        success: !toolOutput.error
      };

      // Write to log file
      await appendToFile('.claude/logs/subagent-activity.json', log);

      // Could also update dashboard
      console.log(`
📊 Sub-Agent Activity:
   Agent: ${log.agent}
   Task: ${log.task}
   Status: ${log.success ? '✅ Success' : '❌ Failed'}
   Duration: ${log.duration}ms
      `);
    }

    return { toolName, toolInput, toolOutput };
  }
};
```

---

## 12. Best Practices

### DO:

✅ **Single Responsibility** - Svaki sub-agent jedna clear uloga
✅ **Clear Descriptions** - Orchestrator mora znati kad da pozove
✅ **Minimal Tools** - Samo što agent treba
✅ **Output Standards** - Konzistentan format odgovora
✅ **Permission Control** - Use `ask` za kritične operacije

### DON'T:

❌ **Overlap Responsibilities** - Ne prave 2 agenta istu stvar
❌ **Too Many Tools** - Sub-agent ne treba SVE alate
❌ **Vague Descriptions** - Mora biti jasno šta agent radi
❌ **No Output Format** - Orchestrator mora moći parsirati rezultate

---

## 13. Final Architecture - WUFF Orchestrator

```
┌────────────────────────────────────────────────┐
│ WUFF ORCHESTRATOR (Main Agent)                │
│                                                │
│ Role: Business Partner & Strategic Coordinator│
│ Model: Claude Opus 4.5                         │
│ Tools: Read, Grep, Glob, Task, TodoWrite      │
│                                                │
│ Thinking: Strategic, proactive, questioning    │
└────────────────────────────────────────────────┘
         │
         │ Coordinates via Task tool
         │
    ┌────┴────┬─────────┬────────────┐
    │         │         │            │
    ▼         ▼         ▼            ▼
┌─────────┐ ┌─────────┐ ┌──────────┐ ┌──────────┐
│Business │ │Research │ │   Doc    │ │   Data   │
│Analyst  │ │Specialist│ │  Writer  │ │ Analyst  │
├─────────┤ ├─────────┤ ├──────────┤ ├──────────┤
│Sonnet   │ │Sonnet   │ │  Haiku   │ │ Sonnet   │
│4.5      │ │4.5      │ │          │ │ 4.5      │
└─────────┘ └─────────┘ └──────────┘ └──────────┘
  200k ctx   200k ctx    200k ctx     200k ctx

Total Effective Context: 5 × 200k = 1,000,000 tokens!
```

---

## Sources & References

- [Subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
- [Skills Explained - Claude Blog](https://claude.com/blog/skills-explained)
- [Claude Code Customization Guide](https://alexop.dev/posts/claude-code-customization-guide-claudemd-skills-subagents/)
- [Understanding Claude Code Full Stack](https://alexop.dev/posts/understanding-claude-code-full-stack/)
- [Equipping Agents with Skills - Anthropic](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

---

**Kreirao**: Claude Sonnet 4.5
**Datum**: 2026-01-02
**Za**: WUFF Orchestrator - Production Setup Guide
**Status**: Ready to Implement
