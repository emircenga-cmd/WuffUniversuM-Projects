# basic-memory MCP Server - Final Setup

**Date:** 2026-01-03
**Status:** ✅ FULLY CONFIGURED

---

## 🎯 Šta je basic-memory?

basic-memory je **MCP (Model Context Protocol) server** koji omogućava:
- 📝 Perzistentno skladištenje markdown notes
- 🔍 SQLite indexing za brzo pretraživanje
- 🔗 Wikilinks između notes-a
- 💾 Persistent context across chat sessions

**Jednostavno rečeno:** Tvoje notes postaju **dugoročna memorija** za Claude!

---

## ✅ Trenutni Setup

### 1. **MCP Server Instalacija**

**Lokacija:** `C:\Users\emirv\.basic-memory\`

**Ključni fajlovi:**
- `config.json` - Konfiguracija (pokazuje na Projects folder)
- `memory.db` - SQLite database (index svih .md fajlova)
- `.bmignore` - Globalni ignore rules

### 2. **Gdje je Konfigurisano**

| Aplikacija | Config File | Status |
|-----------|------------|--------|
| **Claude Desktop** | `%APPDATA%\Claude\claude_desktop_config.json` | ✅ ACTIVE |
| **Claude Code CLI** | `C:\Users\emirv\.claude\.mcp.json` | ✅ ACTIVE |

**Rezultat:** I Claude Desktop I Claude Code mogu koristiti basic-memory!

---

## 📂 Storage Location

**Projects Folder kao Master Vault:**
```
C:\Claude Code Projects\Projects\
├── 00_SYSTEM\              # System docs
├── Koding\                 # Dev project
│   ├── test\               # Research notes
│   ├── docs\               # Official docs
│   └── knowledge\          # Ongoing knowledge
├── Orkestrator\            # Future project
└── (tvoji custom projekti)
```

**basic-memory indeksira SVE .md fajlove u svim pod-folderima!**

---

## 🔧 Konfiguracija

### basic-memory Config

**File:** `C:\Users\emirv\.basic-memory\config.json`
```json
{
  "projects": {
    "wuff-projects": "C:\\Claude Code Projects\\Projects"
  },
  "default_project": "wuff-projects",
  "default_project_mode": true
}
```

**Šta ovo znači:**
- basic-memory gleda `C:\Claude Code Projects\Projects\`
- Automatski indeksira sve .md fajlove
- Ignoriše Git, code, builds (vidi .bmignore)

---

### Claude Desktop MCP Config

**File:** `C:\Users\emirv\AppData\Roaming\Claude\claude_desktop_config.json`
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
        "CLICKUP_API_TOKEN": "pk_266648919_281MTXYJA7TEFB6TGJB4HIML6KB1CQQN",
        "CLICKUP_TEAM_ID": "90152150888"
      }
    }
  }
}
```

**MCP Serveri:**
- ✅ `wuff-projects` (basic-memory) - Knowledge management
- ✅ `clickup` - ClickUp task integration
- ❌ ~~`emir-vault`~~ (obsidian-mcp) - **UKLONJENO** (trošilo tokene, vault obrisan)

---

### Claude Code CLI MCP Config

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

**Rezultat:** Claude Code (CLI) sada može koristiti basic-memory!

---

## 🛡️ .bmignore - Šta se IGNORIŠE

**Globalni .bmignore:** `C:\Users\emirv\.basic-memory\.bmignore`

**Ignoriše:**
- ✅ Hidden files (.*)
- ✅ Version control (.git, .svn)
- ✅ Dependencies (node_modules)
- ✅ Build artifacts (dist, build)
- ✅ IDE folders (.vscode, .idea)
- ✅ OS files (.DS_Store, Thumbs.db)
- ✅ **SVE code fajlove** (*.js, *.py, *.ts, *.json, *.html, itd.)
- ✅ Source directories (src/, lib/, vendor/)

**Indeksira SAMO:**
- ✅ **Markdown fajlove (.md)**

**Plus:** Svaki projekat ima svoj `.bmignore` za dodatne project-specific ignore rules.

---

## 🚀 Kako Koristiti basic-memory

### U Claude Desktop:

1. **Restart Claude Desktop** (da učita novu MCP config)
2. U chatu pitaj:
   ```
   List all markdown files in wuff-projects vault
   ```
3. Claude će koristiti basic-memory MCP da prikaže sve notes

### U Claude Code CLI:

1. **Restart Claude Code session** (exit i ponovo `claude-code chat`)
2. basic-memory MCP server će biti dostupan
3. Claude Code može čitati i pretraživati sve .md notes

### Kreiranje Novih Notes:

**Option 1: Claude Desktop**
```
Create a new note about [topic] in wuff-projects vault
```

**Option 2: Ručno (Obsidian/VS Code)**
- Kreiraj .md fajl u `Projects/Koding/knowledge/`
- basic-memory automatski detektuje i indeksira

**Option 3: Claude Code**
- Koristi Write tool da kreira .md fajl
- basic-memory sync-uje automatski

---

## 🔄 Workflow Primjer

### Scenario: Kreiranje Research Note

```
1. Ti (u Claude Desktop):
   "Create a research note about Claude MCP architecture"

2. Claude Desktop:
   → Koristi basic-memory MCP
   → Kreira: Projects/Koding/knowledge/MCP-Architecture-Research.md
   → Automatski indeksira u SQLite

3. basic-memory:
   → Detektuje novi .md fajl
   → Index-uje sadržaj
   → Spreman za search i retrieval

4. Kasnije (u Claude Code CLI):
   "What did I research about MCP architecture?"
   → Claude Code čita iz basic-memory
   → Vidi prethodni research note
   → Odgovara na osnovu saved context
```

**Rezultat: Persistent knowledge across sessions!**

---

## ⚡ Reset Database (Clean Start)

Ako želiš potpuno clean start (reset SQLite index):

### 1. Zatvori sve Claude aplikacije
```bash
# Close Claude Desktop
# Exit Claude Code CLI
```

### 2. Obriši memory.db
```bash
rm "C:\Users\emirv\.basic-memory\memory.db"
```

### 3. Restart Claude Desktop
- basic-memory će kreirati novi memory.db
- Automatski indeksira sve .md iz Projects foldera

---

## 📊 MCP Status - Before vs After

### PRIJE (Konfuzija):
- ❌ Claude Desktop: 3 MCP servera (basic-memory + obsidian + clickup)
- ❌ Claude Code CLI: NEMA MCP pristup
- ❌ obsidian-mcp server pokazuje na obrisani vault (trošio tokene)
- ❌ Duplirani vault-ovi (WuffUniversuM, Emir)

### POSLIJE (Clean):
- ✅ Claude Desktop: 2 MCP servera (basic-memory + clickup)
- ✅ Claude Code CLI: 1 MCP server (basic-memory)
- ✅ Jedan centralizovan vault (Projects folder)
- ✅ Globalni .bmignore optimizovan (SAMO .md fajlovi)
- ✅ Oba tool-a koriste isti basic-memory server

---

## 🧪 Testiranje

### Test 1: Claude Desktop

```
Pitaj u Claude Desktop:
"Can you list all markdown files in wuff-projects?"

Expected: Vidi sve .md iz Projects/00_SYSTEM, Koding/test, Koding/docs
```

### Test 2: Claude Code CLI

```
Pitaj u Claude Code:
"What research notes do we have in the vault?"

Expected: Može pročitati .md fajlove kroz basic-memory MCP
```

### Test 3: Kreiranje Note

```
U Claude Desktop:
"Create a test note in wuff-projects about basic-memory setup"

Expected: Kreira .md fajl u Projects folder, automatski indeksiran
```

---

## 📝 Privatni Folder Setup (Optional)

Ako želiš privatni folder unutar Projects:

```bash
# Kreiraj folder
mkdir "/c/Claude Code Projects/Projects/Emir-Personal"
mkdir "/c/Claude Code Projects/Projects/Emir-Personal/Ideas"
mkdir "/c/Claude Code Projects/Projects/Emir-Personal/Private"

# Kopiraj .bmignore
cp "/c/Claude Code Projects/Projects/00_SYSTEM/.bmignore" "/c/Claude Code Projects/Projects/Emir-Personal/.bmignore"
```

**Rezultat:** basic-memory će indeksirati i Emir-Personal folder automatski!

---

## 🎯 Benefits ovog Setup-a

1. ✅ **Unified Knowledge Base** - Sve notes na jednom mjestu
2. ✅ **Persistent Context** - Claude pamti kroz sesije
3. ✅ **SQLite Indexing** - Brzo pretraživanje
4. ✅ **Wikilinks** - Povezivanje notes-a
5. ✅ **Git-friendly** - Sve verzionisano
6. ✅ **Obsidian Integration** - Možeš vidjeti u Obsidian vault-u
7. ✅ **Multi-tool Access** - Claude Desktop + Claude Code CLI
8. ✅ **Automatic Filtering** - .bmignore garantuje SAMO .md

---

## 🚨 Troubleshooting

### Claude Desktop ne vidi basic-memory

**Problem:** MCP server nije pokrenut
**Fix:**
```bash
# 1. Restart Claude Desktop (potpuno zatvori i ponovo otvori)
# 2. Provjeri config:
cat "%APPDATA%\Claude\claude_desktop_config.json"
# 3. Provjeri da uvx radi:
uvx --python 3.12 basic-memory --version
```

### Claude Code CLI ne vidi MCP

**Problem:** .mcp.json nije učitan
**Fix:**
```bash
# 1. Provjeri da fajl postoji:
cat "C:\Users\emirv\.claude\.mcp.json"
# 2. Restart Claude Code session (exit i ponovo chat)
```

### basic-memory indeksira code fajlove

**Problem:** .bmignore nije konfigurisano
**Fix:**
```bash
# Provjeri global .bmignore:
cat "C:\Users\emirv\.basic-memory\.bmignore"
# Dodaj missing patterns ako treba
```

---

## ✅ Status: FULLY CONFIGURED

- [x] basic-memory instaliran
- [x] Config pokazuje na Projects folder
- [x] Claude Desktop konfigurisano
- [x] Claude Code CLI konfigurisano
- [x] Globalni .bmignore optimizovan
- [x] obsidian-mcp server uklonjen
- [x] ClickUp MCP zadržan
- [x] SQLite database ready (reset nakon restart-a)

**🎉 basic-memory je SPREMAN ZA KORIŠTENJE! 🎉**
