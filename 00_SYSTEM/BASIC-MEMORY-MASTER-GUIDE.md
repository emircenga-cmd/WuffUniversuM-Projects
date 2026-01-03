# basic-memory - Complete Master Guide

**Created:** 2026-01-03
**Purpose:** Comprehensive documentation of basic-memory - what it is, how it works, and how it's implemented in our system

---

## 📚 Table of Contents

1. [What is basic-memory?](#what-is-basic-memory)
2. [Core Capabilities](#core-capabilities)
3. [Technical Architecture](#technical-architecture)
4. [Our Implementation](#our-implementation)
5. [How to Use](#how-to-use)
6. [Workflow Examples](#workflow-examples)
7. [Why This Setup?](#why-this-setup)
8. [Troubleshooting](#troubleshooting)

---

## 🎯 What is basic-memory?

### Koncept

**basic-memory** je **MCP (Model Context Protocol) server** koji omogućava AI asistentima (kao što su Claude Desktop i Claude Code CLI) da imaju **perzistentnu memoriju** kroz markdown notes.

**Jednostavno rečeno:**
> Tvoji notes postaju **dugoročna memorija** za Claude. Umjesto da Claude zaboravi sve nakon sesije, on može pamtiti kroz .md fajlove koje indeksira basic-memory.

---

### Problem Koji Rješava

**BEZ basic-memory:**
```
Session 1:
  User: "Research MCP architecture"
  Claude: "Here's my research..."
  → Kreira notes

Session 2 (novi chat):
  User: "What did I research about MCP?"
  Claude: "I don't have context from previous sessions"
  ❌ ZABORAVIO JE SVE
```

**SA basic-memory:**
```
Session 1:
  User: "Research MCP architecture"
  Claude: "Here's my research..."
  → Sprema u basic-memory vault (Projects/Koding/knowledge/MCP-Research.md)
  → basic-memory indeksira u SQLite

Session 2 (novi chat):
  User: "What did I research about MCP?"
  Claude: → Čita iz basic-memory
         → "You researched MCP architecture, here's what you found..."
  ✅ PAMTI KROZ SESIJE!
```

---

## ⚡ Core Capabilities

### 1. **Markdown Notes Storage**

**Šta radi:**
- Skladišti knowledge kao markdown fajlove
- Podržava standard markdown syntax
- Git-friendly (verzionisanje)

**Primjer:**
```markdown
# MCP Architecture Research

## Key Findings
- MCP = Model Context Protocol
- Enables AI tools to connect to external data

[[Related: Claude Code Setup]]
```

---

### 2. **SQLite Indexing**

**Šta radi:**
- Kreira index svih .md fajlova u SQLite database
- Omogućava brzo full-text pretraživanje
- Prati metadata (created, modified dates)

**Database Schema:**
```sql
-- memory.db sadrži:
files (
  id,
  path,
  content,
  created_at,
  modified_at
)

wikilinks (
  source_file,
  target_file,
  link_text
)

tags (
  file_id,
  tag_name
)
```

**Benefit:** Brzo pretraživanje kroz hiljade notes-a!

---

### 3. **Wikilinks Support**

**Šta radi:**
- Detektuje `[[Internal Links]]` između notes-a
- Kreira graph relationships
- Omogućava navigaciju između povezanih notes-a

**Primjer:**
```markdown
# Note 1: WUFF Orchestrator

Architecture details...

See also: [[Sub-Agent Patterns]]

---

# Note 2: Sub-Agent Patterns

Implementation guide...

Related: [[WUFF Orchestrator]]
```

basic-memory zna da su ovi notes povezani!

---

### 4. **File Watching**

**Šta radi:**
- Prati promjene u vault folderu
- Automatski re-indeksira kad se .md fajl promijeni
- Real-time sync

**Workflow:**
```
1. Editiješ note u Obsidian
2. basic-memory detektuje promjenu (file watcher)
3. Re-indeksira fajl u SQLite
4. Claude Desktop vidi update odmah
```

**Benefit:** Promjene su odmah dostupne svim tool-ima!

---

### 5. **.bmignore Filtering**

**Šta radi:**
- Ignoriše fajlove/foldere koje ne želiš u index-u
- Koristi gitignore syntax
- Globalni + per-project ignore rules

**Benefit:** Indeksira SAMO relevantne fajlove (npr. samo .md)

---

### 6. **Multi-Project Support**

**Šta radi:**
- Može indexirati više vault-ova odjednom
- Ili jedan master vault sa pod-projektima

**Naš setup:**
```
Projects/ (master vault)
├── 00_SYSTEM/        # System docs
├── Koding/           # Dev project
└── Orkestrator/      # Future project

→ basic-memory vidi SVE kao jedan unified vault
```

---

## 🏗️ Technical Architecture

### High-Level Overview

```
┌─────────────────────────────────────────────────────┐
│                 MCP SERVER                          │
│  C:\Users\emirv\.basic-memory\                      │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │  config.json                                 │  │
│  │  - projects: { "wuff-projects": "C:\..." }  │  │ ◄─ CONFIG
│  │  - default_project: "wuff-projects"         │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │  memory.db (SQLite)                          │  │
│  │  - files table                               │  │
│  │  - wikilinks table                           │  │ ◄─ INDEX
│  │  - tags table                                │  │
│  │  - full-text search index                    │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │  .bmignore                                   │  │
│  │  - .*                                        │  │ ◄─ FILTERS
│  │  - .git                                      │  │
│  │  - *.js, *.py, *.json (code files)          │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │  File Watcher (background process)           │  │ ◄─ SYNC
│  │  - Prati Projects/ folder                    │  │
│  │  - Detektuje promjene                        │  │
│  │  - Re-indeksira automatski                   │  │
│  └──────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
                        │
                        │ MCP Protocol (stdio/JSON-RPC)
                        │
        ┌───────────────┴───────────────┐
        │                               │
        ▼                               ▼
┌───────────────────┐         ┌──────────────────┐
│  Claude Desktop   │         │ Claude Code CLI  │
│                   │         │                  │
│  .mcp.json:       │         │  .mcp.json:      │
│  - wuff-projects  │         │  - wuff-projects │
│  - clickup        │         │                  │
└───────────────────┘         └──────────────────┘
        │                               │
        │                               │
        └───────────────┬───────────────┘
                        │
                        │ Read/Write .md files
                        │
                        ▼
        ┌────────────────────────────────────┐
        │  VAULT (Data Storage)              │
        │  C:\Claude Code Projects\Projects\ │
        │                                    │
        │  ├── 00_SYSTEM\                    │
        │  │   ├── *.md                      │
        │  │   └── .bmignore                 │
        │  │                                 │
        │  ├── Koding\                       │
        │  │   ├── docs\*.md                 │
        │  │   ├── knowledge\*.md            │
        │  │   ├── .git/                     │
        │  │   ├── src/ (ignored)            │
        │  │   └── .bmignore                 │
        │  │                                 │
        │  └── Orkestrator\                  │
        │      └── .bmignore                 │
        └────────────────────────────────────┘
```

---

### Component Breakdown

#### 1. **MCP Server Process**

**Lokacija:** Instaliran globalno (Python package)

**Pokretanje:**
```bash
uvx --python 3.12 basic-memory mcp
```

**Šta radi:**
- Čita config.json → zna gdje je vault
- Učitava memory.db → SQLite index
- Pokreće file watcher → prati promjene
- Sluša MCP requests → od Claude Desktop/CLI
- Vraća responses → markdown content, search results

**Communication:** JSON-RPC over stdio (standard input/output)

---

#### 2. **Config File (config.json)**

**Lokacija:** `C:\Users\emirv\.basic-memory\config.json`

**Sadržaj:**
```json
{
  "env": "dev",
  "projects": {
    "wuff-projects": "C:\\Claude Code Projects\\Projects"
  },
  "default_project": "wuff-projects",
  "default_project_mode": true,
  "log_level": "INFO",
  "database_backend": "sqlite",
  "sync_changes": true,
  "watch_project_reload_interval": 300
}
```

**Ključni parametri:**
- `projects` → gdje je vault folder
- `default_project` → koji projekt koristiti
- `sync_changes: true` → automatski sync
- `watch_project_reload_interval: 300` → prati promjene svakih 5min

---

#### 3. **SQLite Database (memory.db)**

**Lokacija:** `C:\Users\emirv\.basic-memory\memory.db`

**Šta sadrži:**
- **File metadata** - paths, dates
- **Content index** - full-text search
- **Wikilinks graph** - relationships između notes-a
- **Tags** - #tags iz notes-a

**Veličina:** ~200KB (trenutno, raste sa više notes-a)

**Napomena:** Ovo je INDEX, ne full storage! Stvarni .md fajlovi su u Projects folderu.

---

#### 4. **Ignore Rules (.bmignore)**

**Globalni:** `C:\Users\emirv\.basic-memory\.bmignore`

**Per-project:** `Projects/Koding/.bmignore`

**Kombinovanje:**
```
Globalni .bmignore:
  - .*              (sve hidden files)
  - .git
  - node_modules
  - *.js, *.py      (code files)

Per-project .bmignore (Koding/.bmignore):
  - src/            (source code folder)
  - dist/           (build artifacts)

Rezultat: Ignorišu se SVI iz oba fajla
```

---

## 🔧 Our Implementation

### System Overview

**Naš setup koristi:**
1. ✅ **Jedan master vault** (`Projects/`)
2. ✅ **Multi-project organizacija** (00_SYSTEM, Koding, Orkestrator)
3. ✅ **Para system** (numbered folders - 00_, 01_)
4. ✅ **Nested Git repos** (svaki projekt ima svoj .git)
5. ✅ **Project-specific .bmignore** (fine-grained filtering)
6. ✅ **Dual-app access** (Claude Desktop + Claude Code CLI)

---

### Folder Structure

```
C:\Users\emirv\.basic-memory\          # MCP SERVER
├── config.json                        # → Points to Projects/
├── memory.db                          # → SQLite index (14 .md files)
└── .bmignore                          # → Global filters

C:\Users\emirv\.claude\                # Claude Code config
└── .mcp.json                          # → MCP client config

C:\Users\emirv\AppData\Roaming\Claude\ # Claude Desktop config
└── claude_desktop_config.json         # → MCP client config

C:\Claude Code Projects\Projects\     # VAULT (Master)
│
├── .obsidian\                         # Obsidian vault config
│
├── 00_SYSTEM\                         # System-wide docs
│   ├── .bmignore                      # Project-specific filters
│   ├── BASIC-MEMORY-MASTER-GUIDE.md   # (this file)
│   ├── MCP-BASIC-MEMORY-SETUP.md
│   ├── OBSIDIAN-VAULT-SETUP.md
│   ├── SETUP-COMPLETE-SUMMARY.md
│   ├── CLEANUP-COMPLETED.md
│   └── Claude-Code-Architecture.md
│
├── 01_ARCHIVES\                       # Archived projects
│   └── .bmignore
│
├── Koding\                            # Dev & Support project
│   ├── .git\                          # Git repo (ignored by basic-memory)
│   ├── .claude\                       # Claude Code project config
│   ├── .bmignore                      # Ignores .git, src/, etc.
│   │
│   ├── docs\                          # Official project docs
│   │   ├── WUFF-MASTER-BLUEPRINT-v1.0.md
│   │   ├── PROJECT_MEMORY.md
│   │   ├── SESSION-START-CHECKLIST.md
│   │   └── BACKUP-AND-RECOVERY-GUIDE.md
│   │
│   ├── knowledge\                     # Research & experiments
│   │   ├── FINALNA ARHITEKTURA - Orchestrator i Sub-Agenti.md
│   │   ├── Gemini deep research na osnovu prompta.md
│   │   ├── Specialized Agents with Own Memory.md
│   │   ├── Sub-Agent System Prompts.md
│   │   ├── Sub-Agents vs Skills.md
│   │   ├── VERIFIED - MCP Tool Naming.md
│   │   └── WUFF Orchestrator - Custom Sub-Agent System Setup.md
│   │
│   ├── src\                           # Code (IGNORED by basic-memory)
│   ├── CLAUDE.md                      # Claude Code context
│   └── README.md
│
└── Orkestrator\                       # Future orchestrator project
    └── .bmignore
```

**Total:** 14 markdown fajlova trenutno indeksirano

---

### MCP Configuration

#### Claude Desktop

**File:** `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "wuff-projects": {
      "command": "uvx",
      "args": ["--python", "3.12", "basic-memory", "mcp"]
    },
    "clickup": {
      "command": "npx",
      "args": ["-y", "@taazkareem/clickup-mcp-server"],
      "env": {
        "CLICKUP_API_TOKEN": "pk_...",
        "CLICKUP_TEAM_ID": "90152150888"
      }
    }
  }
}
```

**MCP Servers:**
- ✅ `wuff-projects` (basic-memory)
- ✅ `clickup` (ClickUp integration)
- ❌ ~~`emir-vault`~~ (obsidian-mcp) - UKLONJENO (trošilo tokene, vault obrisan)

---

#### Claude Code CLI

**File:** `C:\Users\emirv\.claude\.mcp.json`

```json
{
  "mcpServers": {
    "wuff-projects": {
      "command": "uvx",
      "args": ["--python", "3.12", "basic-memory", "mcp"]
    }
  }
}
```

**Status:** ✅ Konfigurisano (aktivan nakon restart-a)

---

### .bmignore Configuration

#### Global .bmignore

**File:** `C:\Users\emirv\.basic-memory\.bmignore`

**Filters:**
```
# Hidden files
.*

# Version control
.git
.svn

# Dependencies
node_modules

# Build artifacts
build
dist
.cache

# IDE
.vscode
.idea

# OS
.DS_Store
Thumbs.db

# Obsidian
.obsidian

# CODE FILES (basic-memory should ONLY index .md)
*.py
*.js
*.ts
*.tsx
*.jsx
*.json
*.html
*.css
*.scss
*.java
*.c
*.cpp
*.go
*.rs
*.rb
*.php
*.sh
*.bat
*.ps1
*.yml
*.yaml
*.toml
*.xml

# Source directories
src/
lib/
vendor/
```

**Rezultat:** Indeksira **SAMO .md fajlove**!

---

#### Project-Specific .bmignore

**File:** `Projects/Koding/.bmignore` (isti u svim projektima)

```
# Version control
.git
.svn

# Dependencies
node_modules

# Build outputs
dist
build
.cache

# Code files (NOT knowledge)
*.py
*.js
*.json
*.ts
*.tsx
*.jsx
src/
lib/

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db
```

**Napomena:** Globalni + project-specific = kombinuju se

---

## 📖 How to Use

### Basic Operations

#### 1. **Kreiranje Novog Note-a**

**Option A: Claude Desktop**
```
User: "Create a research note about [topic] in wuff-projects"

Claude Desktop:
  → Koristi basic-memory MCP
  → Pitaj gdje da kreira (00_SYSTEM, Koding/knowledge, etc.)
  → Kreira .md fajl
  → basic-memory automatski indeksira
```

**Option B: Ručno (Obsidian/VS Code)**
```
1. Otvori Projects folder u Obsidian
2. Kreiraj novi .md fajl u odgovarajućem folderu
3. basic-memory detektuje (file watcher)
4. Automatski indeksira u SQLite
```

**Option C: Claude Code CLI**
```
User: "Create a note about MCP setup"

Claude Code:
  → Koristi Write tool
  → Kreira .md fajl u Projects/Koding/knowledge/
  → basic-memory sync-uje
```

---

#### 2. **Pretraživanje Notes-a**

**U Claude Desktop:**
```
User: "Search wuff-projects for notes about orchestrator architecture"

Claude Desktop:
  → Koristi basic-memory MCP search
  → Query SQLite index
  → Vraća matching notes
```

**U Claude Code CLI:**
```
User: "What did I document about sub-agents?"

Claude Code:
  → Koristi basic-memory MCP
  → Pretraži index
  → Prikaže relevantne notes
```

---

#### 3. **Čitanje Specific Note-a**

```
User: "Show me the content of FINALNA ARHITEKTURA note"

Claude:
  → basic-memory search by title
  → Read from Projects/Koding/knowledge/FINALNA ARHITEKTURA...md
  → Display content
```

---

#### 4. **Kreiranje Wikilinks**

**U note-u:**
```markdown
# WUFF Orchestrator Setup

Architecture details...

Related reading:
- [[Sub-Agent System Prompts]]
- [[MCP Integration Guide]]

See also: [[00_SYSTEM/BASIC-MEMORY-MASTER-GUIDE]]
```

**basic-memory:**
- Detektuje `[[wikilinks]]`
- Kreira relationships u SQLite
- Omogućava graph navigation

---

#### 5. **Listing All Notes**

```
User: "List all markdown files in wuff-projects"

Claude:
  → basic-memory list files
  → Prikaže sve .md fajlove sa paths
```

---

#### 6. **Updating Existing Note**

**Option A: Direktno editovanje**
```
1. Otvori .md fajl u Obsidian/VS Code
2. Napravi izmjene
3. Sačuvaj
4. basic-memory detektuje promjenu (file watcher)
5. Re-indeksira automatski
```

**Option B: Kroz Claude**
```
User: "Update the MCP setup note with new information"

Claude:
  → Koristi Edit tool na existing .md fajl
  → basic-memory sync-uje
```

---

### Advanced Usage

#### Tagging System

**U note-u:**
```markdown
# Research Note

#research #mcp #architecture

Content here...
```

**basic-memory:**
- Detektuje #tags
- Indeksira u tags table
- Omogućava search by tag

**Query:**
```
User: "Show all notes tagged with #research"
```

---

#### Cross-Project References

```markdown
# Note u Koding projektu
[[00_SYSTEM/MCP-BASIC-MEMORY-SETUP]]

# Note u 00_SYSTEM
[[Koding/knowledge/FINALNA ARHITEKTURA]]
```

basic-memory razumije cross-project wikilinks!

---

## 🔄 Workflow Examples

### Scenario 1: Research Session

**Goal:** Istraživanje MCP arhitekture i spremanje knowledge

```
Step 1: Research (Claude Desktop)
───────────────────────────────────
User: "Research MCP architecture and create detailed notes"

Claude Desktop:
  1. Research-uje MCP
  2. Kreira: Projects/Koding/knowledge/MCP-Architecture-Deep-Dive.md
  3. basic-memory indeksira automatski

Step 2: Cross-Reference (Later)
────────────────────────────────
User: "Link this to our orchestrator architecture"

Claude Desktop:
  1. Otvara MCP-Architecture-Deep-Dive.md
  2. Dodaje: [[FINALNA ARHITEKTURA - Orchestrator i Sub-Agenti]]
  3. basic-memory detektuje wikilink
  4. Kreira relationship u graph

Step 3: Retrieval (Novi Session)
─────────────────────────────────
User: "What did I learn about MCP architecture?"

Claude Desktop:
  → Search basic-memory
  → Pronalazi MCP-Architecture-Deep-Dive.md
  → "You researched MCP in detail, here's what you found..."
  ✅ PERSISTENT CONTEXT!
```

---

### Scenario 2: Multi-Session Development

**Goal:** Razvoj feature-a kroz više dana

```
Day 1 - Planning (Claude Code CLI)
───────────────────────────────────
User: "Plan the sub-agent architecture"

Claude Code:
  1. Kreira plan
  2. Sprema: Projects/Koding/knowledge/Sub-Agent-Implementation-Plan.md
  3. basic-memory indeksira

Day 2 - Implementation (Claude Code CLI)
────────────────────────────────────────
User: "Continue working on sub-agent implementation"

Claude Code:
  → Čita Sub-Agent-Implementation-Plan.md iz basic-memory
  → Nastavlja gdje je stao
  → Updates plan sa progress notes

Day 3 - Review (Claude Desktop)
───────────────────────────────
User: "Review sub-agent implementation progress"

Claude Desktop:
  → Čita kroz basic-memory
  → "You're on Day 3 of implementation, here's the status..."
  ✅ CONTINUITY ACROSS DAYS!
```

---

### Scenario 3: Knowledge Sharing

**Goal:** Claude Desktop i Claude Code dijele kontekst

```
Morning - Claude Desktop (Research)
────────────────────────────────────
User: "Research best practices for MCP servers"

Claude Desktop:
  1. Research
  2. Kreira: Projects/00_SYSTEM/MCP-Best-Practices.md
  3. basic-memory sync

Afternoon - Claude Code CLI (Implementation)
────────────────────────────────────────────
User: "Implement MCP server following best practices"

Claude Code:
  → Čita MCP-Best-Practices.md iz basic-memory
  → "Based on the research from this morning..."
  → Implements kod
  ✅ SHARED KNOWLEDGE BASE!
```

---

## 🎯 Why This Setup?

### Design Decisions

#### 1. **Zašto Jedan Master Vault?**

**Odluka:** `Projects/` kao jedan veliki vault

**Alternativa:** Više odvojenih vault-ova (WuffUniversuM, Emir, Koding)

**Zašto smo izabrali master vault:**
- ✅ Jednostavniji setup (jedan config)
- ✅ Cross-project wikilinks rade out-of-the-box
- ✅ Unified search kroz sve projekte
- ✅ Jedna SQLite database (brže)
- ✅ Lakši backup (jedan folder)

**Trade-off:**
- ⚠️ Mora pažljivo koristiti .bmignore (da ne indeksira code)
- Rješenje: Globalni + per-project .bmignore

---

#### 2. **Zašto Para System Organizacija?**

**Odluka:** `00_SYSTEM`, `01_ARCHIVES`, project folders

**Zašto:**
- ✅ Numerisani folderi = sortiranje (00_ uvijek prvi)
- ✅ Jasna hijerarhija (system > projekti > archives)
- ✅ Skalabilno (lako dodati 02_, 03_)
- ✅ Standard u knowledge management

---

#### 3. **Zašto Nested Git Repos?**

**Odluka:** Svaki projekt (Koding) ima svoj .git folder unutar vault-a

**Alternativa:** Cijeli Projects folder kao jedan Git repo

**Zašto nested:**
- ✅ Izolovano verzionisanje po projektu
- ✅ Različiti GitHub repos za različite projekte
- ✅ Nezavisni workflow (commit Koding bez 00_SYSTEM)
- ✅ .bmignore filtrira .git foldere (basic-memory ih ne vidi)

---

#### 4. **Zašto Dual .bmignore (Global + Per-Project)?**

**Odluka:** Globalni ignore + project-specific ignore

**Zašto:**
- ✅ **Globalni** = default rules (*.js, *.py, .git)
- ✅ **Per-project** = custom rules (npr. Koding ignoriše src/)
- ✅ Kombinuju se = maximum filtering precision
- ✅ 100% garantovano SAMO .md fajlovi

---

#### 5. **Zašto basic-memory umjesto obsidian-mcp?**

**Odluka:** Koristimo basic-memory, uklonjeno obsidian-mcp

**Zašto:**
- ✅ basic-memory = generalno rješenje (ne vezano za Obsidian)
- ✅ SQLite indexing = brže pretraživanje
- ✅ Wikilinks + tags = bolja organizacija
- ✅ obsidian-mcp = trošio tokene, vault više ne postoji
- ✅ Možemo koristiti Obsidian kao viewer (vault = Projects)

---

#### 6. **Zašto Dual-App Access?**

**Odluka:** I Claude Desktop I Claude Code koriste basic-memory

**Zašto:**
- ✅ Claude Desktop = GUI, research, brainstorming
- ✅ Claude Code CLI = terminal, coding, automation
- ✅ Shared knowledge base = continuity
- ✅ Use right tool za right job

---

### Benefits Summary

**Naš setup omogućava:**

1. ✅ **Persistent Context** - Claude pamti kroz sesije
2. ✅ **Centralized Knowledge** - Sve na jednom mjestu
3. ✅ **Fast Search** - SQLite indexing
4. ✅ **Cross-Project Links** - Wikilinks između svih projekata
5. ✅ **Multi-Tool Access** - Desktop + CLI
6. ✅ **Git-Friendly** - Verzionisanje knowledge
7. ✅ **Obsidian Compatible** - Možeš vidjeti u Obsidian vault-u
8. ✅ **Automatic Sync** - File watcher prati promjene
9. ✅ **Clean Filtering** - .bmignore garantuje samo .md
10. ✅ **Scalable** - Lako dodati nove projekte

---

## 🚨 Troubleshooting

### Problem: Claude ne vidi basic-memory

**Simptomi:**
- Claude Desktop ne prikazuje notes
- "No notes found" error

**Debug koraci:**

1. **Provjeri MCP config:**
```bash
# Claude Desktop
cat "%APPDATA%\Claude\claude_desktop_config.json"

# Claude Code CLI
cat "C:\Users\emirv\.claude\.mcp.json"

# Expected: Vidiš "wuff-projects" MCP server
```

2. **Restart aplikaciju:**
```bash
# Potpuno zatvori Claude Desktop/Code
# Ponovo otvori
```

3. **Provjeri basic-memory instalaciju:**
```bash
uvx --python 3.12 basic-memory --version
# Expected: Prikazuje verziju
```

4. **Provjeri logs:**
```bash
# Claude Desktop logs
cat "%APPDATA%\Claude\logs\mcp-*.log"
```

---

### Problem: basic-memory indeksira code fajlove

**Simptomi:**
- SQLite memory.db sadrži *.js, *.py fajlove
- Search vraća code umjesto markdown

**Fix:**

1. **Provjeri .bmignore:**
```bash
cat "C:\Users\emirv\.basic-memory\.bmignore"
# Expected: Vidiš *.js, *.py, *.ts, etc.
```

2. **Dodaj missing patterns:**
```bash
# Edit .bmignore
# Dodaj linije za fajlove koje želiš ignorirati
```

3. **Reset database:**
```bash
# Zatvori Claude Desktop/Code
rm "C:\Users\emirv\.basic-memory\memory.db"
# Ponovo otvori - basic-memory kreira clean index
```

---

### Problem: Wikilinks ne rade

**Simptomi:**
- `[[Link]]` se ne detektuju
- Graph relationships prazni

**Debug:**

1. **Provjeri syntax:**
```markdown
# Correct
[[Note Title]]
[[Folder/Note Title]]

# Incorrect
[Note Title]         (single brackets)
[[Note Title.md]]    (ne treba .md extension)
```

2. **Provjeri da note postoji:**
```bash
# Search za target note
find "/c/Claude Code Projects/Projects" -name "*Note Title*"
```

3. **Re-index:**
```bash
# Reset memory.db (vidi gornji koraci)
```

---

### Problem: Slow search

**Simptomi:**
- basic-memory search traje dugo
- memory.db veliki (>10MB)

**Optimizacija:**

1. **Provjeri .bmignore** - možda indeksira previše fajlova

2. **Optimize SQLite:**
```bash
# Ovo će basic-memory uraditi automatski
# Ali možeš ručno:
sqlite3 "C:\Users\emirv\.basic-memory\memory.db" "VACUUM;"
```

3. **Split vault** - ako imaš 1000+ notes, razmotri više vault-ova

---

### Problem: File changes ne sync-uju

**Simptomi:**
- Editiraš .md u Obsidian
- Claude ne vidi promjene

**Fix:**

1. **Provjeri file watcher config:**
```bash
cat "C:\Users\emirv\.basic-memory\config.json"
# Provjeri: "sync_changes": true
```

2. **Wait interval:**
```json
"watch_project_reload_interval": 300
```
File watcher check-uje svakih 5min (300sec). Sačekaj malo!

3. **Manual sync:**
```bash
# Restart Claude Desktop/Code
# basic-memory će re-scanirati vault
```

---

## 📚 Additional Resources

### Official Documentation

- **basic-memory GitHub:** https://github.com/cktang88/basic-memory
- **MCP Documentation:** https://modelcontextprotocol.io/

### Our Documentation

- `MCP-BASIC-MEMORY-SETUP.md` - Setup instructions
- `OBSIDIAN-VAULT-SETUP.md` - Obsidian integration
- `SETUP-COMPLETE-SUMMARY.md` - System overview
- `CLEANUP-COMPLETED.md` - Cleanup process
- `SESSION-START-CHECKLIST.md` - Startup checklist

---

## ✅ Summary

### What is basic-memory?

> **MCP server** koji daje Claude-u **persistent memory** kroz markdown notes, SQLite indexing, i wikilinks.

### How does it work?

> basic-memory **prati** vault folder (Projects), **indeksira** .md fajlove u SQLite, i **omogućava** Claude-u da **traži** i **čita** notes kroz MCP protocol.

### Our implementation?

> **Jedan master vault** (Projects) sa **multi-project** organizacijom, **dual-app access** (Desktop + CLI), **nested Git repos**, i **comprehensive .bmignore filtering**.

### Why this setup?

> **Centralizovan**, **scalable**, **Git-friendly**, **fast search**, **cross-project links**, i **shared knowledge base** između Claude Desktop i Claude Code CLI.

---

**🎉 basic-memory je CORE component našeg knowledge management sistema! 🎉**

**Created:** 2026-01-03 | **Author:** Claude Sonnet 4.5 + Emir
