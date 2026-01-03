# Obsidian Vault Setup - Projects Folder

**Last Updated:** 2026-01-03

## 📋 Svrha

Ovaj dokument objašnjava kako povezati Obsidian sa `C:\Claude Code Projects\Projects\` folderom kao master vault.

---

## 🎯 Šta ćeš dobiti

Kada otvoriš Projects folder u Obsidian-u:

✅ **Vidiš sve markdown fajlove** iz svih projekata (Koding, Orkestrator, 00_SYSTEM)
✅ **Wikilinks rade** - možeš linkati notes između projekata
✅ **Graph view** - vidiš sve povezanosti između dokumenata
✅ **Unified search** - pretraživanje kroz sve projekte odjednom
✅ **Git ostaje funkcionalan** - svaki projekat ima svoj .git folder
✅ **basic-memory sync** - sve .md izmjene automatski vidljive Claude-u

---

## 🔧 Setup Process

### Korak 1: Zatvori trenutni vault (ako je otvoren)

1. Otvori Obsidian
2. Klikni **Settings** (dolje lijevo - zupčanik)
3. Klikni **Close vault** (na dnu)

### Korak 2: Otvori Projects folder kao novi vault

1. Obsidian će pokazati **Vault switcher**
2. Klikni **Open folder as vault**
3. Navigate do:
   ```
   C:\Claude Code Projects\Projects\
   ```
4. Klikni **Select Folder**

### Korak 3: Konfiguracija (Optional, ali preporučujem)

#### Settings → Files & Links

- **Default location for new notes:** `00_SYSTEM/Session-Notes/`
  *(Ili bilo koji drugi folder gdje želiš da se kreiraju novi notes)*

- **New link format:** `Shortest path possible`
  *(Omogućava linkanje između projekata)*

- **Use [[Wikilinks]]:** ✅ Uključeno
  *(Standard Obsidian linking)*

#### Settings → Appearance

- **Theme:** Po želji (Light/Dark)
- **Show file extensions:** ✅ Uključeno *(lakše vidiš .md fajlove)*

#### Settings → Core plugins

Preporučeni plugini:
- ✅ **File explorer** - navigacija kroz folder strukturu
- ✅ **Search** - pretraga kroz sve projekte
- ✅ **Graph view** - vizualizacija linkova
- ✅ **Backlinks** - vidi gdje je note linkovan
- ✅ **Outline** - pregled headings u note-u

---

## 📂 Folder Struktura u Obsidian-u

Kada otvoriš vault, vidjet ćeš:

```
Projects/ (root vault)
│
├── 00_SYSTEM/                    # System-wide dokumentacija
│   ├── Session-Notes/            # Notes iz Claude sesija
│   ├── OBSIDIAN-VAULT-SETUP.md   # This file
│   └── .bmignore
│
├── 01_ARCHIVES/                  # Arhivirani projekti
│   └── .bmignore
│
├── Koding/                       # Dev & Support projekt
│   ├── docs/                     # Project docs
│   │   ├── WUFF-MASTER-BLUEPRINT-v1.0.md
│   │   ├── PROJECT_MEMORY.md
│   │   └── ...
│   ├── test/                     # Research notes
│   │   ├── FINALNA ARHITEKTURA.md
│   │   ├── Gemini deep research.md
│   │   └── ...
│   ├── knowledge/                # Ongoing knowledge
│   ├── .git/                     # Git repo (NEVIDLJIVO)
│   ├── .bmignore                 # basic-memory filter
│   ├── CLAUDE.md                 # Claude Code context
│   └── README.md
│
└── Orkestrator/                  # Future orchestrator projekt
    ├── planning.md               # (placeholder)
    └── .bmignore
```

**Napomena:** `.git`, `.claude`, `src/`, i ostali folderi su **sakriveni** u Obsidian-u jer ih `.bmignore` filtrira.

---

## 🔗 Kako raditi sa Wikilinks

### Kreiranje linka između projekata

U `Koding/docs/PROJECT_MEMORY.md` možeš linkati:

```markdown
Za više detalja vidi [[FINALNA ARHITEKTURA - Orchestrator i Sub-Agenti]]
```

Obsidian će automatski pronaći taj fajl u `Koding/test/` folderu!

### Kreiranje novog note-a

1. **Ctrl + N** → kreira novi note u default folderu
2. **Desni klik na folder** → "New note" → kreira u tom folderu

---

## ⚙️ Integracija sa Claude Code i basic-memory

### Kako sve radi zajedno:

```
Claude Code kreiranje fajla:
  → C:\Claude Code Projects\Projects\Koding\docs\architecture.md

basic-memory automatski vidi:
  ✅ architecture.md (indexira sadržaj)
  ❌ .git (ignoriše)
  ❌ src/ (ignoriše)

Obsidian vault:
  ✅ architecture.md (vidi i može editati)
  ✅ Wikilinks rade
  ✅ Graph view pokazuje veze

Git tracking:
  ✅ git status vidi izmjene
  ✅ git commit funkcioniše normalno
```

**Rezultat: JEDAN fajl, ČETIRI alata, ZERO duplikacija!**

---

## 🚨 Troubleshooting

### Obsidian ne vidi neke fajlove

**Problem:** `.bmignore` možda blokira nešto što želiš vidjeti
**Fix:** Provjeri `.bmignore` u tom projektu i ukloni red koji blokira

### Wikilinks ne rade

**Problem:** Settings → Files & Links → "Use [[Wikilinks]]" nije uključeno
**Fix:** Uključi wikilinks u settings

### Novi notes se kreiraju na pogrešnom mjestu

**Problem:** Default location for new notes nije postavljen
**Fix:** Settings → Files & Links → postavi default folder

### Obsidian spor sa velikim vaultom

**Problem:** Indeksira previše fajlova
**Fix:** Dodaj `.obsidian` folder exceptions u `.bmignore` (već podešeno)

---

## ✅ Verifikacija - Da li sve radi?

Nakon setup-a, provjeri:

1. **File explorer u Obsidian** pokazuje:
   - ✅ `00_SYSTEM` folder
   - ✅ `Koding` folder sa `docs/` i `test/`
   - ✅ `Orkestrator` folder
   - ❌ **NE vidiš** `.git`, `src/`, `node_modules/` (ignorirano)

2. **Search** (Ctrl + Shift + F):
   - Pretraži "orchestrator"
   - Trebao bi vidjeti rezultate iz više projekata

3. **Graph view** (Ctrl + G):
   - Vidiš nodes za sve .md fajlove
   - Ako imaš wikilinks, vidiš veze između njih

4. **Kreiranje novog note** (Ctrl + N):
   - Kreira note u `00_SYSTEM/Session-Notes/` (ili gdje si postavio default)

---

## 📝 Best Practices

### 1. Organizacija notes-a

- **00_SYSTEM/** → System-wide setup, configs, guides
- **Koding/docs/** → Official project documentation
- **Koding/test/** → Research, experiments, draft notes
- **Koding/knowledge/** → Ongoing knowledge management

### 2. Linkanje između projekata

Koristi **wikilinks** za povezivanje notes-a:
```markdown
See [[Sub-Agent System Prompts]] for details
```

### 3. Tagging

Koristi **tags** za organizaciju:
```markdown
#research #architecture #claude-code
```

### 4. Daily notes (Optional)

Ako želiš daily notes:
- Settings → Daily notes plugin
- Template location: `00_SYSTEM/Templates/daily-note.md`
- New file location: `00_SYSTEM/Session-Notes/`

---

## 🎉 Gotovo!

Sada imaš:
- ✅ Unified Obsidian vault koji vidi sve projekte
- ✅ basic-memory koji indeksira sve .md fajlove
- ✅ Git koji prati izmjene po projektu
- ✅ Claude Code koji kreira fajlove na pravom mjestu

**Enjoy seamless knowledge management! 🚀**
