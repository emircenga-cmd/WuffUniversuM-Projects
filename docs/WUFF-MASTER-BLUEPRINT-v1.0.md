# 🧠 WUFF ORCHESTRATOR - MASTER BLUEPRINT v1.0

**Created:** 2025-01-01
**Last Updated:** 2025-01-01
**Status:** Architecture Complete - Ready for Implementation
**Location:** `C:\Projects\Razvijanje Wuff sistema\`

---

# 🚨 CRITICAL CONTEXT - READ THIS FIRST (For Next Claude Session)

## What We're Building:

**WUFF Orchestrator** - Autonomous AI business orchestration system using "Neural Mesh" architecture (3-brain hybrid):

1. **WUFF (Claude Sonnet 3.5)** - Strategic CEO & Architect
   - Role: High-level planning, delegation, decision-making
   - Tools: Extended Thinking, Basic Memory MCP, Sub-agents
   - Location: `C:\AI-Team\` (command center)
   - Memory: `C:\Users\emirv\.basicmemory\` (persistent knowledge graph)

2. **ClickUp Brain (COO)** - Operational Director
   - Role: Task management, workflows, team coordination
   - Integration: Slack, Google Drive, project databases
   - Receives: Mission Briefs from WUFF
   - Note: Autopilot Agent (100-300 credits) cheaper than Super Agent

3. **Gemini Enterprise (Research Head)** - Heavy Data Processor
   - Role: Bulk research, content generation (>10 pieces), data analysis
   - Capability: 2M token context window
   - Receives: Research Mission Briefs from WUFF

## Why This Exists:

- **Problem:** Claude loses context between sessions, can't manage long-term projects autonomously
- **Solution:** Persistent memory (Basic Memory) + delegation protocol + state files
- **Inspiration:** Teresa Torres workflow (interview method, context files, process notes)
- **Difference from Teresa:** She works manually; WUFF delegates to AI agents (parallel execution)

## Where We Are Now:

✅ **Completed:**
- Architecture designed (Neural Mesh + PARA + ECP Protocol)
- Tech stack confirmed (Basic Memory v0.17.2 running, ClickUp subscribed, Gemini planned)
- Workflow methodology established (Teresa patterns + Mission Command)
- Recovery protocols created (auto-resume, session checkpoints)
- Emergency procedures documented

⏸️ **Next Immediate Steps:**
1. Create folder structures (Basic Memory + C:\AI-Team\)
2. Set up Basic Memory as dedicated MCP project
3. Write core files (claude.md, 00_SYSTEM context files)
4. Populate knowledge base via Interview Method
5. Test mini workflow (create test project, delegate Mission Brief)

## Key Decisions Made:

| Decision | Rationale | Implications |
|----------|-----------|--------------|
| **Separate C:\Projects\ from C:\WuffUniversuM\** | Development vs Business orchestration | Two Claude protocols (CLAUDE_MASTER_MEMORY for dev, claude.md for WUFF) |
| **3 Separate Knowledge Bases** | Each AI has different optimal KB type | WUFF (local graph), ClickUp (project specs), Gemini (bulk docs) - overlap managed via links |
| **Basic Memory MUST be Local** | MCP requires filesystem access | Cannot use GDrive Stream mode - use Mirror for backup only |
| **PARA Method for Organization** | Proven structure for action-oriented systems | 00_SYSTEM, 01_STATE, 10_BRAND, 20_KNOWLEDGE, 30_PROJECTS, 99_ARCHIVE |
| **File-Based Mission Briefs** | Human Router latency acceptable initially | Phase 1: Manual copy/paste, Phase 2: ClickUp Autopilot, Phase 3: API |
| **Interview Method for KB Population** | Token efficiency + user control | Don't write manually - WUFF asks questions, user answers, context builds organically |
| **Extended Thinking for Strategy** | "Think harder" = deeper planning | Use before major decisions, architectural changes, problem-solving |

## Research Items Still Needed:

### Priority 1 (Immediate):
- [ ] **Basic Memory Best Practices**: WikiLink graph optimization, folder structure patterns, search syntax
- [ ] **ClickUp KB Setup**: Doc formatting for Brain search, folder hierarchy, tagging strategy
- [ ] **GDrive Sync Options**: Mirror vs Stream performance, selective sync for hybrid setup

### Priority 2 (Before Full Implementation):
- [ ] **ClickUp Autopilot Agent**: Capabilities, limitations, workflow automation patterns
- [ ] **Mission Brief Template Refinement**: Format that works across all 3 systems
- [ ] **State File Protocol**: Update frequency, conflict resolution, versioning

### Priority 3 (Optimization):
- [ ] **Gemini Enterprise Workflow**: Best practices for bulk processing, API vs UI decision
- [ ] **Weekly Review Process**: SOP_Registry.md maintenance, archive criteria
- [ ] **Git Integration for Basic Memory**: Auto-commit strategy, branch management

## Resume Command (If This Session Breaks):

```
Pročitaj C:\Projects\Razvijanje Wuff sistema\WUFF-MASTER-BLUEPRINT-v1.0.md

Fokusiraj se na "CRITICAL CONTEXT" sekciju na vrhu.
Trenutni task: Implementacija prema Implementation Roadmap - Week 1.
```

---

# 📐 ARCHITECTURE OVERVIEW

## Neural Mesh - 4-Layer System

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 1: STRATEGIC ORCHESTRATION                               │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  WUFF (Claude Sonnet 3.5 via Claude Code)               │   │
│  │  • Extended Thinking for deep planning                  │   │
│  │  • Basic Memory MCP for persistent context              │   │
│  │  • Sub-agents: @architect, @researcher, @validator      │   │
│  │  • Reads: claude.md + context files (not full KB)       │   │
│  │  • Writes: Mission Briefs, State Files, Process Notes   │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
              ↓ Mission Briefs (file-based delegation)
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 2: OPERATIONAL EXECUTION                                 │
│  ┌────────────────────────┐  ┌────────────────────────────┐    │
│  │  ClickUp Brain (COO)   │  │  Gemini (Research Head)    │    │
│  │  • Autopilot Agents    │  │  • 2M token context        │    │
│  │  • Task workflows      │  │  • Bulk content gen        │    │
│  │  • Deadline mgmt       │  │  • Data analysis           │    │
│  │  • Team coordination   │  │  • Long-form research      │    │
│  └────────────────────────┘  └────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
              ↓ Task Completion Reports (back to WUFF)
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 3: PERSISTENT MEMORY (Knowledge Graph)                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Basic Memory (Local MCP)                                │   │
│  │  C:\Users\emirv\.basicmemory\                            │   │
│  │  • 00_SYSTEM (operating rules)                           │   │
│  │  • 01_STATE (active projects, current focus)             │   │
│  │  • 10_BRAND (identity, voice, guidelines)                │   │
│  │  • 20_KNOWLEDGE (workflows, learnings)                   │   │
│  │  • 30_PROJECTS (ECP Protocol - specs, states, decisions) │   │
│  │  • 99_ARCHIVE (completed work)                           │   │
│  │  • Synced: GDrive Mirror (backup only, not searchable)   │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
              ↓ Context retrieval via MCP
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 4: HUMAN INTERFACE                                       │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Emir (CEO / Human Router)                               │   │
│  │  • Strategic input & approval                            │   │
│  │  • Mission Brief execution (copy/paste to ClickUp/Gemini)│   │
│  │  • Weekly review & gardening                             │   │
│  │  • External research (claude.ai/ChatGPT)                 │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

## Information Flow Patterns

### Pattern 1: Strategic Decision → Execution
```
1. WUFF analyzes situation (Extended Thinking)
2. WUFF creates Mission Brief → saves to pending/
3. Human Router copies Mission Brief → pastes to ClickUp/Gemini
4. Agent executes task
5. Human Router copies result → saves to completed/
6. WUFF reads result → updates State files & Basic Memory
```

### Pattern 2: New Project Initiation
```
1. Emir describes goal to WUFF
2. WUFF interviews Emir (context gathering)
3. WUFF creates 30_PROJECTS/[project-name]/ folder:
   - PROJECT_SPEC.md (immutable requirements)
   - ACTIVE_STATE.md (current progress)
   - ARCHITECTURE.md (technical design)
   - DECISION_LOG.md (why choices were made)
4. WUFF delegates tasks via Mission Briefs
5. WUFF tracks progress in ACTIVE_STATE.md
6. On completion → archive to 99_ARCHIVE/
```

### Pattern 3: Knowledge Base Population (Interview Method)
```
1. WUFF identifies missing context (e.g., "I need brand voice guidelines")
2. WUFF generates interview questions → asks Emir
3. Emir answers (voice notes transcribed, or written)
4. WUFF creates structured note in appropriate folder:
   - 10_BRAND/Voice_Tone.md
   - Uses WikiLinks for relationships: [[Target Audiences]], [[Brand Guidelines]]
5. WUFF updates SOP_Registry.md index
6. Next session: WUFF reads index, loads relevant context via links
```

### Pattern 4: Session Continuity
```
1. Session ends (timeout, token limit, crash)
2. WUFF updates 01_STATE/Current_Focus.md automatically
3. WUFF updates Session Notes (WUFF-Setup-Session-XXX-Notes.md)
4. Emir opens new Claude session
5. Claude auto-reads CLAUDE_RESUME_INSTRUCTIONS.md
6. Claude loads latest Session Notes or Current_Focus.md
7. Claude greets: "Context loaded. Continue where stopped?"
8. Emir confirms → seamless continuation
```

---

# 🗄️ THREE KNOWLEDGE BASE STRATEGY

## Why 3 Separate KBs?

Each AI system has optimal KB characteristics:

| System | Optimal KB Type | Why | What Goes Here |
|--------|----------------|-----|----------------|
| **WUFF (Basic Memory)** | Local graph (Markdown + WikiLinks) | Fast retrieval, MCP requirement, context graph | Strategic decisions, process notes, SOP registry, project states |
| **ClickUp Brain** | Structured docs in project hierarchy | Integration with tasks, searchable by Brain, team-visible | Project specs, brand guidelines, team workflows, task templates |
| **Gemini** | Raw docs in GDrive folders | 2M token window handles bulk data, team collaboration | Research materials, long-form content, data dumps, shared resources |

## Overlap Management Protocol

**Problem:** Same info in 3 places = sync nightmare

**Solution:** Master Copy + Links

### Example: Brand Guidelines

**Master Copy:** `C:\Users\emirv\.basicmemory\10_BRAND\Brand_Guidelines.md`
- Full details (voice, tone, colors, logos, examples)
- Updated here ONLY
- Source of truth

**ClickUp Copy:** `WuffUniversuM Project > Brand Assets > Brand Guidelines Summary`
- High-level overview (1-page)
- Link to: "Full details in WUFF Basic Memory (ask Emir)"
- Updated: Monthly or on major changes

**Gemini Copy:** `GDrive > WuffUniversuM Shared > Brand > Brand Guidelines - Visual Assets.pdf`
- Visual examples (logo files, color palettes)
- Design templates
- Updated: When visual assets change

### Sync Protocol

**Weekly Gardening (Sunday):**
- [ ] WUFF reads SOP_Registry.md
- [ ] Checks for updates in past week
- [ ] Generates "Sync Checklist" Mission Brief
- [ ] Emir updates ClickUp summaries if needed
- [ ] Archive old versions in 99_ARCHIVE/

**When Info Changes:**
1. Update master copy (Basic Memory or GDrive, depending on type)
2. Note change in 01_STATE/Updates_This_Week.md
3. Flag for weekly sync
4. Don't panic if temporarily out of sync (master is truth)

---

# 📂 PARA FOLDER STRUCTURE (Detailed)

## C:\Users\emirv\.basicmemory\ (WUFF's Persistent Brain)

```
.basicmemory/
│
├── 00_SYSTEM/                       # Meta - How System Works (Rarely Changes)
│   ├── Orchestrator_Identity.md    # Who is WUFF? Personality, role, boundaries
│   ├── SOP_Registry.md              # Index of all procedures (links to 20_KNOWLEDGE)
│   ├── Agent_Protocols.md           # How to delegate to ClickUp/Gemini/sub-agents
│   ├── MCP_Servers.md               # Installed MCPs, capabilities, authentication
│   ├── Context_Loading_Rules.md    # What to read on session start (read index, not all files)
│   └── Update_Protocol.md           # When/how to update this system
│
├── 01_STATE/                        # Working Memory (Daily Updates)
│   ├── Current_Focus.md             # What's active RIGHT NOW (read first every session)
│   ├── Active_Projects.md           # List of projects in 30_PROJECTS/ with status
│   ├── Today.md                     # Daily priorities, quick capture
│   ├── This_Week.md                 # Week goals, deadlines
│   ├── Decisions_This_Week.md       # Recent strategic choices (for continuity)
│   ├── Waiting_On.md                # Blocked items (waiting for Emir, external, etc.)
│   └── Updates_This_Week.md         # Changes to knowledge base (for weekly sync)
│
├── 10_BRAND/                        # Brand Identity (Semi-Permanent)
│   ├── Brand_Guidelines.md          # Master brand doc (voice, tone, colors, values)
│   ├── Voice_Tone.md                # How WUFF/WuffUniversuM communicates
│   ├── Target_Audiences.md          # Customer personas, segments
│   ├── Visual_Identity.md           # Logo usage, color codes, design system
│   ├── Messaging_Framework.md       # Key messages, positioning, taglines
│   └── Competitor_Analysis.md       # Market positioning, differentiation
│
├── 20_KNOWLEDGE/                    # Encyclopedia (Reference Materials)
│   ├── Workflows/
│   │   ├── Mission_Brief_Template.md
│   │   ├── Project_Initiation_SOP.md
│   │   ├── Weekly_Review_Checklist.md
│   │   ├── Interview_Method_Guide.md
│   │   └── Emergency_Recovery_SOP.md
│   │
│   ├── Tech_Stack/
│   │   ├── Basic_Memory_Setup.md
│   │   ├── ClickUp_Configuration.md
│   │   ├── Claude_Code_Capabilities.md
│   │   ├── MCP_Best_Practices.md
│   │   └── Git_Workflow.md
│   │
│   └── Learnings/
│       ├── What_Worked.md           # Successes to replicate
│       ├── What_Didnt_Work.md       # Mistakes to avoid
│       ├── Teresa_Torres_Insights.md
│       └── Optimization_Ideas.md
│
├── 30_PROJECTS/                     # Active Work (ECP Protocol)
│   ├── wuff-orchestrator-setup/    # This very project
│   │   ├── PROJECT_SPEC.md          # Goal: Build WUFF system (immutable)
│   │   ├── ACTIVE_STATE.md          # Current: Architecture complete, folder setup next
│   │   ├── ARCHITECTURE.md          # Neural Mesh design, tech decisions
│   │   ├── DECISION_LOG.md          # Why 3 KBs? Why PARA? Why local Basic Memory?
│   │   └── Process_Notes.md         # Session-by-session work log
│   │
│   ├── [future-project-1]/
│   │   ├── PROJECT_SPEC.md
│   │   ├── ACTIVE_STATE.md
│   │   ├── ARCHITECTURE.md
│   │   ├── DECISION_LOG.md
│   │   └── Process_Notes.md
│   │
│   └── Templates/
│       ├── PROJECT_SPEC_template.md
│       ├── ACTIVE_STATE_template.md
│       └── DECISION_LOG_template.md
│
└── 99_ARCHIVE/                      # Completed Work (Read-Only)
    ├── 2025-Q1/
    │   └── [archived projects from Q1]
    ├── 2025-Q2/
    └── Deprecated/
        └── [old SOPs, outdated docs]
```

## C:\AI-Team\ (Command Center - WUFF Orchestrator Working Directory)

```
AI-Team/
│
├── claude.md                        # ORCHESTRATOR PROTOCOL (WUFF's main brain)
│                                    # Read first every session when in this folder
│                                    # Contains: Identity, role, context loading rules
│                                    # Links to: 00_SYSTEM files, current projects
│
├── .claude/
│   └── agents/                      # Sub-agents for delegation
│       ├── architect.md             # System design specialist
│       ├── researcher.md            # Deep analysis, web search
│       ├── validator.md             # QA, testing, error detection
│       └── scribe.md                # Documentation, note-taking
│
├── mission-briefs/                  # Delegation Queue
│   ├── pending/                     # Mission Briefs waiting for execution
│   │   ├── clickup/
│   │   │   └── 2025-01-15_setup-project-tracking.md
│   │   └── gemini/
│   │       └── 2025-01-16_research-competitors.md
│   │
│   ├── in-progress/                 # Currently being executed
│   │   └── clickup/
│   │       └── 2025-01-14_create-brand-board.md
│   │
│   └── completed/                   # Finished (with results)
│       └── gemini/
│           └── 2025-01-13_market-research_RESULTS.md
│
├── templates/                       # Reusable Templates
│   ├── mission-brief-clickup.md
│   ├── mission-brief-gemini.md
│   ├── project-spec.md
│   └── weekly-review.md
│
├── deliverables/                    # Final Outputs (for external use)
│   ├── client-reports/
│   ├── internal-docs/
│   └── presentations/
│
└── scratch/                         # Temporary workspace
    └── [delete weekly]
```

---

# 🛠️ BASIC MEMORY SETUP (Detailed Instructions)

## Phase 1: Folder Structure Creation

**Location:** `C:\Users\emirv\.basicmemory\`

**Method:** Use Claude Code (from C:\Projects\ or C:\AI-Team\)

```bash
# Create main folders
mkdir C:\Users\emirv\.basicmemory\00_SYSTEM
mkdir C:\Users\emirv\.basicmemory\01_STATE
mkdir C:\Users\emirv\.basicmemory\10_BRAND
mkdir C:\Users\emirv\.basicmemory\20_KNOWLEDGE
mkdir C:\Users\emirv\.basicmemory\30_PROJECTS
mkdir C:\Users\emirv\.basicmemory\99_ARCHIVE

# Create subfolders
mkdir C:\Users\emirv\.basicmemory\20_KNOWLEDGE\Workflows
mkdir C:\Users\emirv\.basicmemory\20_KNOWLEDGE\Tech_Stack
mkdir C:\Users\emirv\.basicmemory\20_KNOWLEDGE\Learnings
mkdir C:\Users\emirv\.basicmemory\30_PROJECTS\Templates
mkdir C:\Users\emirv\.basicmemory\30_PROJECTS\wuff-orchestrator-setup
mkdir C:\Users\emirv\.basicmemory\99_ARCHIVE\2025-Q1
```

**Verification:**
```bash
dir C:\Users\emirv\.basicmemory\
# Should show: 00_SYSTEM, 01_STATE, 10_BRAND, 20_KNOWLEDGE, 30_PROJECTS, 99_ARCHIVE
```

## Phase 2: Core System Files (00_SYSTEM)

**Do NOT write manually!** Use Interview Method:

### Interview for Orchestrator_Identity.md

**WUFF asks Emir:**
```
1. How should WUFF introduce itself? (Personality: professional, friendly, technical?)
2. What are WUFF's core responsibilities? (Strategy only, or execution too?)
3. What should WUFF NEVER do? (Boundaries: never commit without asking, never delete archives, etc.)
4. How should WUFF make decisions when uncertain? (Default to asking Emir, or use Extended Thinking?)
5. What's WUFF's relationship to ClickUp Brain? (Superior, peer, coordinator?)
```

**WUFF creates file based on answers:**
```markdown
# Orchestrator Identity: WUFF

**Role:** Strategic CEO & Autonomous Business Orchestrator
**Personality:** [Based on Emir's answers]
**Core Responsibilities:** [From interview]
**Boundaries:** [Never do X, Y, Z]
**Decision Protocol:** [When uncertain, do this...]
**Relationship Map:** [[ClickUp Brain]], [[Gemini]], [[Emir]]

## Introduction Script:
"I'm WUFF, your strategic orchestrator..."
```

### SOP_Registry.md (Index, not content)

**Structure:**
```markdown
# SOP Registry - Procedure Index

## Strategic Planning:
- [[Project Initiation SOP]] - How to start new projects
- [[Weekly Review Checklist]] - Sunday gardening routine
- [[Decision Framework]] - When to use Extended Thinking

## Delegation:
- [[Mission Brief Template]] - Format for ClickUp/Gemini delegation
- [[Sub-Agent Protocols]] - When to use @architect, @researcher, etc.

## Memory Management:
- [[Context Loading Rules]] - What to read on session start
- [[State File Update Protocol]] - When to update Current_Focus.md
- [[Archive Criteria]] - When to move projects to 99_ARCHIVE

## Recovery:
- [[Emergency Recovery SOP]] - Auth timeout, crashes, token limits
- [[Session Checkpoint Protocol]] - How to save state mid-session

---
*Last Updated: [Auto-update on SOP changes]*
```

### Agent_Protocols.md

**Interview Questions:**
```
1. When should WUFF delegate to ClickUp vs Gemini vs sub-agents?
2. What level of detail should Mission Briefs contain? (High-level goal vs step-by-step?)
3. How should WUFF handle failed delegations? (Retry, escalate, rethink?)
4. What's the expected turnaround time for each agent type?
```

**Template:**
```markdown
# Agent Delegation Protocols

## ClickUp Brain (COO)
**Delegate when:**
- Task involves deadlines, assignments, workflows
- Multiple steps with dependencies
- Needs task tracking, status updates
- Team coordination required

**Don't delegate when:**
- Task requires Extended Thinking (strategic)
- Quick one-off question
- File creation in Basic Memory (WUFF does this)

**Mission Brief Format:** [[Mission Brief Template - ClickUp]]

## Gemini Enterprise (Research Head)
**Delegate when:**
- Bulk content generation (>10 pieces)
- Long-form research (>50 pages of reading)
- Data analysis (large datasets)
- Needs 2M token context window

**Don't delegate when:**
- Quick lookup (use web search)
- Strategic decision (WUFF Extended Thinking)
- Requires real-time feedback (interactive)

**Mission Brief Format:** [[Mission Brief Template - Gemini]]

## Sub-Agents (@architect, @researcher, @validator, @scribe)
**Delegate when:**
- WUFF needs specialized deep dive (architecture design)
- Parallel research on multiple topics
- Code review, testing, validation
- Documentation generation from notes

**Don't delegate when:**
- Task requires cross-agent coordination (WUFF orchestrates)
- Decision-making (sub-agents recommend, WUFF decides)

**Invocation:** `@architect analyze this system design...`
```

## Phase 3: Initial State Files (01_STATE)

### Current_Focus.md (Created by WUFF at session start)

**Auto-generated template:**
```markdown
# Current Focus - [Date]

**Active Project:** [[wuff-orchestrator-setup]]
**Current Phase:** Folder structure creation
**Next Step:** Create 00_SYSTEM files via Interview Method

**Blocked On:** Nothing
**Waiting For:** Emir's answers to Orchestrator Identity interview

**Session Goal:** Complete Basic Memory setup, test first workflow

**Context Loaded:**
- WUFF-Setup-Session-001-Notes.md
- WUFF-MASTER-BLUEPRINT-v1.0.md

**Last Updated:** [Auto-timestamp]
```

### Active_Projects.md

```markdown
# Active Projects - [Date]

| Project | Status | Phase | Next Action | Deadline |
|---------|--------|-------|-------------|----------|
| [[wuff-orchestrator-setup]] | 🟡 In Progress | Setup | Create 00_SYSTEM files | None (foundational) |

**Legend:**
- 🟢 Active & on track
- 🟡 In progress, needs attention
- 🔴 Blocked
- ⚪ Paused
- ✅ Complete (archive soon)

**Last Updated:** [Auto-timestamp]
```

## Phase 4: GDrive Sync Setup (Mirror Mode)

**Why Mirror:** Basic Memory MUST be local (MCP requirement), but we want backup.

**Steps:**

1. **Open Google Drive Desktop Settings:**
   - Right-click GDrive icon in system tray
   - Click "Preferences"
   - Go to "Google Drive" tab

2. **Change Sync Mode:**
   - Find current setting (likely "Stream files")
   - Change to "Mirror files"
   - **WARNING:** This downloads ALL GDrive files locally - check disk space!

3. **Selective Sync (Alternative if disk space limited):**
   - Keep "Stream files" as default
   - Right-click specific folders → "Available offline"
   - Apply to: `WuffUniversuM Brain\Memory-Graph` folder only

4. **Create Sync Folder:**
   ```bash
   # In GDrive folder (synced to cloud):
   mkdir "G:\My Drive\WuffUniversuM Brain\Memory-Graph"

   # Symlink or manual sync (weekly):
   # Option A: Robocopy (Windows)
   robocopy C:\Users\emirv\.basicmemory "G:\My Drive\WuffUniversuM Brain\Memory-Graph" /MIR /Z

   # Option B: Schedule via Task Scheduler (weekly backup)
   ```

5. **Exclude from ClickUp Brain Search:**
   - ClickUp Brain searches GDrive
   - We DON'T want it indexing raw Basic Memory files (use summaries instead)
   - Solution: Keep Memory-Graph in separate folder, don't share with ClickUp

## Research Items for Basic Memory

**Before full implementation, investigate:**

### Research Item 1: WikiLink Best Practices
**Questions:**
- How deep should link hierarchies go? (max 3 levels? 5 levels?)
- Bidirectional links: Manual or automatic?
- Tag vs folder vs link - when to use each?
- Graph visualization: How to avoid spaghetti?

**Research Method:**
- Obsidian community forums (they use WikiLinks heavily)
- Basic Memory GitHub issues/discussions
- Zettelkasten methodology articles

**Output:** `20_KNOWLEDGE/Tech_Stack/WikiLink_Best_Practices.md`

### Research Item 2: Search Syntax
**Questions:**
- How to search Basic Memory via MCP? (exact syntax)
- Can search use tags? Regex? Fuzzy matching?
- Performance: How many files before search slows down?

**Research Method:**
- Basic Memory documentation (v0.17.2 release notes)
- MCP server capabilities API
- Test with dummy files

**Output:** `20_KNOWLEDGE/Tech_Stack/Basic_Memory_Search.md`

### Research Item 3: File Naming Conventions
**Questions:**
- Spaces vs underscores vs hyphens?
- Date prefixes (YYYY-MM-DD) or suffixes?
- Plurals (Projects/ vs Project/)?
- Special characters to avoid?

**Research Method:**
- Check Basic Memory server code for filename parsing
- Test edge cases (special chars, long names)
- Obsidian compatibility check

**Output:** `20_KNOWLEDGE/Tech_Stack/File_Naming_Standards.md`

---

# 🎯 C:\AI-Team\ SETUP (Command Center)

## Phase 1: Folder Creation

```bash
# Create main structure
mkdir C:\AI-Team
mkdir C:\AI-Team\.claude\agents
mkdir C:\AI-Team\mission-briefs\pending\clickup
mkdir C:\AI-Team\mission-briefs\pending\gemini
mkdir C:\AI-Team\mission-briefs\in-progress
mkdir C:\AI-Team\mission-briefs\completed
mkdir C:\AI-Team\templates
mkdir C:\AI-Team\deliverables
mkdir C:\AI-Team\scratch
```

## Phase 2: claude.md (WUFF's Main Brain)

**Location:** `C:\AI-Team\claude.md`

**Purpose:** First file Claude reads when opened in C:\AI-Team\ directory

**Template:**
```markdown
# 🧠 WUFF ORCHESTRATOR PROTOCOL

**Identity:** Strategic CEO & Autonomous Business Orchestrator
**Version:** 1.0
**Last Updated:** [Auto-update]

---

## 🚨 SESSION START PROTOCOL

When Claude opens in `C:\AI-Team\` directory:

### STEP 1: Load Strategic Context
**DO NOT read entire Basic Memory!** Read index files only:

```bash
# Priority order:
1. C:\Users\emirv\.basicmemory\01_STATE\Current_Focus.md
2. C:\Users\emirv\.basicmemory\01_STATE\Active_Projects.md
3. C:\Users\emirv\.basicmemory\00_SYSTEM\SOP_Registry.md (index only)
```

**Why index-only:** Token efficiency. Load full files only when relevant to current task.

### STEP 2: Greet & Confirm
```
"🟢 WUFF Orchestrator Active

Current Focus: [from Current_Focus.md]
Active Projects: [count from Active_Projects.md]

What would you like to work on?
A) Continue current focus
B) Switch project
C) New strategic planning session
D) Weekly review"
```

### STEP 3: Proceed Based on User Input
- If continuing → Load relevant project files from 30_PROJECTS/
- If new planning → Use Extended Thinking
- If weekly review → Follow [[Weekly Review Checklist]]

---

## 🎭 ORCHESTRATOR IDENTITY

**I am WUFF. I do NOT:**
- ❌ Execute tasks directly (I delegate via Mission Briefs)
- ❌ Write content manually (I assign to Gemini)
- ❌ Manage task deadlines (I delegate to ClickUp Brain)
- ❌ Make decisions without thinking (I use Extended Thinking)
- ❌ Forget context (I persist to Basic Memory)

**I DO:**
- ✅ Strategic planning & architecture
- ✅ Delegation via Mission Command Protocol
- ✅ Decision-making with Extended Thinking
- ✅ Context management (State files, Process notes)
- ✅ Quality control (validate delegated work)
- ✅ Learning & adaptation (update SOPs based on outcomes)

**My relationship to Emir:**
- Emir = CEO (final authority, strategic direction)
- WUFF = COO + CTO (autonomous execution within boundaries)
- I propose, Emir approves (major decisions)
- I execute, Emir reviews (tactical work)

---

## 🛠️ CORE WORKFLOWS

### Workflow 1: Project Initiation
See: [[Project Initiation SOP]] in Basic Memory

**Quick Reference:**
1. Interview Emir (gather context)
2. Create project folder in 30_PROJECTS/
3. Write PROJECT_SPEC.md (immutable goal)
4. Write ARCHITECTURE.md (technical design)
5. Initialize ACTIVE_STATE.md (current progress)
6. Create first Mission Briefs (delegate to ClickUp/Gemini)
7. Update Active_Projects.md

### Workflow 2: Mission Brief Delegation
See: [[Mission Brief Template]] in Basic Memory

**Quick Reference:**
1. Identify task suitable for delegation (operational, research, bulk work)
2. Choose agent (ClickUp vs Gemini vs sub-agent)
3. Write Mission Brief:
   - Objective (what, not how)
   - Context (background, constraints)
   - Success criteria (how to verify completion)
   - Deadline (if any)
   - Output format (doc, list, report, etc.)
4. Save to mission-briefs/pending/[agent-type]/
5. Tell Emir: "Mission Brief ready - copy to [ClickUp/Gemini]"
6. Wait for result in mission-briefs/completed/
7. Review result → Update ACTIVE_STATE.md

### Workflow 3: Extended Thinking Protocol
**When to use:**
- Architectural decisions (tech stack, system design)
- Strategic planning (quarterly goals, new initiatives)
- Problem-solving (complex bugs, trade-offs)
- Uncertainty (multiple valid approaches)

**How to use:**
1. Emir says "think harder" or "ultrathink"
2. Activate Extended Thinking mode
3. Analyze deeply (explore alternatives, consider risks)
4. Document reasoning in DECISION_LOG.md
5. Present recommendation with rationale
6. Wait for Emir's approval before proceeding

### Workflow 4: Session Checkpoint
**When to use:**
- Token usage >70% (140K/200K)
- End of work session
- Before major context switch
- User says "checkpoint" or "save state"

**How to do:**
1. Update 01_STATE/Current_Focus.md (what's active now)
2. Update 01_STATE/Active_Projects.md (project statuses)
3. Update relevant ACTIVE_STATE.md files (project progress)
4. Create/update Session Notes if long session
5. Confirm to Emir: "Checkpoint saved. Resume with: [command]"

---

## 📚 CONTEXT FILES (Links to Basic Memory)

**DO NOT copy content here!** Link to source of truth:

### System Rules:
- [[Orchestrator Identity]] - `00_SYSTEM/Orchestrator_Identity.md`
- [[SOP Registry]] - `00_SYSTEM/SOP_Registry.md`
- [[Agent Protocols]] - `00_SYSTEM/Agent_Protocols.md`
- [[MCP Servers]] - `00_SYSTEM/MCP_Servers.md`

### Brand Context:
- [[Brand Guidelines]] - `10_BRAND/Brand_Guidelines.md`
- [[Voice & Tone]] - `10_BRAND/Voice_Tone.md`
- [[Target Audiences]] - `10_BRAND/Target_Audiences.md`

### Workflows:
- [[Mission Brief Template]] - `20_KNOWLEDGE/Workflows/Mission_Brief_Template.md`
- [[Project Initiation SOP]] - `20_KNOWLEDGE/Workflows/Project_Initiation_SOP.md`
- [[Weekly Review Checklist]] - `20_KNOWLEDGE/Workflows/Weekly_Review_Checklist.md`

### Active Projects:
- [[WUFF Orchestrator Setup]] - `30_PROJECTS/wuff-orchestrator-setup/`

---

## 🔗 MCP SERVERS AVAILABLE

**Basic Memory:**
- Path: `C:\Users\emirv\.basicmemory\`
- Capabilities: create_note, read_note, search_notes, update_note
- Auth: Local filesystem (no API key needed)
- Status: ✅ Active

**Obsidian (WuffUniversuM Vault):**
- Path: `C:\WuffUniversuM\Basic Memory i Obsidian\WuffUniversuM Vault\`
- Capabilities: read, write, search (via REST API MCP)
- Auth: API key in config
- Status: ✅ Active

**Obsidian (Emir Vault):**
- Path: `C:\WuffUniversuM\Basic Memory i Obsidian\Emir Vault\`
- Capabilities: read, write (manual notes, not WUFF context)
- Auth: API key in config
- Status: ✅ Active (but WUFF uses Basic Memory primarily)

---

## 🚫 ANTI-PATTERNS (Never Do This)

❌ Reading entire Basic Memory on session start (token waste)
✅ Read Current_Focus.md + Active_Projects.md only (then load specific files as needed)

❌ Writing Mission Briefs with step-by-step instructions (micromanagement)
✅ Write high-level objective + success criteria (Mission Command)

❌ Making strategic decisions without Extended Thinking
✅ "Think harder" before architecture, major features, trade-offs

❌ Forgetting to update ACTIVE_STATE.md after progress
✅ Update state files immediately after completing work

❌ Executing tasks directly when should delegate
✅ Ask: "Could ClickUp/Gemini do this?" If yes → delegate

❌ Assuming context from previous session (might be different Claude instance)
✅ Always read Current_Focus.md first, verify context

---

**END OF ORCHESTRATOR PROTOCOL**

*This file is WUFF's identity. Update when workflows evolve.*
```

## Phase 3: Sub-Agent Files

**Purpose:** Specialized agents for specific tasks

### .claude/agents/architect.md

```markdown
# 🏗️ Architect Agent

**Role:** System design specialist
**When to invoke:** Complex architecture decisions, technical design, scalability planning

**Capabilities:**
- Analyze system requirements → propose architecture
- Evaluate trade-offs (performance, cost, complexity)
- Design database schemas, API structures
- Create technical diagrams (mermaid syntax)

**Example Invocation:**
```
@architect analyze the proposed 3-brain knowledge base architecture.
Identify potential bottlenecks, failure modes, and optimization opportunities.
```

**Output Format:**
- Analysis document (Markdown)
- Diagrams (Mermaid)
- Recommendations with rationale
- Risk assessment
```

### .claude/agents/researcher.md

```markdown
# 🔍 Researcher Agent

**Role:** Deep analysis, web research, documentation review
**When to invoke:** Need to investigate unfamiliar tech, analyze docs, compare options

**Capabilities:**
- Web search (if MCP available)
- Document analysis (summarize long docs)
- Comparison matrices (Tool A vs Tool B)
- Best practices research

**Example Invocation:**
```
@researcher investigate ClickUp Autopilot Agent capabilities.
Find: pricing, limitations, workflow examples, community feedback.
Output: Comparison table + recommendation.
```

**Output Format:**
- Research report (structured Markdown)
- Sources cited (links)
- Summary + detailed findings
- Recommendation (if applicable)
```

### .claude/agents/validator.md

```markdown
# ✅ Validator Agent

**Role:** QA, testing, error detection, verification
**When to invoke:** Before finalizing architecture, after delegated work, pre-launch

**Capabilities:**
- Review Mission Brief outputs (check completeness)
- Validate file structures (correct folders, naming)
- Check WikiLink integrity (no broken links)
- Verify SOP compliance

**Example Invocation:**
```
@validator review the completed Basic Memory folder structure.
Check: naming conventions, required files present, WikiLinks valid.
```

**Output Format:**
- Validation report (pass/fail)
- Issues found (list)
- Recommendations (fixes)
- Re-validation checklist
```

### .claude/agents/scribe.md

```markdown
# 📝 Scribe Agent

**Role:** Documentation, note-taking, summarization
**When to invoke:** Convert interview answers to structured notes, summarize long sessions

**Capabilities:**
- Structure raw notes into Markdown
- Create WikiLink relationships
- Summarize long conversations
- Generate templates from examples

**Example Invocation:**
```
@scribe convert Emir's interview answers into Orchestrator_Identity.md.
Use WikiLinks for related concepts. Follow 00_SYSTEM file format.
```

**Output Format:**
- Structured Markdown document
- WikiLinks added appropriately
- Formatted for readability
- Saved to correct location
```

---

# 📖 TERESA TORRES WORKFLOW INSIGHTS (Extracted Best Practices)

## Context from Analysis

Teresa Torres is a product discovery coach who uses Claude Code extensively. Her workflow provides proven patterns for long-term context management.

## Key Patterns We're Adopting

### Pattern 1: Interview Method (Not Manual Writing)

**What Teresa Does:**
- She doesn't manually write context files
- Instead, Claude interviews her with targeted questions
- Her answers become structured notes
- This builds knowledge base organically

**How WUFF Uses This:**
```
WUFF: "I need brand voice guidelines to write Mission Briefs consistently.
I'm going to ask you 10 questions about WuffUniversuM's voice and tone.
Your answers will become 10_BRAND/Voice_Tone.md.

Question 1: How should WUFF communicate with ClickUp Brain - formal or casual?
Question 2: When delegating to Gemini, what tone works best?
..."

Emir answers → WUFF creates structured file with WikiLinks
```

**Benefits:**
- Token efficient (answers are concise)
- User stays in control (not auto-generated)
- Context is immediately usable
- Easier for user than "write a doc"

### Pattern 2: Context Files (Index, Not Content)

**What Teresa Does:**
- Her claude.md file is SHORT (~2-3 pages)
- It links to context files, doesn't duplicate content
- Claude loads specific files only when needed

**WUFF Implementation:**
```markdown
# claude.md (in C:\AI-Team\)

## Brand Context (Don't copy here - link only):
- [[Brand Guidelines]] → C:\Users\emirv\.basicmemory\10_BRAND\Brand_Guidelines.md
- [[Voice & Tone]] → C:\Users\emirv\.basicmemory\10_BRAND\Voice_Tone.md

When needed: Load via Basic Memory MCP, don't paste into claude.md
```

**Why This Works:**
- claude.md stays small (loads fast every session)
- Full context is in Basic Memory (versioned, searchable)
- No duplication = no sync issues

### Pattern 3: Process Notes (Long Projects)

**What Teresa Does:**
- For multi-session projects, she keeps running notes
- Each session appends to Process_Notes.md
- Format: Date + What was done + Decisions + Next steps

**WUFF Implementation:**
```markdown
# Process Notes - WUFF Orchestrator Setup
# Location: 30_PROJECTS/wuff-orchestrator-setup/Process_Notes.md

## 2025-01-01 - Session 001
**Completed:**
- Analyzed Teresa workflow patterns
- Reviewed WUFF architecture docs
- Made critical decision: 3 separate KBs (not 1 unified)

**Decisions:**
- Basic Memory must be local (MCP requirement)
- Use GDrive Mirror for backup only
- Interview Method for KB population

**Next Session:**
- Create folder structures
- Write core 00_SYSTEM files
- First test workflow

---

## 2025-01-08 - Session 002 (Future)
**Completed:**
- [To be filled next session]
...
```

**Benefits:**
- Continuity across sessions (read Process_Notes to catch up)
- Decision history preserved (why did we choose X?)
- No need to remember everything (notes = external memory)

### Pattern 4: Ask Before Act (Teresa's Golden Rule)

**What Teresa Does:**
- Claude proposes actions, waits for approval
- Uses "Plan Mode" before implementation
- Explains trade-offs, then lets Teresa decide

**WUFF Implementation:**
```
WUFF: "I'm about to create the Basic Memory folder structure.
This will create 6 top-level folders: 00_SYSTEM, 01_STATE, 10_BRAND, 20_KNOWLEDGE, 30_PROJECTS, 99_ARCHIVE.

Before I proceed:
1. Review folder structure in blueprint (Section: PARA Folder Structure)
2. Confirm this matches your mental model
3. Let me know if any changes needed

Proceed? (yes/no/modify)"

Emir: "yes"

WUFF: [Creates folders]
```

**Why This Matters:**
- User stays in control (no surprises)
- Prevents rework (catch issues before execution)
- Builds trust (WUFF doesn't "go rogue")

### Pattern 5: Templates Over Examples

**What Teresa Does:**
- She creates reusable templates
- Claude fills templates, doesn't create from scratch each time
- Templates encode best practices

**WUFF Implementation:**

**Mission Brief Template (ClickUp):**
```markdown
# Mission Brief: [Task Name]
**Date:** [YYYY-MM-DD]
**Agent:** ClickUp Brain
**Delegated By:** WUFF Orchestrator
**Priority:** [High/Medium/Low]

## OBJECTIVE:
[What needs to be accomplished - high-level goal, not step-by-step]

## CONTEXT:
[Why this matters, background info, constraints]

## SUCCESS CRITERIA:
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]
- [ ] [How to verify completion]

## DEADLINE:
[Date, or "No deadline - strategic"]

## OUTPUT FORMAT:
[What deliverable is expected: Doc, list, board setup, etc.]

## RESOURCES:
- [Link to relevant docs]
- [Related projects]
- [[Context in Basic Memory]]

---
**Instructions for ClickUp Brain:**
[Specific guidance if needed, but prefer high-level Mission Command]
```

**Usage:**
1. WUFF copies template
2. Fills in bracketed sections
3. Saves to mission-briefs/pending/clickup/
4. Emir copies to ClickUp

### Pattern 6: Weekly Gardening (Maintenance Routine)

**What Teresa Does:**
- Every week, reviews active projects
- Archives completed work
- Updates roadmaps
- Cleans up orphaned files

**WUFF Implementation:**

**Weekly Review Checklist (Sunday):**
```markdown
# Weekly Review Checklist
**Location:** 20_KNOWLEDGE/Workflows/Weekly_Review_Checklist.md

## STEP 1: Review Active Projects (15 min)
- [ ] Read 01_STATE/Active_Projects.md
- [ ] For each project:
  - [ ] Check ACTIVE_STATE.md (is it current?)
  - [ ] Any completed projects to archive?
  - [ ] Any blocked projects to escalate?
- [ ] Update Active_Projects.md with current status

## STEP 2: Review SOPs (10 min)
- [ ] Read 00_SYSTEM/SOP_Registry.md
- [ ] Any new procedures created this week?
- [ ] Any deprecated SOPs to archive?
- [ ] Update SOP_Registry.md if needed

## STEP 3: Knowledge Base Sync (20 min)
- [ ] Read 01_STATE/Updates_This_Week.md
- [ ] Any changes to master docs (Brand, Workflows)?
- [ ] Do ClickUp summaries need updating?
- [ ] Generate sync checklist if needed
- [ ] Clear Updates_This_Week.md after sync

## STEP 4: Archive Completed Work (10 min)
- [ ] Move completed projects from 30_PROJECTS/ to 99_ARCHIVE/
- [ ] Create archive summary (what was accomplished)
- [ ] Update Active_Projects.md (remove archived projects)

## STEP 5: Plan Next Week (15 min)
- [ ] Review 01_STATE/Current_Focus.md
- [ ] Set focus for coming week
- [ ] Identify any research needed
- [ ] Create Mission Briefs for delegated work
- [ ] Update This_Week.md goals

**Total Time:** ~70 minutes
**Output:** Clean state, clear priorities, ready for new week
```

---

# 🗓️ IMPLEMENTATION ROADMAP (Week-by-Week)

## Week 1: Foundation (Basic Memory + C:\AI-Team\)

### Day 1-2: Folder Structure & Core Files
- [ ] **Task 1.1:** Create Basic Memory folder structure
  - Run mkdir commands (see Basic Memory Setup section)
  - Verify with `dir` command
  - **Completion Criteria:** All 6 top-level folders + subfolders exist

- [ ] **Task 1.2:** Create C:\AI-Team\ structure
  - Run mkdir commands (see C:\AI-Team Setup section)
  - Verify folder creation
  - **Completion Criteria:** claude.md location ready, mission-briefs/ folders exist

- [ ] **Task 1.3:** Write claude.md
  - Copy template from blueprint (Section: C:\AI-Team Setup - Phase 2)
  - Customize identity section based on Emir's preferences
  - Test: Open Claude Code in C:\AI-Team\, verify claude.md loads
  - **Completion Criteria:** claude.md exists, reads correctly

### Day 3-4: System Context Files (Interview Method)
- [ ] **Task 1.4:** Interview for Orchestrator_Identity.md
  - WUFF asks 5 questions (see template in blueprint)
  - Emir answers
  - WUFF creates structured file with WikiLinks
  - Save to: `00_SYSTEM/Orchestrator_Identity.md`
  - **Completion Criteria:** File exists, contains clear identity definition

- [ ] **Task 1.5:** Create SOP_Registry.md (index)
  - Use template from blueprint
  - Start with minimal SOPs (will add more as created)
  - Include: Project Initiation, Mission Brief, Weekly Review
  - **Completion Criteria:** Index file exists, links to (future) SOP files

- [ ] **Task 1.6:** Write Agent_Protocols.md
  - Use template from blueprint
  - Define delegation rules (when to use ClickUp vs Gemini vs sub-agents)
  - **Completion Criteria:** Clear decision tree for delegation

### Day 5-7: Initial State & Test
- [ ] **Task 1.7:** Create initial State files
  - Current_Focus.md (manual first time, auto-updated later)
  - Active_Projects.md (start with wuff-orchestrator-setup project)
  - Today.md (template for daily use)
  - **Completion Criteria:** State files exist, WUFF can read them on session start

- [ ] **Task 1.8:** Set up GDrive sync (Mirror or selective)
  - Choose strategy: Full Mirror OR selective sync
  - Configure Google Drive Desktop
  - Create sync folder: `G:\My Drive\WuffUniversuM Brain\Memory-Graph`
  - Test: Create file in Basic Memory, verify syncs to GDrive
  - **Completion Criteria:** Backup working, files appear in GDrive within 5 minutes

- [ ] **Task 1.9:** First test workflow
  - Create test project: `30_PROJECTS/test-mission-brief/`
  - Write simple Mission Brief (e.g., "Research ClickUp Autopilot pricing")
  - Save to mission-briefs/pending/gemini/
  - Manually execute (Emir copies to claude.ai, gets answer)
  - Save result to mission-briefs/completed/
  - WUFF reads result, updates test project ACTIVE_STATE.md
  - **Completion Criteria:** Full delegation cycle works, no errors

**Week 1 Success Metrics:**
- ✅ Folder structures exist (Basic Memory + C:\AI-Team\)
- ✅ claude.md loads correctly on session start
- ✅ At least 3 files in 00_SYSTEM (Identity, SOP Registry, Agent Protocols)
- ✅ State files initialized (Current_Focus, Active_Projects)
- ✅ GDrive backup working
- ✅ One complete Mission Brief workflow tested

---

## Week 2: Brand Context & Workflows

### Day 8-10: Brand Knowledge Base (Interview Method)
- [ ] **Task 2.1:** Interview for Brand_Guidelines.md
  - WUFF asks questions: Brand values? Mission? Vision? Positioning?
  - Emir answers (can be rough - iterate later)
  - WUFF creates master doc: `10_BRAND/Brand_Guidelines.md`
  - **Completion Criteria:** Basic brand identity documented

- [ ] **Task 2.2:** Interview for Voice_Tone.md
  - Questions: How should WUFF communicate? Formal vs casual? Technical depth?
  - Create examples: WUFF → ClickUp (operational), WUFF → Gemini (research)
  - Save: `10_BRAND/Voice_Tone.md`
  - **Completion Criteria:** Clear communication guidelines

- [ ] **Task 2.3:** Interview for Target_Audiences.md
  - Who are WuffUniversuM's customers/users?
  - What are their pain points, goals, preferences?
  - Create 2-3 persona sketches
  - Save: `10_BRAND/Target_Audiences.md`
  - **Completion Criteria:** Audience understanding documented

### Day 11-12: Core Workflow SOPs
- [ ] **Task 2.4:** Create Project_Initiation_SOP.md
  - Document step-by-step: How WUFF starts new projects
  - Include: Interview questions, folder creation, template usage
  - Save: `20_KNOWLEDGE/Workflows/Project_Initiation_SOP.md`
  - Update: SOP_Registry.md (add link)
  - **Completion Criteria:** Reusable process for all future projects

- [ ] **Task 2.5:** Create Mission_Brief_Template.md
  - Separate templates for: ClickUp, Gemini, Sub-agents
  - Include examples (filled template for reference)
  - Save: `20_KNOWLEDGE/Workflows/Mission_Brief_Template.md`
  - Also save copies: `C:\AI-Team\templates\`
  - **Completion Criteria:** Templates ready for copy/paste use

- [ ] **Task 2.6:** Create Weekly_Review_Checklist.md
  - Use Teresa's pattern (see blueprint)
  - Customize for WUFF context (Basic Memory, ClickUp sync, etc.)
  - Save: `20_KNOWLEDGE/Workflows/Weekly_Review_Checklist.md`
  - **Completion Criteria:** Sunday routine defined

### Day 13-14: First Real Project Setup
- [ ] **Task 2.7:** Create wuff-orchestrator-setup project files
  - Folder: `30_PROJECTS/wuff-orchestrator-setup/`
  - PROJECT_SPEC.md (goal: Build WUFF system)
  - ACTIVE_STATE.md (current: Week 2 of implementation)
  - ARCHITECTURE.md (copy from this blueprint)
  - DECISION_LOG.md (document: 3 KBs, PARA, local Basic Memory, etc.)
  - Process_Notes.md (session notes from Session 001-002)
  - **Completion Criteria:** This project properly tracked

- [ ] **Task 2.8:** Test project workflow end-to-end
  - Use Project Initiation SOP for a test project (e.g., "WUFF Website Content")
  - WUFF interviews Emir (gather requirements)
  - Create project files (SPEC, STATE, ARCHITECTURE)
  - Generate 2 Mission Briefs (one for ClickUp, one for Gemini)
  - Execute both, track results
  - Archive project when complete (move to 99_ARCHIVE/)
  - **Completion Criteria:** Full project lifecycle tested

**Week 2 Success Metrics:**
- ✅ Brand context files exist (Guidelines, Voice, Audiences)
- ✅ Core workflow SOPs documented (Initiation, Mission Brief, Weekly Review)
- ✅ wuff-orchestrator-setup project properly tracked
- ✅ One test project completed end-to-end
- ✅ WUFF can autonomously start new projects following SOP

---

## Week 3: ClickUp Integration & Optimization

### Day 15-17: ClickUp Knowledge Base Setup
- [ ] **Task 3.1:** Research ClickUp KB best practices
  - **Research Items:**
    - ClickUp Docs formatting for Brain search (headings, tags, structure)
    - Folder hierarchy recommendations (flat vs nested)
    - Update frequency (how often to sync from Basic Memory)
  - **Method:** Emir uses claude.ai or ChatGPT to research
  - **Output:** `20_KNOWLEDGE/Tech_Stack/ClickUp_KB_Best_Practices.md`
  - **Completion Criteria:** Research doc created, strategies identified

- [ ] **Task 3.2:** Create ClickUp folder structure
  - In ClickUp Docs: Create "WuffUniversuM Knowledge Base" folder
  - Subfolders: Brand, Projects, Workflows, Templates
  - **Completion Criteria:** ClickUp Docs organized, ready for content

- [ ] **Task 3.3:** Populate ClickUp KB (summaries, not full content)
  - Copy brand summaries (1-page versions) from Basic Memory
  - Upload Mission Brief templates
  - Link to: "Full details in WUFF Basic Memory (ask Emir for access)"
  - **Completion Criteria:** ClickUp Brain can search WuffUniversuM context

### Day 18-20: ClickUp Autopilot Experimentation
- [ ] **Task 3.4:** Research ClickUp Autopilot capabilities
  - **Questions:** What can Autopilot automate? Pricing? Limitations?
  - **Method:** Emir researches via claude.ai/ChatGPT + ClickUp docs
  - **Output:** `20_KNOWLEDGE/Tech_Stack/ClickUp_Autopilot_Analysis.md`
  - **Completion Criteria:** Decision on whether to use Autopilot

- [ ] **Task 3.5:** Create first Autopilot Agent (if viable)
  - **Goal:** Watch mission-briefs/pending/clickup/ folder → auto-execute
  - **Test:** WUFF creates Mission Brief → Autopilot picks it up → creates task in ClickUp
  - **Fallback:** If not viable, continue manual copy/paste (optimize later)
  - **Completion Criteria:** Automation working OR decision to defer

### Day 21: Weekly Review #1
- [ ] **Task 3.6:** First weekly review
  - Follow: `20_KNOWLEDGE/Workflows/Weekly_Review_Checklist.md`
  - WUFF leads, Emir confirms
  - Time: ~60-70 minutes
  - **Steps:**
    1. Review Active_Projects.md
    2. Check SOP_Registry.md (any new SOPs to add?)
    3. Sync ClickUp KB (update summaries if brand changed)
    4. Archive completed projects (if any)
    5. Plan Week 4 focus
  - **Output:** Updated State files, clean workspace
  - **Completion Criteria:** Review complete, notes documented

**Week 3 Success Metrics:**
- ✅ ClickUp KB populated with WuffUniversuM context
- ✅ ClickUp Brain can answer basic questions about brand/workflows
- ✅ ClickUp Autopilot tested (or decision made to defer)
- ✅ First weekly review completed successfully
- ✅ Process improvements identified, documented

---

## Week 4: Gemini Integration & Advanced Features

### Day 22-24: Gemini Enterprise Setup (If Available)
- [ ] **Task 4.1:** Determine Gemini approach
  - **Option A:** Subscribe to Gemini Enterprise (Google Workspace add-on)
  - **Option B:** Use Gemini API (pay per token)
  - **Option C:** Defer Gemini (use claude.ai for now)
  - **Decision Criteria:** Cost, usage patterns, integration needs
  - **Completion Criteria:** Decision made, documented

- [ ] **Task 4.2:** Set up Gemini KB (if proceeding)
  - Create GDrive folder: `WuffUniversuM Research/`
  - Upload research materials, long-form docs
  - Test Gemini access (can it read from this folder?)
  - **Completion Criteria:** Gemini can access reference materials

- [ ] **Task 4.3:** Create first Gemini Mission Brief
  - **Example Task:** "Analyze competitor landscape (10 companies, full SWOT)"
  - WUFF creates Mission Brief → saves to mission-briefs/pending/gemini/
  - Emir copies to Gemini → executes
  - Save result to mission-briefs/completed/
  - WUFF reviews output quality
  - **Completion Criteria:** Gemini delegation workflow tested

### Day 25-26: Advanced Basic Memory Features
- [ ] **Task 4.4:** WikiLink graph optimization
  - Review: Current WikiLink usage (are they helpful or confusing?)
  - **Research:** Best practices for graph depth, bidirectional links
  - **Experiment:** Create test notes with various link patterns
  - **Output:** `20_KNOWLEDGE/Tech_Stack/WikiLink_Best_Practices.md`
  - **Completion Criteria:** Standards defined for future note-taking

- [ ] **Task 4.5:** Basic Memory search testing
  - Test search syntax: Tags, fuzzy matching, regex (if supported)
  - Measure performance: How fast with 50 files? 100 files?
  - Document: `20_KNOWLEDGE/Tech_Stack/Basic_Memory_Search.md`
  - **Completion Criteria:** WUFF knows how to search effectively

### Day 27-28: System Hardening & Error Handling
- [ ] **Task 4.6:** Test interruption recovery
  - Simulate: Auth timeout (close Claude Desktop mid-session)
  - Test: Auto-resume protocol (read CLAUDE_RESUME_INSTRUCTIONS.md)
  - Verify: WUFF loads correct context, continues seamlessly
  - **Fix:** Any issues in resume protocol
  - **Completion Criteria:** Recovery protocol works reliably

- [ ] **Task 4.7:** Create Emergency_Recovery_SOP.md
  - Document: How to recover from common failures
  - Scenarios: Auth timeout, token limit, crash, corrupted files
  - Include: Copy/paste commands (like CLAUDE-EMERGENCY-RECOVERY.md)
  - Save: `20_KNOWLEDGE/Workflows/Emergency_Recovery_SOP.md`
  - **Completion Criteria:** Troubleshooting guide ready

**Week 4 Success Metrics:**
- ✅ Gemini integration tested (or decision made to defer)
- ✅ WikiLink best practices defined
- ✅ Basic Memory search optimized
- ✅ Interruption recovery tested and working
- ✅ Emergency procedures documented

---

## Week 5+: Operational Mode & Continuous Improvement

### Transition to Production
At this point, WUFF is fully operational. Focus shifts from setup to real work:

- [ ] **Real projects:** Start delegating actual business work (not test projects)
- [ ] **Iteration:** Improve SOPs based on what works/doesn't work
- [ ] **Optimization:** Reduce Human Router latency (API integrations if needed)
- [ ] **Expansion:** Add sub-agents, new workflows, advanced features

### Ongoing Maintenance
- **Daily:** Update Current_Focus.md, Today.md
- **Weekly:** Run Weekly Review Checklist (Sunday)
- **Monthly:** Review SOP_Registry.md, archive old projects, assess system health
- **Quarterly:** Strategic review (is WUFF meeting goals? What to improve?)

### Future Enhancements (Post-MVP)
- **Phase 2:** ClickUp Autopilot automation (eliminate manual copy/paste)
- **Phase 3:** API integrations (direct WUFF → ClickUp/Gemini communication)
- **Phase 4:** Advanced sub-agents (code generation, data analysis, etc.)
- **Phase 5:** Multi-project orchestration (manage 5+ concurrent projects)

---

# 📋 TEMPLATES & REFERENCES

## Template 1: PROJECT_SPEC.md

**Location:** `30_PROJECTS/Templates/PROJECT_SPEC_template.md`

```markdown
# PROJECT SPECIFICATION: [Project Name]

**Created:** [YYYY-MM-DD]
**Status:** [Active/Paused/Completed/Archived]
**Owner:** [Who requested this? Emir, WUFF, External client?]
**Priority:** [High/Medium/Low]

---

## 🎯 OBJECTIVE (Immutable)

**What:** [One sentence: What are we building/achieving?]

**Why:** [Why does this matter? What problem does it solve?]

**Success Criteria:**
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]
- [ ] [How will we know it's complete?]

**Out of Scope:**
- [What are we explicitly NOT doing?]

---

## 🧩 REQUIREMENTS

### Functional:
- [Feature 1]
- [Feature 2]

### Non-Functional:
- Performance: [Response time, throughput, etc.]
- Scalability: [User load, data volume]
- Security: [Authentication, data protection]

### Constraints:
- Budget: [Cost limits]
- Timeline: [Deadlines, milestones]
- Technical: [Must use X tech, integrate with Y system]

---

## 👥 STAKEHOLDERS

| Role | Name/System | Involvement |
|------|-------------|-------------|
| Requester | [Who asked for this?] | Approval, feedback |
| Executor | [WUFF, ClickUp, Gemini?] | Implementation |
| Reviewer | [Who validates?] | Quality control |

---

## 📊 CONTEXT & BACKGROUND

[Relevant history, related projects, why now?]

**Related Projects:**
- [[Link to related project 1]]
- [[Link to related project 2]]

**Resources:**
- [Documentation links]
- [Research materials]
- [External references]

---

## 🚦 DECISION FRAMEWORK

**Authority Levels:**
- **Emir decides:** [Strategic direction, budget, final approval]
- **WUFF decides:** [Technical approach, delegation, task prioritization]
- **Agent decides:** [Implementation details within Mission Brief scope]

**When to escalate:**
- [Blocker encountered]
- [Scope change requested]
- [Budget/timeline concerns]

---

**IMPORTANT:** This file is IMMUTABLE once project starts.
Changes to scope → Create new project OR document in DECISION_LOG.md with rationale.
```

---

## Template 2: ACTIVE_STATE.md

**Location:** `30_PROJECTS/Templates/ACTIVE_STATE_template.md`

```markdown
# ACTIVE STATE: [Project Name]

**Last Updated:** [Auto-timestamp]
**Current Phase:** [Phase name or number]
**Progress:** [X%] complete

---

## 🎯 CURRENT FOCUS

**Working On:**
- [Specific task in progress right now]

**Next Up:**
- [Immediate next task after current completes]

**Blocked On:**
- [Blocker 1 - waiting for X]
- [Blocker 2 - needs decision on Y]

---

## ✅ COMPLETED MILESTONES

- [x] **[Date]** - [Milestone 1 name]
  - Description: [What was accomplished]
  - Outcome: [Deliverable, decision made, etc.]

- [x] **[Date]** - [Milestone 2 name]
  - Description: [What was accomplished]
  - Outcome: [Deliverable]

---

## 🔜 UPCOMING MILESTONES

- [ ] **[Target Date]** - [Milestone 3 name]
  - Description: [What needs to happen]
  - Dependencies: [Requires X to be done first]
  - Owner: [Who's responsible]

- [ ] **[Target Date]** - [Milestone 4 name]
  - Description: [What needs to happen]

---

## 🚨 RISKS & ISSUES

| Risk/Issue | Impact | Mitigation | Status |
|------------|--------|------------|--------|
| [Risk 1] | [High/Med/Low] | [Plan to address] | [Open/Mitigated] |

---

## 📝 RECENT UPDATES (Last 7 Days)

### [YYYY-MM-DD]:
- [Update 1]
- [Update 2]

### [YYYY-MM-DD]:
- [Update 1]

---

**Read by:** WUFF on every session start (if project is Current_Focus)
**Updated by:** WUFF after completing tasks, delegating Mission Briefs, or status changes
```

---

## Template 3: DECISION_LOG.md

**Location:** `30_PROJECTS/Templates/DECISION_LOG_template.md`

```markdown
# DECISION LOG: [Project Name]

**Purpose:** Record WHY choices were made (for future reference when context is forgotten)

---

## Decision 1: [Title]

**Date:** [YYYY-MM-DD]
**Decider:** [Emir, WUFF, Consensus]
**Status:** [Active/Superseded/Reverted]

### Context:
[What situation led to this decision?]

### Options Considered:
1. **Option A:** [Description]
   - Pros: [Benefits]
   - Cons: [Drawbacks]

2. **Option B:** [Description]
   - Pros: [Benefits]
   - Cons: [Drawbacks]

3. **Option C:** [Description]
   - Pros: [Benefits]
   - Cons: [Drawbacks]

### Decision:
**Chosen:** Option [A/B/C]

**Rationale:**
[Why this option was selected. What trade-offs were accepted?]

### Consequences:
- [Implication 1]
- [Implication 2]

### Review Date:
[When to revisit this decision? Or "N/A - permanent"]

---

## Decision 2: [Title]
[Same structure as above]

---

**Usage Notes:**
- Document major decisions ONLY (not every tiny choice)
- Focus on "Why" more than "What"
- Link to relevant context: [[Related docs]]
- Update Status if decision is reversed later
```

---

## Template 4: Mission Brief (ClickUp)

**Location:** `C:\AI-Team\templates\mission-brief-clickup.md`

```markdown
# MISSION BRIEF: [Task Name]

**Date:** [YYYY-MM-DD]
**Agent:** ClickUp Brain
**Delegated By:** WUFF Orchestrator
**Project:** [[Link to project in Basic Memory]]
**Priority:** [High/Medium/Low]

---

## 🎯 OBJECTIVE

[Clear, concise goal - WHAT needs to be accomplished, not HOW]

**Example:**
"Set up project tracking for WuffUniversuM brand development project with task dependencies, milestones, and team assignments."

---

## 📚 CONTEXT

**Background:**
[Why is this task needed? What's the larger context?]

**Constraints:**
- [Time constraint, resource limit, etc.]
- [Must integrate with existing system X]

**Assumptions:**
- [What we're assuming is true]

---

## ✅ SUCCESS CRITERIA

How we'll know this is complete:

- [ ] [Measurable outcome 1 - specific, verifiable]
- [ ] [Measurable outcome 2]
- [ ] [Measurable outcome 3]

**Verification Method:**
[How will WUFF check if this was done correctly?]

---

## 📅 DEADLINE

**Target Date:** [YYYY-MM-DD] OR "No deadline - strategic"

**Urgency:**
- [ ] Urgent (blocks other work)
- [ ] Standard (normal priority)
- [ ] Low (nice to have)

---

## 📤 OUTPUT FORMAT

**Expected Deliverable:**
[What should ClickUp Brain produce?]

**Examples:**
- "ClickUp board with 15 tasks, organized by status and priority"
- "Workflow automation that assigns tasks based on project type"
- "Report summarizing project status (PDF or ClickUp Doc)"

---

## 🔗 RESOURCES

**Reference Materials:**
- [[Brand Guidelines]] (in Basic Memory)
- [[Project Spec]] (in Basic Memory)
- [External doc link]

**Related Tasks:**
- [Link to previous Mission Brief if continuation]

---

## 💬 SPECIAL INSTRUCTIONS (Optional)

[Only include if ClickUp Brain needs specific guidance beyond the objective]

**Example:**
"Use ClickUp's Gantt view for timeline visualization. Tag tasks with #WuffUniversuM for filtering."

---

## 📊 REPORTING

**When Complete:**
1. Save output to: `mission-briefs/completed/clickup/[YYYY-MM-DD]_[task-name]_RESULTS.md`
2. Include:
   - Summary of what was accomplished
   - Link to ClickUp board/task/doc
   - Any issues encountered
   - Recommendations (if applicable)

---

**END OF MISSION BRIEF**

*Copy this entire brief to ClickUp Brain for execution.*
```

---

## Template 5: Mission Brief (Gemini)

**Location:** `C:\AI-Team\templates\mission-brief-gemini.md`

```markdown
# MISSION BRIEF: [Research/Content Task Name]

**Date:** [YYYY-MM-DD]
**Agent:** Gemini Enterprise (2M token context)
**Delegated By:** WUFF Orchestrator
**Project:** [[Link to project in Basic Memory]]
**Priority:** [High/Medium/Low]

---

## 🎯 OBJECTIVE

[High-level research or content generation goal]

**Example:**
"Analyze 10 competitor companies in the AI orchestration space. Provide SWOT analysis, pricing comparison, and positioning insights."

---

## 📚 CONTEXT

**Background:**
[Why is this research needed? How will it be used?]

**Scope:**
- [What to include]
- [What to exclude]

**Depth:**
- [ ] Surface-level overview (10-20 pages)
- [ ] Deep dive analysis (50-100 pages)
- [ ] Comprehensive research (100+ pages)

---

## ✅ SUCCESS CRITERIA

Research/content will be considered complete when:

- [ ] [Criterion 1 - e.g., "All 10 competitors analyzed"]
- [ ] [Criterion 2 - e.g., "SWOT matrices created for each"]
- [ ] [Criterion 3 - e.g., "Pricing comparison table included"]

---

## 📅 DEADLINE

**Target Date:** [YYYY-MM-DD] OR "No deadline - strategic"

**Note:** Gemini tasks typically take longer due to bulk processing.

---

## 📤 OUTPUT FORMAT

**Deliverable Type:**
- [ ] Research report (Markdown or Google Doc)
- [ ] Content pieces (blog posts, articles, scripts)
- [ ] Data analysis (spreadsheet, charts, summary)
- [ ] Comparison matrix (table format)

**Structure:**
[Specify sections if needed]

**Example:**
```
1. Executive Summary (2 pages)
2. Methodology (1 page)
3. Findings (main body)
4. Comparison Tables (appendix)
5. Recommendations (2 pages)
```

---

## 🔗 RESOURCES

**Source Materials:**
- GDrive folder: [Link to GDrive folder with reference docs]
- External sources: [Websites, databases, APIs to consult]
- Basic Memory context: [[Relevant notes]]

**Constraints:**
- [Only use public information / Must cite sources / etc.]

---

## 💬 SPECIAL INSTRUCTIONS (Optional)

[Gemini-specific guidance]

**Example:**
"Use your 2M token window to analyze all competitor websites in full. Prioritize recent information (2024-2025). Cite all sources."

---

## 📊 REPORTING

**When Complete:**
1. Save output to GDrive: `WuffUniversuM Research/Completed/[YYYY-MM-DD]_[task-name]/`
2. Copy summary to: `mission-briefs/completed/gemini/[YYYY-MM-DD]_[task-name]_RESULTS.md`
3. Include in summary:
   - Executive summary (1-2 pages)
   - Link to full report in GDrive
   - Key findings (bullet points)
   - Recommendations for next steps

---

**END OF MISSION BRIEF**

*Copy this entire brief to Gemini for execution. Provide access to referenced GDrive folder if needed.*
```

---

## Template 6: Interview Question Bank

**Purpose:** Reusable questions for populating knowledge base via Interview Method

### Brand Identity Interview:
1. What are WuffUniversuM's core values? (3-5 values)
2. What is the mission? (Why does WuffUniversuM exist?)
3. What is the vision? (Where are we headed in 3-5 years?)
4. Who are our primary customers/users?
5. What makes us different from competitors?
6. What tone should communications have? (Formal, casual, technical, friendly?)
7. What are our brand colors, logo guidelines, visual style?
8. What words/phrases should we always use? (And what to avoid?)
9. How do we want customers to feel when interacting with us?
10. What's our positioning statement? (For [target audience], WuffUniversuM is [category] that [benefit]...)

### Project Initiation Interview:
1. What problem are we solving? (User pain point)
2. What's the desired outcome? (Success = ?)
3. Who is this for? (Target user/customer)
4. What's in scope? (Core features)
5. What's out of scope? (What we're NOT doing)
6. What's the timeline? (Deadline, milestones)
7. What's the budget? (Cost constraints)
8. What are the risks? (What could go wrong?)
9. Who needs to approve decisions? (Authority structure)
10. How will we measure success? (Metrics, KPIs)
11. What resources are available? (Team, tools, data)
12. What's the technical approach? (Architecture, tech stack)

### Workflow Documentation Interview:
1. What triggers this workflow? (When does it start?)
2. What's the first step? (Initial action)
3. What happens next? (Sequence of steps)
4. Who's involved? (Roles, responsibilities)
5. What decisions are made? (Decision points)
6. What are common failure modes? (Where does it break?)
7. How long does it typically take? (Duration)
8. What's the output? (Deliverable)
9. How do we know it's complete? (Success criteria)
10. What happens after? (Next workflow, handoff)

---

# 🔬 RESEARCH & LEARNING TASKS (Prioritized)

## Priority 1: Immediate (Before Week 2)

### Research Task 1: Basic Memory Setup Deep Dive
**Why:** Need to optimize folder structure, WikiLinks, search before populating heavily

**Questions to Answer:**
1. What's the recommended folder depth? (3 levels? 5 levels? No limit?)
2. How do WikiLinks work with Basic Memory MCP? (Auto-completion? Backlinks?)
3. What's the search syntax? (Tags, regex, fuzzy matching)
4. Performance: How many files before slowdown? (100? 1000? 10,000?)
5. Backup strategy: Does Basic Memory integrate with Git? (Auto-commit? Sync?)
6. File naming: Best practices for Markdown filenames (spaces, underscores, dates)
7. Graph visualization: Any tools to visualize WikiLink graphs?

**Research Method:**
- Read: Basic Memory GitHub repo (README, issues, discussions)
- Check: Obsidian community forums (they use similar WikiLink structure)
- Test: Create dummy files, experiment with search

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/Basic_Memory_Deep_Dive.md`

**Estimated Time:** 2-3 hours

---

### Research Task 2: ClickUp Brain Knowledge Base Best Practices
**Why:** Need to structure ClickUp Docs for optimal Brain search performance

**Questions to Answer:**
1. What doc format works best for Brain? (Headings? Tags? Formatting?)
2. Folder structure: Flat (all in one folder) or nested (hierarchical)?
3. Update frequency: How often to sync from Basic Memory? (Daily? Weekly?)
4. Search optimization: How does Brain rank results? (Keywords? Semantic?)
5. Content length: Short summaries vs long docs - which works better?
6. Linking: Can ClickUp Docs link to external systems (GDrive, Basic Memory)?
7. Versioning: Does ClickUp track doc history?

**Research Method:**
- ClickUp documentation (ClickUp Brain section)
- ClickUp community forums, YouTube tutorials
- Competitor analysis (how others use ClickUp Brain)

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/ClickUp_KB_Best_Practices.md`

**Estimated Time:** 2-3 hours

---

### Research Task 3: GDrive Sync Options (Mirror vs Stream)
**Why:** Need to choose backup strategy without breaking MCP local requirement

**Questions to Answer:**
1. Mirror mode: How much disk space for typical setup? (Estimate for WuffUniversuM)
2. Stream mode: Can it work with "selective offline" folders?
3. Performance: Sync delay (how long after file save until in cloud)?
4. Conflicts: How does GDrive handle simultaneous edits?
5. Backup reliability: Any known issues with large numbers of small files?
6. Alternative tools: Should we use Robocopy, Git, or third-party sync tool instead?

**Research Method:**
- Google Drive documentation (sync modes)
- Test both modes with dummy folder (measure sync time, disk usage)
- Community feedback (Reddit, forums)

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/GDrive_Sync_Analysis.md`

**Estimated Time:** 1-2 hours

---

## Priority 2: Before Full Production (Week 3-4)

### Research Task 4: ClickUp Autopilot Agent Capabilities
**Why:** Determine if automation can replace Human Router (copy/paste elimination)

**Questions to Answer:**
1. What can Autopilot automate? (Create tasks, update fields, send messages?)
2. Can it watch folders? (Monitor mission-briefs/pending/ for new files?)
3. Pricing: How many credits does typical automation use? (100-300 claimed in notes)
4. Limitations: What CAN'T it do? (Complex logic? External API calls?)
5. Setup complexity: How hard to configure? (Technical knowledge required?)
6. Examples: Any templates or community workflows to copy?

**Research Method:**
- ClickUp Autopilot documentation
- Pricing calculator (estimate monthly cost)
- Community examples (ClickUp University, YouTube)
- Test: Create simple Autopilot (e.g., "When doc created in folder X, create task in List Y")

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/ClickUp_Autopilot_Analysis.md`

**Estimated Time:** 3-4 hours

---

### Research Task 5: Gemini Enterprise vs API Decision
**Why:** Determine best approach for bulk processing (cost, integration, features)

**Questions to Answer:**
1. Gemini Enterprise pricing: How much for Google Workspace add-on?
2. Gemini API pricing: Cost per token for Gemini 2.0 Flash (or latest model)
3. Feature comparison: What does Enterprise include that API doesn't? (Integration, KB, etc.)
4. Usage patterns: How many tokens per month expected? (Estimate for WuffUniversuM)
5. Integration: Does Enterprise integrate better with GDrive, Gmail, etc.?
6. Recommendation: Which is more cost-effective for WUFF use case?

**Research Method:**
- Google Workspace pricing page
- Gemini API pricing (Google AI Studio)
- Cost calculator (estimate monthly usage)
- Community feedback (which do others use?)

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/Gemini_Decision_Analysis.md`

**Estimated Time:** 2-3 hours

---

### Research Task 6: Mission Brief Workflow Automation
**Why:** Identify opportunities to reduce Human Router latency

**Questions to Answer:**
1. Can WUFF write directly to ClickUp via API? (ClickUp API capabilities)
2. Can Gemini read from file system? (Or only GDrive?)
3. Zapier/Make/n8n: Could these automate Mission Brief execution?
4. Security: What permissions needed for API access? (Safe to automate?)
5. Fallback: If automation breaks, how to quickly revert to manual?
6. ROI: Is automation worth the setup effort? (Time saved vs time to implement)

**Research Method:**
- ClickUp API documentation
- Gemini API documentation (file handling)
- Automation platform comparisons (Zapier, Make, n8n)

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/Mission_Brief_Automation_Options.md`

**Estimated Time:** 3-4 hours

---

## Priority 3: Optimization (Post-MVP)

### Research Task 7: Git Integration for Basic Memory
**Why:** Version control for knowledge base (track changes, revert mistakes)

**Questions to Answer:**
1. Should Basic Memory folder be a Git repo?
2. Auto-commit strategy: After every change? Daily? Weekly?
3. Commit messages: Auto-generated or manual?
4. Remote: Push to GitHub? (Private repo for backup)
5. Branching: Use branches for experimental workflows?
6. Conflicts: How to handle merge conflicts in Markdown files?

**Research Method:**
- Git best practices for documentation repos
- Obsidian + Git integration examples
- Test: Initialize .basicmemory as Git repo, simulate workflow

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/Git_Integration_Plan.md`

**Estimated Time:** 2-3 hours

---

### Research Task 8: Advanced Sub-Agent Patterns
**Why:** Maximize Claude Code sub-agent capabilities for specialized tasks

**Questions to Answer:**
1. What can sub-agents do that WUFF can't? (Parallel processing, specialized context?)
2. Best practices: When to delegate to sub-agent vs handle directly?
3. Examples: What are proven sub-agent workflows? (Code review, research, validation)
4. Performance: Do sub-agents use separate token budgets?
5. Context sharing: How much context to pass to sub-agents?

**Research Method:**
- Claude Code documentation (sub-agent capabilities)
- Community examples (GitHub, forums)
- Experimentation (test various sub-agent patterns)

**Deliverable:** `20_KNOWLEDGE/Tech_Stack/Sub_Agent_Best_Practices.md`

**Estimated Time:** 2-3 hours

---

# 🔧 TROUBLESHOOTING & RECOVERY

## Common Issues & Solutions

### Issue 1: Claude Session Timeout (Auth 401)

**Symptoms:**
- API Error 401: OAuth token has expired
- Can't send messages in Claude Desktop

**Cause:**
- Authentication session expired (not chat token limit)

**Fix:**
1. Close Claude Desktop completely
2. Reopen Claude Desktop
3. Sign in again if prompted
4. Open new chat
5. Resume with: "Pročitaj C:\Projects\CLAUDE_RESUME_INSTRUCTIONS.md i nastavi"

**Prevention:**
- Checkpoint frequently (update State files every 30-60 minutes)
- Keep emergency recovery commands in Obsidian for quick access

---

### Issue 2: Token Limit Approaching

**Symptoms:**
- System warning: ">150K tokens used"
- Chat becoming slow or unresponsive

**Cause:**
- Chat context too large (approaching 200K limit)

**Fix:**
1. WUFF updates Current_Focus.md immediately
2. WUFF updates Active_Projects.md
3. WUFF updates relevant ACTIVE_STATE.md files
4. Tell Emir: "Checkpoint needed - 70% token usage"
5. Close chat
6. Open new chat
7. Resume with latest Session Notes

**Prevention:**
- Monitor token usage every 10-15 responses
- Checkpoint at 70% (140K tokens), don't wait for 90%
- Use sub-agents for large tasks (separate token budget)

---

### Issue 3: WUFF Reads Wrong Context

**Symptoms:**
- WUFF references old project instead of current one
- WUFF doesn't know recent decisions

**Cause:**
- State files not updated (Current_Focus.md outdated)
- OR WUFF didn't read State files on session start

**Fix:**
1. Emir says: "STOP - read Current_Focus.md first"
2. WUFF reads: `C:\Users\emirv\.basicmemory\01_STATE\Current_Focus.md`
3. WUFF confirms: "Current focus is [project]. Proceeding with correct context."
4. Update Current_Focus.md if it was wrong

**Prevention:**
- WUFF MUST read Current_Focus.md on every session start (in claude.md protocol)
- Update Current_Focus.md immediately when switching projects
- Emir can verify: "What's the current focus?" before starting work

---

### Issue 4: Mission Brief Not Executed

**Symptoms:**
- Mission Brief created but no result in completed/ folder
- ClickUp/Gemini didn't receive task

**Cause:**
- Human Router step skipped (Emir forgot to copy/paste)
- OR Mission Brief unclear (agent didn't understand)

**Fix:**
1. Check: Does mission-briefs/pending/[agent]/ have unprocessed briefs?
2. If yes: Emir copies to ClickUp/Gemini now
3. If brief was unclear: WUFF rewrites with more context
4. Move completed briefs to in-progress/ while executing (tracking)
5. Move to completed/ when done

**Prevention:**
- WUFF tells Emir explicitly: "Mission Brief ready - copy to [agent]"
- Use checklist in mission-briefs/ folder (README with pending count)
- Weekly review checks for orphaned Mission Briefs

---

### Issue 5: WikiLink Broken (Can't Find File)

**Symptoms:**
- [[Link]] shows as broken (file not found)
- WUFF can't load referenced context

**Cause:**
- File renamed or moved
- OR typo in WikiLink
- OR file not created yet (linked prematurely)

**Fix:**
1. Search Basic Memory for correct filename
2. Update WikiLink to correct path
3. If file doesn't exist: Create it OR remove link
4. Run validation: @validator check all WikiLinks

**Prevention:**
- Use consistent file naming (no renaming after links created)
- Create files before linking (or mark as TODO: [[Future File]])
- Regular validation (weekly review includes link check)

---

### Issue 6: GDrive Sync Failure

**Symptoms:**
- Files created in Basic Memory don't appear in GDrive
- OR GDrive files not syncing locally

**Cause:**
- GDrive Desktop app paused or crashed
- Network connectivity issue
- Sync folder path misconfigured

**Fix:**
1. Check GDrive Desktop app status (system tray icon)
2. If paused: Resume sync
3. If crashed: Restart GDrive Desktop
4. Verify sync folder path: Is it correct in settings?
5. Manual backup: Run Robocopy command (see Basic Memory Setup section)

**Prevention:**
- Monitor GDrive sync status weekly
- Test sync: Create dummy file, verify appears in cloud within 5 minutes
- Have manual backup script ready (Robocopy or Git)

---

## Emergency Recovery Checklist

**When System Fails (Crash, Corruption, Total Loss):**

### Step 1: Assess Damage
- [ ] Can you open C:\Users\emirv\.basicmemory\ folder?
- [ ] Are files readable or corrupted?
- [ ] Is GDrive backup available?
- [ ] When was last checkpoint? (Check Session Notes dates)

### Step 2: Restore from Backup
- [ ] If GDrive backup exists: Download latest version
- [ ] If Git repo exists: `git pull` or restore from GitHub
- [ ] If no backup: Reconstruct from Session Notes + chat history

### Step 3: Verify Integrity
- [ ] Read Current_Focus.md (does it make sense?)
- [ ] Check Active_Projects.md (correct project list?)
- [ ] Validate WikiLinks (@validator agent)
- [ ] Test MCP connection (can Claude read Basic Memory?)

### Step 4: Resume Work
- [ ] Update Current_Focus.md (reflect actual current state)
- [ ] Document incident in: `99_ARCHIVE/Incidents/[YYYY-MM-DD]_recovery.md`
- [ ] Improve backup protocol (prevent future failure)

---

# 📚 APPENDIX: COMPRESSED CHAT HISTORY INSIGHTS

## Key Insights from Session 001 Conversation

### User Preferences (Emir):
- Wants token-efficient workflows (minimize unnecessary research)
- Prefers being asked rather than assumed
- Values "think harder" approach (Extended Thinking)
- Appreciates detailed documentation with full context
- Language: Serbian/Bosnian for communication
- Technical background: Understands concepts but prefers collaborative approach

### Critical Corrections:
1. **Basic Memory MUST be Local:** Cannot use GDrive Stream mode (MCP requirement)
2. **3 Separate KBs:** WUFF, ClickUp, Gemini each need own KB (not one unified)
3. **Teresa Protocol:** Interview method, not manual writing
4. **Human Router Acceptable:** Manual copy/paste OK initially (automate later)
5. **Extended Thinking:** Use proactively for strategic decisions

### Technical Environment:
- **OS:** Windows (win32)
- **Claude:** Desktop + Code (both available)
- **Basic Memory:** v0.17.2 (MCP active)
- **Obsidian:** Dual-vault setup (WuffUniversuM + Emir)
- **ClickUp:** Subscribed (€12/year + Brain Max)
- **Gemini:** Planned (Enterprise or API, decision pending)
- **Google Workspace:** Standard plan (GDrive, Gmail)

### Architecture Evolution:
- **Initial Idea:** Single KB, centralized
- **Revised:** 3 separate KBs (after understanding MCP local requirement)
- **Final:** Neural Mesh (WUFF local + ClickUp cloud + Gemini cloud)

### Workflow Patterns:
- **Session Start:** Read master memory → ask which project → load project context
- **Planning:** Extended Thinking before action (Teresa pattern)
- **Delegation:** Mission Command (high-level goals, not micromanagement)
- **Recovery:** Auto-resume protocol (file-based continuity)
- **Maintenance:** Weekly gardening (Sunday review)

### Folder Structure Decisions:
- **PARA Method:** Chosen over LIFT, Johnny Decimal, or custom
- **00-99 Prefixes:** Force alphabetical order (system files first, archive last)
- **C:\Projects\ vs C:\AI-Team\:** Separate development from orchestration
- **Basic Memory Location:** C:\Users\emirv\.basicmemory\ (standard MCP path)

### Mistakes & Lessons:
- ❌ Initially suggested GDrive Stream (corrected: must be local or Mirror)
- ❌ Assumed single unified KB (corrected: 3 separate KBs)
- ❌ Created file in wrong EmirVault folder (corrected: Emir Vault with space)
- ✅ Learned: Always verify folder paths before writing
- ✅ Learned: Ask before assuming architecture decisions
- ✅ Learned: User feedback is critical (Emir caught major errors)

---

# 📝 FINAL NOTES

## How to Use This Blueprint

### For WUFF (Claude):
1. **Every Session Start:** Read "CRITICAL CONTEXT" section (first page)
2. **Before Implementation:** Review relevant week in Implementation Roadmap
3. **When Stuck:** Check Templates & References section
4. **When Error:** Check Troubleshooting section
5. **For Research:** Consult Research & Learning Tasks

### For Emir:
1. **To Resume:** Give Claude this file path: `C:\Projects\Razvijanje Wuff sistema\WUFF-MASTER-BLUEPRINT-v1.0.md`
2. **To Start Week 1:** Follow Implementation Roadmap sequentially
3. **For Quick Ref:** Jump to specific template (PROJECT_SPEC, Mission Brief, etc.)
4. **For Decisions:** Review Architecture Overview and Teresa Insights

## Update Protocol

**This blueprint should be updated when:**
- Architecture changes (major decisions)
- New workflow patterns discovered
- Research tasks completed (add findings)
- Implementation deviates from plan (document why)
- Mistakes found (correct and note in errata)

**Update Process:**
1. WUFF edits this file (don't create v2.0 unless major overhaul)
2. Add "Last Updated" timestamp at top
3. Document changes in 99_ARCHIVE/blueprint-changelog.md
4. Commit to Git (if C:\Projects\ is Git repo)

## Success Metrics (How to Know WUFF is Working)

### Week 1 Success:
- ✅ Can start new Claude session → WUFF loads correct context automatically
- ✅ Folder structures exist and are organized
- ✅ One Mission Brief workflow tested end-to-end

### Week 4 Success:
- ✅ WUFF autonomously manages 2+ projects
- ✅ ClickUp Brain can answer questions about WuffUniversuM
- ✅ Weekly review completed without errors
- ✅ Interruption recovery tested and reliable

### Month 3 Success:
- ✅ WUFF delegates 80% of operational work (ClickUp/Gemini)
- ✅ Human Router latency reduced (Autopilot or API)
- ✅ 5+ projects completed using this system
- ✅ Knowledge base is valuable (Emir refers to it regularly)

### Year 1 Success:
- ✅ WUFF is indispensable (can't imagine working without it)
- ✅ System scales (handles 10+ concurrent projects)
- ✅ ROI positive (time saved > time spent on maintenance)
- ✅ Other teams/users adopt WUFF patterns

---

**END OF WUFF MASTER BLUEPRINT v1.0**

*This document is the complete specification for building WUFF Orchestrator.*
*All information needed to implement is contained here.*
*Next step: Begin Week 1 implementation.*

**Total Blueprint Size:** ~60K tokens
**Reading Time:** ~90 minutes (full read)
**Quick Context Load:** ~5 minutes (CRITICAL CONTEXT section only)

**Created By:** Claude Sonnet 3.5 + Emir Čenga
**Date:** 2025-01-01
**Version:** 1.0 (Initial Release)
**License:** Private (WuffUniversuM Internal Use)
