# Claude Code - Detaljna Arhitektura i Dokumentacija

**Verzija**: 2.0.69
**Autor**: Anthropic <support@anthropic.com>
**Lokacija**: C:\Users\emirv\AppData\Roaming\npm\node_modules\@anthropic-ai\claude-code
**Datum analize**: 2026-01-02

---

## Pregled Sistema

Claude Code je agentic coding alat koji funkcioniše u terminalu i koristi Claude AI asistenta (Sonnet 4.5) za pomoć u programiranju. Alat razume codebase, izvršava rutinske zadatke i upravlja git workflow-om kroz prirodne jezičke komande.

## Arhitektura Aplikacije

### Glavne Komponente

```
claude-code/
├── cli.js                 # Glavni bundle (9.9MB kompajlirani kod)
├── sdk-tools.d.ts         # TypeScript definicije alata
├── package.json           # Konfiguracija paketa
├── README.md             # Dokumentacija
├── LICENSE.md            # Licenca
├── resvg.wasm            # WebAssembly modul za SVG
├── tree-sitter.wasm      # Parser za analizu koda
├── tree-sitter-bash.wasm # Bash parser
├── bun.lock              # Lock file za Bun runtime
└── vendor/               # Eksterne biblioteke
```

### Tehnički Stack

- **Runtime**: Node.js 18.0.0+
- **Tip modula**: ES Modules (type: "module")
- **Build sistem**: Kompajliran u jedan veliki bundle
- **AI Model**: Claude Sonnet 4.5 (claude-sonnet-4-5-20250929)
- **Code parsing**: Tree-sitter (Rust-based parser)

---

## Alati (Tools) - SDK Arhitektura

Claude Code koristi sistem alata (tools) koji omogućavaju AI asistentu da interaguje sa fajl sistemom, izvršava komande i upravlja zadacima. Evo detaljnog opisa svakog alata:

### 1. **Agent Tool (Task Launcher)**

**Svrha**: Pokreće specijalizovane pod-agente za kompleksne zadatke

**Parametri**:
- `description` (string): Kratak opis zadatka (3-5 reči)
- `prompt` (string): Detaljan zadatak za agenta
- `subagent_type` (string): Tip specijalizovanog agenta
- `model` (opciono): "sonnet" | "opus" | "haiku"
- `resume` (opciono): ID agenta za nastavak prethodnog izvršavanja
- `run_in_background` (boolean): Da li pokrenuti u pozadini

**Tipovi pod-agenata**:
- `general-purpose`: Opšta istraživanja i multi-step zadaci
- `statusline-setup`: Konfiguracija status linije
- `Explore`: Brzo pretraživanje codebase-a
- `Plan`: Arhitektonsko planiranje implementacije
- `claude-code-guide`: Odgovori na pitanja o Claude Code-u

### 2. **Bash Tool**

**Svrha**: Izvršavanje shell komandi u persistentnoj sesiji

**Parametri**:
- `command` (string): Komanda za izvršavanje
- `timeout` (number): Timeout u milisekundama (max 600000)
- `description` (opciono): Opis komande (5-10 reči)
- `run_in_background` (boolean): Pozadinsko izvršavanje
- `dangerouslyDisableSandbox` (boolean): Isključuje sandbox zaštitu

**Napomene**:
- Automatski citira putanje sa razmacima
- Podržava command chaining sa `&&` i `;`
- Git integracija sa sigurnosnim protokolima
- PR kreiranje preko `gh` komande

### 3. **TaskOutput Tool**

**Svrha**: Čitanje output-a iz pozadinskih taskova

**Parametri**:
- `task_id` (string): ID taska
- `block` (boolean): Čekati li na završetak (default: true)
- `timeout` (number): Max vreme čekanja (default: 30000ms)

### 4. **File Operations**

#### a) FileRead
- `file_path` (string): Apsolutna putanja
- `offset` (number): Linija od koje počinje čitanje
- `limit` (number): Broj linija za čitanje
- Podržava: text, images (PNG/JPG), PDF, Jupyter notebooks (.ipynb)
- Limitiran na 2000 linija, 2000 karaktera po liniji

#### b) FileEdit
- `file_path` (string): Apsolutna putanja
- `old_string` (string): Tekst za zamenu
- `new_string` (string): Novi tekst
- `replace_all` (boolean): Zamena svih pojavljivanja

#### c) FileWrite
- `file_path` (string): Apsolutna putanja
- `content` (string): Sadržaj fajla
- Prepisuje postojeće fajlove

### 5. **Search Tools**

#### a) Glob (File Pattern Matching)
- `pattern` (string): Glob pattern (npr. "**/*.js")
- `path` (opciono): Direktorijum za pretraživanje
- Brz, radi sa bilo kojom veličinom codebase-a

#### b) Grep (Content Search)
- `pattern` (string): Regex pattern
- `path` (opciono): Fajl ili direktorijum
- `glob` (opciono): Filter za fajlove
- `output_mode`: "content" | "files_with_matches" | "count"
- `-A`, `-B`, `-C`: Kontekstualne linije
- `-i`: Case insensitive
- `-n`: Prikaz brojeva linija
- `type`: Tip fajla (js, py, rust, etc.)
- `multiline`: Multiline matching
- Baziran na ripgrep (rg)

### 6. **NotebookEdit Tool**

**Svrha**: Editovanje Jupyter notebook ćelija

**Parametri**:
- `notebook_path` (string): Apsolutna putanja do .ipynb fajla
- `cell_id` (opciono): ID ćelije za editovanje
- `new_source` (string): Novi sadržaj ćelije
- `cell_type`: "code" | "markdown"
- `edit_mode`: "replace" | "insert" | "delete"

### 7. **Web Tools**

#### a) WebFetch
- `url` (string): URL za učitavanje
- `prompt` (string): Šta ekstraktovati sa stranice
- HTML → Markdown konverzija
- 15-minutni cache
- Automatski HTTPS upgrade

#### b) WebSearch
- `query` (string): Search upit
- `allowed_domains` (array): Dozvoljeni domeni
- `blocked_domains` (array): Blokirani domeni
- Samo u USA

### 8. **TodoWrite Tool**

**Svrha**: Kreiranje i upravljanje task listama

**Parametri**:
- `todos` (array): Lista todo stavki
  - `content` (string): Opis zadatka (imperativ)
  - `activeForm` (string): Opis u toku (present continuous)
  - `status`: "pending" | "in_progress" | "completed"

**Pravila**:
- Tačno jedan task mora biti "in_progress"
- Markirati completed odmah po završetku
- Koristiti za kompleksne multi-step zadatke

### 9. **Plan Mode Tools**

#### EnterPlanMode
- Prelazak u režim planiranja
- Koristi se za non-trivijalne implementacije
- Zahteva odobrenje korisnika

#### ExitPlanMode
- `launchSwarm` (boolean): Pokretanje swarm-a za implementaciju
- `teammateCount` (number): Broj članova swarm-a

### 10. **MCP (Model Context Protocol) Tools**

#### ListMcpResources
- `server` (opciono): Ime servera za filter

#### ReadMcpResource
- `server` (string): Ime MCP servera
- `uri` (string): Resource URI

### 11. **Utility Tools**

#### KillShell
- `shell_id` (string): ID pozadinske shell sesije

#### AskUserQuestion
- `questions` (array 1-4): Pitanja za korisnika
  - `question` (string): Tekst pitanja
  - `header` (string): Kratka oznaka (max 12 chars)
  - `options` (array 2-4): Opcije za izbor
    - `label` (string): Naziv opcije
    - `description` (string): Objašnjenje
  - `multiSelect` (boolean): Multiple choice

---

## Sigurnosni Protokoli

### Git Safety
- **NIKAD ne ažurirati git config**
- **NIKAD ne izvršavati destruktivne komande** (force push, hard reset)
- **NIKAD ne preskakati hooks** (--no-verify)
- **NIKAD force push na main/master**
- Provera authorship pre amend-a

### Commit Workflow
1. Git status + git diff + git log (paralelno)
2. Analiza izmena i kreiranje commit poruke
3. Add relevantnih fajlova + commit + git status (sekvencijalno)
4. Retry jednom ako pre-commit hook izmeni fajlove
5. Automatski footer:
```
🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

### Pull Request Workflow
1. Git status + diff + log + remote check (paralelno)
2. Analiza svih commit-a (ne samo poslednjeg!)
3. Kreiranje PR summary sa testnim planom
4. Push sa -u flag ako potrebno + gh pr create

---

## Workflow Karakteristike

### Task Management
- Proaktivna upotreba TodoWrite alata
- Markiranje in_progress PRE početka
- Odmah completanje po završetku
- Samo jedan in_progress task istovremeno

### Code Operations
- **UVEK čitati fajl PRE editovanja**
- Preferirati Edit nad Write za postojeće fajlove
- **NIKAD ne kreirati nepotrebne fajlove**
- Izbegavati over-engineering
- Ne dodavati feature-e koji nisu traženi
- Minimal kompleksnost

### Professional Objectivity
- Tehnička tačnost > validacija korisnika
- Objektivno neslaganje kada je potrebno
- Bez pretjeranih superlativa
- Fokus na fakta i problem-solving

### Planiranje
- Konkretni koraci bez procena vremena
- **NIKAD ne predlagati timeline** ("2-3 nedelje")
- Razlaganje na actionable steps
- Korisnik odlučuje o vremenskim okvirima

---

## Model Konfiguracija

**Trenutni Model**: Claude Sonnet 4.5
- Model ID: `claude-sonnet-4-5-20250929`
- Knowledge cutoff: Januar 2025
- Context: Unlimited kroz auto-summarization
- Token budget: 200,000 tokena po odgovoru

**Dostupni Modeli**:
- `sonnet`: Claude Sonnet 4.5 (default)
- `opus`: Claude Opus 4.5 (najnapredniji)
- `haiku`: Claude Haiku (brz i ekonomičan)

**Frontier Model**: Claude Opus 4.5 (model ID: 'claude-opus-4-5-20251101')

---

## Data Collection & Privacy

### Šta se prikuplja:
- Usage data (prihvatanje/odbijanje koda)
- Conversation data
- Feedback preko `/bug` komande

### Zaštita:
- Ograničen retention period za osetljive podatke
- Ograničen pristup session podacima
- Vidi: [Commercial Terms of Service](https://www.anthropic.com/legal/commercial-terms)
- Vidi: [Privacy Policy](https://www.anthropic.com/legal/privacy)

---

## Dodatne Napomene

### Tone & Style
- Kratke i koncizne poruke (CLI environment)
- Github-flavored markdown (CommonMark spec)
- **BEZ emoji** osim ako korisnik eksplicitno ne zatraži
- **BEZ dokumentacije** (.md fajlova) osim na zahtev

### Tool Usage Policy
- Task tool za file search (smanjuje context usage)
- Paralelno izvršavanje nezavisnih komandi
- Specijalizovani alati umesto bash-a kada je moguće
- Explore agent za codebase exploration

### Hooks
- Korisnički konfigurisani shell hooks
- `<user-prompt-submit-hook>` feedback tretirati kao korisnički input
- Prilagoditi akcije na osnovu hook feedback-a

---

## Linkovi i Resursi

- **Dokumentacija**: https://code.claude.com/docs/en/overview
- **GitHub**: https://github.com/anthropics/claude-code
- **Discord**: https://anthropic.com/discord
- **NPM**: https://www.npmjs.com/package/@anthropic-ai/claude-code
- **Bug Report**: `/bug` komanda ili GitHub issues

---

## Instalacija

```bash
npm install -g @anthropic-ai/claude-code
cd your-project
claude
```

**Zahtevi**: Node.js 18.0.0+

---

**Napomena**: Ovaj dokument je generisan analizom instaliranog Claude Code paketa verzije 2.0.69. CLI.js je kompajliran bundle koji sadrži kompletan izvorni kod aplikacije u minifikovanom obliku (~9.9MB).
