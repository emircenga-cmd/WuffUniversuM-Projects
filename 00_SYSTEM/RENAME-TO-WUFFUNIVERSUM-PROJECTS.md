# Rename: Projects → WuffUniversuM-Projects

**Date:** 2026-01-03
**Status:** ⚠️ REQUIRES MANUAL STEPS

---

## ✅ Šta je Već Urađeno

1. ✅ **GitHub repo renamed:** `Koding` → `WuffUniversuM-Projects`
2. ✅ **Repo description updated:** "Multi-project knowledge base and development workspace"
3. ✅ **Git moved to root:** `.git` premješten iz `Koding/` u `Projects/`
4. ✅ **Git remote updated:** `https://github.com/emircenga-cmd/WuffUniversuM-Projects.git`

---

## ⚠️ Šta Treba Uraditi RUČNO

### Problem:
Folder `C:\Claude Code Projects\Projects\` je **zaključan** - neka aplikacija ga drži otvorenim.

**Razlog:** Claude Code sesija, Obsidian, ili File Explorer drži folder.

---

## 🔧 FINALNI KORACI (Po Redu!)

### Korak 1: **Exit iz Claude Code**

```bash
# U terminalu:
exit
```

---

### Korak 2: **Zatvori SVE aplikacije**

- ❌ Claude Desktop (potpuno zatvori)
- ❌ Obsidian (ako je otvoren)
- ❌ File Explorer (zatvori sve prozore)
- ❌ VS Code (ako ima otvoren Projects folder)

---

### Korak 3: **Ručno Rename Folder**

**Metoda A: File Explorer**
```
1. Open File Explorer
2. Navigate to: C:\Claude Code Projects\
3. Right-click: "Projects"
4. Rename → "WuffUniversuM-Projects"
```

**Metoda B: PowerShell (Admin)**
```powershell
Rename-Item -Path "C:\Claude Code Projects\Projects" -NewName "WuffUniversuM-Projects"
```

**Nova putanja:**
```
C:\Claude Code Projects\WuffUniversuM-Projects\
├── .git\              # ← Root Git repo (track-uje SVE)
├── 00_SYSTEM\
├── 01_ARCHIVES\
├── Koding\            # ← VIŠE NEMA .git (moved to root)
└── Orkestrator\
```

---

### Korak 4: **Update basic-memory Config**

**File:** `C:\Users\emirv\.basic-memory\config.json`

**Promijeni:**
```json
{
  "projects": {
    "wuff-projects": "C:\\Claude Code Projects\\WuffUniversuM-Projects"
  }
}
```

**Prije:**
```json
"wuff-projects": "C:\\Claude Code Projects\\Projects"
```

**Poslije:**
```json
"wuff-projects": "C:\\Claude Code Projects\\WuffUniversuM-Projects"
```

---

### Korak 5: **Update Backup Skripte**

**File:** `C:\Claude Code Projects\WuffUniversuM-Projects\00_SYSTEM\auto-backup-projects.ps1`

**Promijeni:**
```powershell
$projectPath = "C:\Claude Code Projects\WuffUniversuM-Projects"
$logFile = "C:\Claude Code Projects\WuffUniversuM-Projects\00_SYSTEM\backup.log"
```

**Prije:**
```powershell
$projectPath = "C:\Claude Code Projects\Projects\Koding"
```

**Poslije:**
```powershell
$projectPath = "C:\Claude Code Projects\WuffUniversuM-Projects"
```

---

**File:** `C:\Claude Code Projects\WuffUniversuM-Projects\00_SYSTEM\setup-auto-backup-task.ps1`

**Promijeni:**
```powershell
$scriptPath = "C:\Claude Code Projects\WuffUniversuM-Projects\00_SYSTEM\auto-backup-projects.ps1"
```

---

### Korak 6: **Delete Old Backup Task (Admin PowerShell)**

```powershell
# Run as Administrator
Unregister-ScheduledTask -TaskName "ObsidianVaultsAutoBackup" -Confirm:$false
```

---

### Korak 7: **Setup New Backup Task (Admin PowerShell)**

```powershell
# Navigate to folder
cd "C:\Claude Code Projects\WuffUniversuM-Projects\00_SYSTEM"

# Run setup script
.\setup-auto-backup-task.ps1
```

**Expected:** Task `ProjectsAutoBackup` kreiran (svaka 5 sati)

---

### Korak 8: **Reset basic-memory Database (Clean Start)**

```bash
# Delete old index
rm "C:\Users\emirv\.basic-memory\memory.db"

# basic-memory će kreirati novi index sa ispravnim paths
```

---

### Korak 9: **Test Git Setup**

```bash
cd "C:\Claude Code Projects\WuffUniversuM-Projects"
git status
```

**Expected:**
```
On branch master
Your branch is up to date with 'origin/master'.
```

**Provjeri da Git track-uje SVE foldere:**
```bash
git ls-files | head -20
```

**Expected:** Vidiš fajlove iz `00_SYSTEM/`, `Koding/`, itd.

---

### Korak 10: **Initial Commit sa Novom Strukturom**

```bash
cd "C:\Claude Code Projects\WuffUniversuM-Projects"

git add -A

git commit -m "Restructure: Move Git to root, rename to WuffUniversuM-Projects

CHANGES:
- Moved .git from Koding/ to root (now tracks all projects)
- Renamed folder and repo: Projects → WuffUniversuM-Projects
- Updated backup scripts
- Root-level Git repo now tracks:
  - 00_SYSTEM/ (documentation)
  - Koding/ (dev project)
  - Orkestrator/ (future project)

BENEFIT:
- Unified version control for entire workspace
- All documentation backed up
- Multi-project support

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

git push origin master
```

---

### Korak 11: **Fresh Restart**

**Restart Claude Desktop:**
```
1. Potpuno zatvori Claude Desktop
2. Ponovo otvori
3. basic-memory će re-indeksirati sa novim paths
```

**Restart Claude Code CLI:**
```bash
cd "C:\Claude Code Projects\WuffUniversuM-Projects"
claude-code chat
```

---

## 🧪 Verifikacija

### Test 1: basic-memory

**U Claude Desktop:**
```
List all markdown files in wuff-projects
```

**Expected:** Vidi .md fajlove iz novog path-a

---

### Test 2: Git

```bash
cd "C:\Claude Code Projects\WuffUniversuM-Projects"
git status
git log -1
```

**Expected:**
- Git repo u root-u
- Vidi commit sa restructure message

---

### Test 3: Auto-Backup

```bash
# Check scheduled task
powershell.exe -Command "Get-ScheduledTask -TaskName ProjectsAutoBackup"
```

**Expected:** Task Status = Ready

---

## 📊 Before vs After

### BEFORE (Staro)

```
C:\Claude Code Projects\Projects\
├── Koding\
│   ├── .git\           # Git repo SAMO za Koding
│   └── ...
├── 00_SYSTEM\          # NE verzionisano
└── Orkestrator\        # NE verzionisano

GitHub: emircenga-cmd/Koding
basic-memory: Points to "Projects"
```

### AFTER (Novo)

```
C:\Claude Code Projects\WuffUniversuM-Projects\
├── .git\               # Root Git repo (SVE verzionisano)
├── 00_SYSTEM\          # ✅ Verzionisano
├── Koding\             # ✅ Verzionisano
└── Orkestrator\        # ✅ Verzionisano

GitHub: emircenga-cmd/WuffUniversuM-Projects
basic-memory: Points to "WuffUniversuM-Projects"
```

---

## ✅ Final Checklist

Nakon svih koraka, provjeri:

- [ ] Folder renamed: `WuffUniversuM-Projects`
- [ ] basic-memory config updated
- [ ] Backup skripte updated
- [ ] Old backup task deleted
- [ ] New backup task created
- [ ] memory.db reset
- [ ] Git commit pushed
- [ ] Claude Desktop restart
- [ ] Claude Code CLI restart
- [ ] basic-memory vidi sve .md fajlove
- [ ] Git track-uje sve projekte

---

## 🚨 Troubleshooting

### Folder još uvijek zaključan

**Problem:** Ne mogu rename
**Fix:**
```powershell
# Check što drži folder
handle.exe "C:\Claude Code Projects\Projects"

# Ili restart računara (nuklearno rješenje)
```

### basic-memory ne vidi fajlove

**Problem:** Stari path u config.json
**Fix:**
```bash
cat "C:\Users\emirv\.basic-memory\config.json"
# Provjeri da path kaže: WuffUniversuM-Projects
```

### Git push fails

**Problem:** Remote URL nije updated
**Fix:**
```bash
git remote -v
# Expected: emircenga-cmd/WuffUniversuM-Projects

# Ako je krivo:
git remote set-url origin https://github.com/emircenga-cmd/WuffUniversuM-Projects.git
```

---

**🎯 NAKON ŠTO ZAVRŠIŠ SVE KORAKE - IMAŠ CLEAN UNIFIED WORKSPACE! 🎯**
