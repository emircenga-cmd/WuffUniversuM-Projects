# WUFF Orchestrator - Backup & Recovery Guide

**Last Updated:** 2026-01-03

## 📊 KOMPONENTE ZA BACKUP

### 1. **Koding Projekat** ✅ SOLVED
- **Lokacija:** `C:\Claude Code Projects\Projects\Koding\`
- **GitHub Repo:** https://github.com/emircenga-cmd/Koding
- **Status:** ✅ Automatski sync-ovan sa GitHub-om
- **Backup Strategy:** Git push nakon svake značajne izmjene

```bash
cd "C:\Claude Code Projects\Projects\Koding"
git add -A
git commit -m "Your message"
git push origin master
```

---

### 2. **basic-memory MCP Server** ✅ SOLVED
- **Lokacija:** `C:\Claude Code Projects\MCPs\basic-memory\`
- **GitHub Repo:** https://github.com/emircenga-cmd/basic-memory
- **Status:** ✅ Već ima GitHub repo
- **Backup Strategy:** Git push nakon izmjena u memory filovima

```bash
cd "C:\Claude Code Projects\MCPs\basic-memory"
git add -A
git commit -m "Update memory files"
git push origin main
```

---

### 3. **Claude Code System Folder** ⚠️ NEEDS SOLUTION

**Lokacija:** `C:\Users\emirv\.claude\`

**Šta sadrži:**
```
.claude/
├── .credentials.json      # GitHub/Claude login credentials
├── settings.json          # Global preferences
├── history.jsonl          # Chat history
├── projects/              # Project metadata
├── todos/                 # Todo snapshots
├── file-history/          # File edit history
├── plans/                 # Saved plans
└── ...
```

#### 🎯 BACKUP STRATEGIJE:

**Option A: Google Drive Sync (Preporučujem)**

1. **Setup:**
   ```bash
   # Kreiraj backup folder na Google Drive
   mkdir "C:\Users\emirv\Google Drive\.claude-backup"

   # Kopiraj cijeli .claude folder
   robocopy "C:\Users\emirv\.claude" "C:\Users\emirv\Google Drive\.claude-backup" /MIR /XD node_modules
   ```

2. **Automatizacija (Optional):**
   - Kreiraj `.bat` script za backup
   - Schedule sa Windows Task Scheduler (daily/weekly)

**Script:** `C:\Users\emirv\backup-claude.bat`
```batch
@echo off
echo Backing up Claude Code system folder...
robocopy "C:\Users\emirv\.claude" "C:\Users\emirv\Google Drive\.claude-backup" /MIR /XD node_modules /XD statsig /XD shell-snapshots
echo Backup completed!
pause
```

**Option B: Git Repo za Selective Backup**

Backup SAMO važnih fajlova (ne cijeli folder):

```bash
# Kreiraj novi Git repo
mkdir "C:\Users\emirv\.claude-important-backup"
cd "C:\Users\emirv\.claude-important-backup"
git init

# Kopiraj važne fajlove
cp "C:\Users\emirv\.claude\settings.json" .
cp "C:\Users\emirv\.claude\.credentials.json" .
# (NE copy history.jsonl - preveliki)

# Push na GitHub private repo
git add -A
git commit -m "Claude Code settings backup"
gh repo create claude-config-backup --private --source=. --push
```

**Option C: Manual Export (Sigurniji za credentials)**

1. Eksportuj settings:
   - `settings.json` → Google Drive
   - `.credentials.json` → Sigurno mjesto (NOT public Git!)

2. Chat history:
   - `history.jsonl` → Google Drive (može biti veliki fajl)

---

### 4. **Obsidian Vault** (Ako ga koristiš)

**Lokacija:** `C:\WuffUniversuM\Basic Memory i Obsidian\WuffUniversuM Vault\`

**Backup Strategy:**
- Već sync-ovan sa basic-memory MCP serverom
- Ili kreiraj Git repo za vault

```bash
cd "C:\WuffUniversuM\Basic Memory i Obsidian\WuffUniversuM Vault"
git init
git add -A
git commit -m "Initial vault backup"
gh repo create wuff-obsidian-vault --private --source=. --push
```

---

## 🔄 RECOVERY PLAN - Novi PC Setup

### Step 1: Instalacija Osnovnih Alata

```bash
# 1. Instaliraj Git
winget install --id Git.Git

# 2. Instaliraj Node.js (za MCP servere)
winget install --id OpenJS.NodeJS

# 3. Instaliraj GitHub CLI
winget install --id GitHub.cli

# 4. Instaliraj Claude Code CLI
npm install -g @anthropic-ai/claude-code
```

### Step 2: GitHub Login

```bash
gh auth login --web
```

### Step 3: Restore Projekata

```bash
# 1. Kreiraj strukturu
mkdir "C:\Claude Code Projects\MCPs"
mkdir "C:\Claude Code Projects\Projects"

# 2. Clone Koding projekat
cd "C:\Claude Code Projects\Projects"
gh repo clone emircenga-cmd/Koding Koding

# 3. Clone basic-memory MCP server
cd "C:\Claude Code Projects\MCPs"
gh repo clone emircenga-cmd/basic-memory

# 4. Install basic-memory dependencies
cd basic-memory
npm install
npm run build
```

### Step 4: Restore Claude Code System Folder

**Option A: From Google Drive Backup**
```bash
# Copy cijeli .claude folder sa Google Drive
robocopy "C:\Users\emirv\Google Drive\.claude-backup" "C:\Users\emirv\.claude" /MIR
```

**Option B: Manual Setup**
```bash
# 1. Kreiraj .claude folder
mkdir "C:\Users\emirv\.claude"

# 2. Login u Claude Code (kreira .credentials.json)
claude-code login

# 3. Restore settings.json sa backup-a
cp "backup/settings.json" "C:\Users\emirv\.claude\settings.json"
```

### Step 5: Configure MCP Servers

Kreiraj global MCP config (ako ne postoji):

**File:** `C:\Users\emirv\.claude\.mcp.json`
```json
{
  "mcpServers": {
    "basic-memory": {
      "command": "node",
      "args": ["C:/Claude Code Projects/MCPs/basic-memory/build/index.js"],
      "env": {
        "MEMORY_DIR": "C:/Claude Code Projects/MCPs/basic-memory/memory"
      }
    }
  }
}
```

### Step 6: Verify Setup

```bash
# 1. Check Git
git --version

# 2. Check Node.js
node --version

# 3. Check GitHub CLI
gh --version

# 4. Check Claude Code
claude-code --version

# 5. Test Koding project
cd "C:\Claude Code Projects\Projects\Koding"
git status

# 6. Start Claude Code in Koding project
claude-code chat
```

---

## 📋 BACKUP CHECKLIST (Weekly)

- [ ] Push Koding projekat na GitHub (`git push`)
- [ ] Push basic-memory memory files (`cd MCPs/basic-memory && git push`)
- [ ] Backup `.claude` folder na Google Drive
- [ ] (Optional) Backup Obsidian vault ako ima izmjena

---

## 🚨 EMERGENCY - Brza Obnova

Ako hitno trebaš samo kod (bez historije):

```bash
# Clone samo projekte
gh repo clone emircenga-cmd/Koding
gh repo clone emircenga-cmd/basic-memory

# Login u Claude Code
claude-code login

# Gotovo - možeš raditi!
```

---

## 📝 VAŽNE NAPOMENE

1. **NE commituj `.credentials.json` u javni Git repo!** - sadrži sensitive tokens
2. **Chat history** (`history.jsonl`) može biti veliki - selective backup
3. **Google Drive** sync može biti automatski sa Google Drive Desktop app
4. **GitHub private repos** za sensitive data (.credentials.json, configs)

---

## 🔐 SECURITY BEST PRACTICES

- Koristi **private repos** za Claude config backup
- **Enkriptuj** `.credentials.json` prije backup-a
- Redovno **reviraj** šta je u backup-u (ne leak API keys)
- Koristi **2FA** za GitHub account
